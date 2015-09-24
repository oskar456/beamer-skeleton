# Makefile.pdflatex
# Author:	Johannes Ranke <jranke@uni-bremen.de>
# Last Change: 2006 Apr 18
# based on the Makefiles of Tadeusz Pietraszek
# posted on his blog on March 24, 2006
# SVN: $Id$

TEXFILES=$(wildcard *.tex)
TARGETS=$(patsubst %.tex,%.pdf,$(TEXFILES))

RERUN = "No file.*"

all: all-recursive $(TARGETS)

clean: clean-recursive
	rm -f *.aux *.log *.bbl *.blg *.brf *.cb *.ind *.idx *.ilg  \
          *.inx *.ps *.dvi *.toc *.out *.lot *~ *.lof *.ttt *.fff *.nav *.snm *.vrb

all-recursive:
	for dir in $(wildcard *); do if [ -d $$dir ] && [ -f $$dir/Makefile ]; then cd $$dir; $(MAKE) all; cd ..; fi; done

clean-recursive:
	for dir in $(wildcard *); do if [ -d $$dir ] && [ -f $$dir/Makefile ]; then cd $$dir; $(MAKE) clean; cd ..; fi; done

%.pdf: %.tex fig/*
	vlna -v KkSsVvZzOoUuAaI -r -l $<
	xelatex $<
	egrep $(RERUN) $*.log && sleep 1 && (xelatex $<) ; true
	egrep $(RERUN) $*.log && sleep 2 && (xelatex $<) ; true
