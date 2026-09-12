MAIN := main
TARGETS := $(MAIN)

DEPENDENCIES := $(shell find . -type f \
	! -name '.gitignore' \
	! -name '.DS_Store' \
	! -name '*~' \
	! -name 'pdflatex2041000.fls' \
	$(foreach t,$(TARGETS),! -name '$(t).*'))

.PHONY: all
all: $(TARGETS:=.pdf)

$(TARGETS) : % : %.pdf

$(TARGETS:=.pdf) : %.pdf : %.tex $(DEPENDENCIES)
	latexmk -pdf $< -synctex=1 -file-line-error -interaction=nonstopmode -halt-on-error -logfilewarninglist

$(TARGETS:=-auto) : %-auto : %.tex $(DEPENDENCIES)
	latexmk -pdf $< -synctex=1 -file-line-error -interaction=nonstopmode -halt-on-error -logfilewarninglist -pvc

.PHONY: clean
clean:
	latexmk -C
