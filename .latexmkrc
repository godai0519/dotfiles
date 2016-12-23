#!/usr/bin/perl
$latex = 'platex -interaction=nonstopmode -kanji=utf-8 -synctex=1 %S';
$dvipdf = 'dvipdfmx %O -o %D %S';
$bibtex = 'pbibtex';
$pdf_mode = 3;
$pdf_update_method = 2;
$pdf_previewer = "start qpdfview %O %S";

