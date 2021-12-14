@echo off
copy book/*.md book.md

set extensions="-smart+tex_math_dollars+implicit_figures+link_attributes+tex_math_single_backslash+header_attributes"
pandoc book.md -fmarkdown%extensions% -o book.html --ascii
