(import (scheme base)
        (scheme read)
        (scheme write)
        (scheme file)
        (arvyy mustache))


(include "util.scm")

(define implementations (with-input-from-file "implementations.scm" (lambda () (read))))
(define tmpdir "/tmp/schemers-docker-images")
(define debian-dockerfile (compile (slurp "templates/Dockerfile.debian")))
(define makefile-job (compile (slurp "templates/Makefile-job")))

(call-with-output-file
  "Makefile.generated"
  (lambda (makefile-out)
    (for-each
      (lambda (implementation)
        (let* ((hyphen-tag (string-replace (cdr (assoc 'tag implementation))
                                                        #\:
                                                        #\-))
               (dockerfile-path (string-append "generated-dockerfiles/Dockerfile." hyphen-tag)))
          (call-with-output-file
            dockerfile-path
            (lambda (dockerfile-out)
              (execute debian-dockerfile implementation dockerfile-out)))
          (execute makefile-job
                   `((job-name . ,hyphen-tag)
                     (tag . ,(cdr (assoc 'tag implementation)))
                     (add-java? . ,(if (and (assoc 'add-java? implementation)
                                            (cdr (assoc 'add-java? implementation)))
                                     "true"
                                     "false"))
                     (dockerfile . ,dockerfile-path))
                   makefile-out)
          ))
      implementations)))

