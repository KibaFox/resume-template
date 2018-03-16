# Environment Variable Defaults
NAME       ?= jane-smith-resume
SOURCE     ?= resume.adoc
OUTDIR     ?= dist
PAGE_SIZE  ?= A4
USE_DOCKER ?= true

# Utility
pkgout     := $(OUTDIR)/$(NAME).html.tar.xz
pdfout     := $(OUTDIR)/$(NAME).pdf
htmldir    := $(OUTDIR)/html
htmlout    := $(htmldir)/$(NAME).html
# htmldiresc is htmldir but with backslash escape on '/'
htmldiresc := $(subst /,\/,$(htmldir))

# Docker (if USE_DOCKER is "true")
asciidoctor_img = asciidoctor/docker-asciidoctor
ensure_ascidoctor_img = $(if $(shell docker images -q $(asciidoctor_img)),, \
	docker pull $(asciidoctor_img);)

ifeq ($(USE_DOCKER),true)
docker = $(ensure_ascidoctor_img) \
	docker run --rm \
		--name 'asciidoctor-resume' \
		-u $(shell id -u):$(shell id -g) \
		-v $(shell pwd):/documents/ \
		$(asciidoctor_img)
endif

.PHONY: help clean html pdf serve package

help:
	@echo 'Resume/CV - Turn text into professional PDF or HTML resume/CV'
	@echo ''
	@echo 'Usage: make <action>'
	@echo ''
	@echo 'Actions:'
	@echo '  clean      to clean the build directory and any built packages'
	@echo '  html       to make standalone HTML files'
	@echo '  pdf        to use wkhtmltopdf to produce a PDF version'
	@echo '  package    to create a compressed package of the HTML resume'
	@echo ''
	@echo 'Environment variables'
	@echo '  NAME       the filename (without extension) of the output'
	@echo '             (currently: $(NAME))'
	@echo '  SOURCE     the source file to use as input'
	@echo '             (currently: $(SOURCE))'
	@echo '  OUTDIR     the directory where the generated files will be placed'
	@echo '             (currently: $(OUTDIR))'
	@echo '  PAGE_SIZE  the page size for the PDF (example: Letter)'
	@echo '             (currently: $(PAGE_SIZE))'
	@echo '  USE_DOCKER if set to "true", will use docker to run generator'
	@echo '             (currently: $(USE_DOCKER))'
	@echo ''
	@echo 'Example:'
	@echo '  $$ export USE_DOCKER=true'
	@echo '  $$ make pdf'

clean:
	rm -rf $(OUTDIR)
	rm -f *.tar.xz

$(htmldir)/img: img
	mkdir -p $(htmldir)/img
	cp -r img $(htmldir)
	touch $(htmldir)/img

html: $(htmldir)/img
	$(docker) asciidoctor \
		-a nofooter \
		-o $(htmlout) \
		$(SOURCE)

pdf:
	$(docker) asciidoctor-pdf -s \
		-a pdf-page-size=$(PAGE_SIZE) \
		-o $(pdfout) \
		$(SOURCE)

package: html
	tar --transform 's/$(htmldiresc)/$(NAME)/' -c --xz -f $(pkgout) $(htmldir)
