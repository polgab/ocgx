PDFLATEXMK = latexmk -pdf
ZIP = zip -9 -r

TARGETS= \
	doc/ocgx-manual-fr.pdf \
	doc/ocgx-manual-en.pdf \
	examples/demo-ocgx.pdf

all: $(TARGETS)

ctan-archive:
	rm -fr ctan-archive
	mkdir ctan-archive
	mkdir ctan-archive/ocgx
	cp ocgx.sty tikzlibraryocgx.code.tex README\
	   doc/ocgx-manual-en.tex doc/ocgx-manual-en.pdf \
	   doc/ocgx-example-1.tex \
	   examples/demo-ocgx.tex examples/demo-ocgx.pdf \
	   ctan-archive/ocgx/.
	mkdir ctan-archive/ocgx.tds
	mkdir -p ctan-archive/ocgx.tds/tex/latex/ocgx
	cp ocgx.sty tikzlibraryocgx.code.tex \
           ctan-archive/ocgx.tds/tex/latex/ocgx
	mkdir -p ctan-archive/ocgx.tds/doc/latex/ocgx
	cp README doc/ocgx-manual-en.pdf examples/demo-ocgx.pdf \
	   ctan-archive/ocgx.tds/doc/latex/ocgx
	mkdir -p ctan-archive/ocgx.tds/source/latex/ocgx
	cp doc/ocgx-manual-en.tex examples/demo-ocgx.tex \
           doc/ocgx-example-1.tex \
	   ctan-archive/ocgx.tds/source/latex/ocgx
	cd ctan-archive/ocgx.tds; \
	   $(ZIP) ../ocgx.tds.zip .;
	cd ctan-archive; \
	   $(ZIP) ocgx.zip ocgx.tds.zip ocgx

.PHONY : FORCE_MAKE ctan-archive

%.pdf : %.tex FORCE_MAKE
	@echo apply latekmk '=>' ${@}
	@cd $(dir ${@});\
	 TEXINPUTS=..: ${PDFLATEXMK} ${basename ${notdir ${@}}}.tex
