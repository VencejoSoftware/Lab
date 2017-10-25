@echo off
@echo "Converting markdown readme to html..."

set path_3rd_party=..\..\..\3rd_party\
set path_readme=%1%
set out_filename=%2%

call %path_3rd_party%multimarkdown\multimarkdown.exe ^
  %path_readme%readme.md ^
  -t html ^
  -o %out_filename% ^
  -c
