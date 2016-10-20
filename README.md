# docx2md

Yet ugly simple script but get the job done. Convert `docx` to `markdown` using `pandoc`.

I have a multi-level folder that contains many mixed doc/docx files along with other file types.

And, I don't wanna play with a word proccessor every time I need to see what it is in the doc/docx file.

Then, I know I have to convert these word files to a text-based format. Yes, `markdown`, of course, the most widely-used and simplest markup format of humanity :3. And yes, `pandoc`, a great tool to convert-a-file-format-to-another-file-format.

## Requirements:
- [ ] Shell that support text substitution.
- [ ] GNU `sed` (`-i` for inline-replacement). Most Linux distro.
- [ ] LibreOffice.
- [ ] Perl (> `v5.x.x`) comes with Unicode module.
- [ ] Pandoc, of course.

## Here what the script actually does:

- [x] Walks through the folder with multi-level sub-folder
- [x] Watches all the files for `doc` or `docx`:
  - [x] If the file name contans any white-space, replaces the white-space with hyphen (`-`). I hate the white-spaces in the path!
  - [x] If the file name contains any latin-based char but not the ascii (I mean the Unicode), converts the char to an us-ascii char.
  - [ ] What about non-latin chars, suck as CJK? Eh, I don't get it now.
  - [x] Lower-cases the file name. Yes, non-spaces and lower-cases paths. I love it.
  - [x] If the file is `doc`, convert it to `docx`. This stage calls `libreoffice` (or `soffice`) directly. You also can use unoconv as an alternative. The `doc2docx` function. Then calls the `docx2md` function.
  - [x] Removes the converted `doc` file.
  - [x] Creates one media folder for every `docx` file to save every extracted media files (jpeg, png, ...) from the being-converted `docx` file. Named this folder `${the-docx-file-name}-media`.
  - [x] Calls the `docx2md` function. Converts all the `docx` files to `md` files. Converts the absolute to relative paths for extracted media files (if any).
  - [x] Remove the converted `docx` file.
- [x] Exits the loop.

Unfortunately, you have to delete the empty media folder manually (if any).

That it.

I don't have much time to play with `pandoc` or Pandoc Template, although I think the out put should be more pleasure.
