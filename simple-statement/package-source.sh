#!/usr/bin/env bash

set -x
set -e

make clean && make
rm -rf source.zip source
mkdir source
python3 format.py main.tex
mv formatted.tex source/main.tex

# Statement-specific
cp main.bbl statement.cls unsrtnat_etal.bst source/

cp -r defs source/
cp -r figs source/
cp -r tables source/
cp -r text source/

zip -r source source
rm -rf source/

set +x
set +e
echo 'Did you remember to clean irrelevant files before packaging? You can (1) run `git clean . -xdi` (2) manually delete unused files in figs/ and tables/' >&2
