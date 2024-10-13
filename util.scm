(define slurp-loop
  (lambda (line result)
    (if (eof-object? line)
      result
      (slurp-loop (read-line) (string-append result line (string #\newline))))))

(define slurp
  (lambda (path)
    (with-input-from-file
      path
      (lambda ()
        (slurp-loop (read-line) "")))))

(define string-replace
  (lambda (str replace-character with-character)
    (string-map
      (lambda (character)
        (if (char=? character replace-character)
          with-character
          character))
      str)))


