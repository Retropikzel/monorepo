TMPDIR=/tmp/schemers-docker-images

build:
	mkdir -p generated-dockerfiles
	gosh -r7 -A . -A ./snow build.scm


clean:
	rm -rf generated-dockerfiles
	rm -rf Makefile.generated
