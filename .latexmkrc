#!/usr/bin/perl

$biber = 'biber --bblencoding=utf8 -u -U --output_safechars';
$pdflatex = "xelatex -interaction=nonstopmode --shell-escape -synctex=1 %O %S";
$pdf_mode = "1";

