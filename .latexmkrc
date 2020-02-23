#!/usr/bin/env perl

$pdflatex = "xelatex -interaction=nonstopmode --shell-escape -synctex=1 %O %S";
$pdf_mode = "1";
$postscript_mode = $dvi_mode = 0;

$biber = 'biber --bblencoding=utf8 -u -U --output_safechars';

