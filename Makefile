SOURCE        = resume.md
BUILDDIR      = build
HTMLOUT       = $(BUILDDIR)/resume.html
PDFOUT        = $(BUILDDIR)/resume.pdf

.PHONY: help clean html pdf serve

help:
	@echo "Please use \`make <target>\` where <target> is one of"
	@echo "  clean      to clean the build directory"
	@echo "  html       to make standalone HTML files"
	@echo "  serve      to run a simple http server to view the HTML version"
	@echo "  pdf        to use wkhtmltopdf to produce a PDF version"

clean:
	rm -rf $(BUILDDIR)/*

html:
	mkdir -p $(BUILDDIR)
	rsync -q -r --delete css $(BUILDDIR)
	rsync -q -r --delete img $(BUILDDIR)
	pandoc -t html5 \
		-c https://cdn.jsdelivr.net/foundation/6.2.4/foundation.min.css \
		-c https://fonts.googleapis.com/css?family=Libre+Baskerville \
		-c css/resume.css \
		-B partials/before-body.html \
		-A partials/after-body.html \
		-s $(SOURCE) -o $(HTMLOUT)

pdf: html
	wkhtmltopdf --page-size 'Letter' --print-media-type $(HTMLOUT) $(PDFOUT)

serve: html
	(cd $(BUILDDIR); python3 -m http.server)
