Resume Template
===============

A resume template that uses [markdown][markdown] and [pandoc][pandoc] to
generate an HTML version, which can be used to make a PDF.

[markdown]: https://en.wikipedia.org/wiki/Markdown
[pandoc]: http://pandoc.org/

Dependencies
------------

Minimum requirements:

  * [GNU Make][make] - Command line tool to build the resume.
  * [pandoc][pandoc] - Renders the markdown into HTML.
  * [rsync][rsync] - Syncs assets to the build directory

[make]: https://www.gnu.org/software/make/
[rsync]: https://wiki.archlinux.org/index.php/rsync

Optional dependencies:

  * [Python 3.x][python] - To start a simple server to view the HTML version of
      the resume.
  * [wkhtmltopdf][wkhtmltopdf] - To produce a PDF version of the resume from the
      command line.

[python]: https://www.python.org/
[wkhtmltopdf]: http://wkhtmltopdf.org/

This project is intended to run on UNIX-like systems.  It might be possible to
run on Windows, but this is not supported.

Using Nix to setup your environment
-----------------------------------

This project comes with a `default.nix` file that helps you setup your
development environment.

If you want to setup your environment with Nix, install the [Nix package
manager][nix].  Then run the following from your project directory:

```sh
[~/proj/resume-template]$ nix-shell .
```

This will give you a shell with all the dependencies available.  See the Nix
wiki page on [Development Environments][nix-dev-env] for more information.

[nix]: https://nixos.org/nix/
[nix-dev-env]: https://nixos.org/wiki/Development_Environments

Running
-------

From the root of the project directory (in this directory, the project root is
`~/proj/resume-template`), running the following will display the help text:

```sh
[~/proj/resume-template]$ make
Please use `make <target>` where <target> is one of
  clean      to clean the build directory
  html       to make standalone HTML files
  serve      to run a simple http server to view the HTML version
  pdf        to use wkhtmltopdf to produce a PDF version
```

The help text provides a list of targets available and brief descriptions of
each.

To generate the HTML version of the resume, run the following:

```sh
[~/proj/resume-template]$ make html
```

This will create the `build` directory in the root of the project if it doesn't
exist already and `resume.md` will be produced inside.

To generate the PDF version of the resume, run the following:

```sh
[~/proj/resume-template]$ make html
```

This will produce `resume.pdf` in the `build` directory.

Making it Your Own
------------------

This template is meant so that it can be used to easily produce new resumes or
at least provide a base to create your own markdown resume solution.

Feel free to fork this template and modify it to your liking.  If you update
your copy with personal information, I recommend storing your changes in a
private repository.

You will want to update `resume.md` with your own resume content.  The one
provided in the template is meant to be only a demo and does not reflect the
information of a real life person.

You will also want to update `img/logo.svg` to be your own personal graphic.
If you want to provide a graphic with a different name or extension (.jpg,
.jpeg, or .png for example), you'll need to update the `<img>` tag found in
`partials/before-body.html`.
