.PHONY: all clean copy stadga mallar

# Note: the $< variable is the 1st "argument" to the target while
# $@ is the target.
#
# The output directory, relative to the Makefile
builddir=build
# The base command that should be run. Note that you can override -outdir
# in the individual targets.
latexmk=latexmk -outdir=$(builddir)/$@ -f -quiet -silent -pdf -xelatex -use-make-
# The dir that the finished pdfs should be copied into. Relative to this filek
copydir=../

all: stadga mallar

stadga: stadga/stadga.tex
	$(latexmk) $<

mallar: mallar/
	$(latexmk) $<askningsmall.tex

copy:
	rsync -a $(builddir)/ $(copydir) --include "*.pdf" --include "*/" --exclude "*"

clean:
	find $(builddir) ! -name "*.pdf" -type f -delete
