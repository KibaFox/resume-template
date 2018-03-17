Resume/CV Template
==================

A resume/CV template that uses [Asciidoctor][asciidoctor] to transform your text
resume formatted in [AsciiDoc][asciidoc] into a professional looking PDF or HTML
resume/CV.

[asciidoc]: https://en.wikipedia.org/wiki/AsciiDoc
[asciidoctor]: https://asciidoctor.org/

Dependencies
------------

Dependencies:

  * [GNU Make][make] - Command line tool used to build the resume.
  * [Docker][docker] - Used to run Asciidoctor without having to install it.

If you do not wish yo run Docker, you can set the environment variable
`USE_DOCKER` to `false`.  You will have to install the following dependencies:

  * [Asciidoctor][asciidoctor]
  * [Asciidoctor PDF][asciidoctor-pdf]

This project is intended to run on Unix-like systems.  It might be possible to
run on Windows, but this is not supported.

Running
-------

From the root of the project directory (in this example, the project root is
`~/proj/resume-template`), running the following will display the help text:

    [~/proj/resume-template]$ make
    Resume/CV - Turn text into professional PDF or HTML resume/CV

    Usage: make <action>

    Actions:
      clean      to remove the output directory
      html       to make a standalone HTML version of the resume
      pdf        to produce a PDF version of the resume

    Environment variables
      NAME       the filename (without extension) of the output
                 (currently: jane-smith-resume)
      SOURCE     the source file to use as input
                 (currently: resume.adoc)
      OUTDIR     the directory where the generated files will be placed
                 (currently: dist)
      PAGE_SIZE  the page size for the PDF (example: Letter)
                 (currently: A4)
      USE_DOCKER if set to "true", will use docker to run generator
                 (currently: true)

    Example:
      $ export USE_DOCKER=true
      $ make pdf
        Resume/CV - Turn text into professional PDF or HTML resume/CV

The help text provides a list of actions available and brief descriptions of
each.

To generate the HTML version of the resume, run the following:

    [~/proj/resume-template]$ make html

This will create the `dist/` directory in the root of the project if it
doesn't exist already and `jane-smith-resume.html` will be produced inside. You
can view the resume by opening this file with your browser.

To generate the PDF version of the resume, run the following:

    [~/proj/resume-template]$ make pdf

This will create the file `dist/jane-smith-resume.pdf`.

Environment Variable Configuration
----------------------------------

There are environment variables that you can set that affect how your finish
product gets generated.  For example, setting the `NAME` variable to
`john-henry-cv` will make the output filenames be `john-henry-cv.pdf` and
`john-henry-cv.html` for the PDF and HTML versions respectively.  This can help
make your files identifiable from other people's when the person reviewing your
resume/cv downloads it.

On most Unix-based systems, you will be able to use the `env` command to set
environment variables for a single command.  If we want to generate the PDF
version of our resume with a personal name as part of the file name, we would
run something like the following:

    [~/proj/resume-template]$ env NAME=john-henry-cv pdf

Most shells let you export environment variables so you do not have to specify
them with the `env` command every time.  If you are using the bash, zsh, or
other POSIX compliant shell, then you can use the `export` command like so:

    [~/proj/resume-template]$ export NAME=john-henry-cv

If you are using [fish](https://fishshell.com/) you would use the `set` command
instead:

    [~/proj/resume-template]$ set -x NAME john-henry-cv

Exporting your environment variable makes it so the setting persists for all
commands until you change it again or unset it.

Making it Your Own
------------------

This template is meant so that it can be used to easily produce new resumes or
at least provide a base to create your own solution.

Feel free to fork this template and modify it to your liking.  If you update
your copy with personal information, I recommend storing your changes in
a private repository.

You will want to update `resume.adoc` with your own resume content.  The one
provided in the template is meant to be only a demo and does not reflect the
information of a real life person.

You will also want to update `img/logo.svg` to be your own personal graphic.  If
you want to provide a graphic with a different name or extension (.jpg, .jpeg,
or .png for example), you'll need to update the path to it in `resume.adoc`.

Note: Only the HTML version uses the `img/logo.svg`.  This is because there is
currently no way to do the same effect as `float="right"` in the PDF version.
Without it, the graphic takes up a lot of space.

You will probably want to update the default variable settings in the
`Makefile`.  Change the default value of the `NAME` variable to include your own
personal name.  This will help make your files names recognizable from
others when a reviewer downloads it.

If you are in the United States, you may also want to change the default value
of `PAGE_SIZE` to `Letter` so the PDF will be formatted to fit on "Letter"
(8.5in x 11in) size paper.
