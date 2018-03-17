# Environment Variable Defaults
NAME       ?= jane-smith-resume
SOURCE     ?= resume.adoc
OUTDIR     ?= dist
PAGE_SIZE  ?= A4
USE_DOCKER ?= true

# Utility
pdfout     := $(OUTDIR)/$(NAME).pdf
htmlout    := $(OUTDIR)/$(NAME).html
pkgout     := $(OUTDIR)/$(NAME).html.tar.gz

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
	@echo '  clean      to remove the output directory'
	@echo '  html       to make a standalone HTML version of the resume'
	@echo '  pdf        to produce a PDF version of the resume'
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

html:
	$(docker) asciidoctor \
		-a data-uri \
		-a nofooter \
		-o $(htmlout) \
		$(SOURCE)

pdf:
	$(docker) asciidoctor-pdf -s \
		-a pdf-page-size=$(PAGE_SIZE) \
		-o $(pdfout) \
		$(SOURCE)
