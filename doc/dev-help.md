## Help information and troubleshooting for problems that have been seen to occur when setting up the development environment.
---

If this error appears when trying to run HashLink tests:

> `hl: error while loading shared libraries: libhl.so: cannot open shared object file: No such file or directory`

First, after building HashLink, you should have a file `libhl.so` (steps taken from [here](https://github.com/HaxeFoundation/hashlink/issues/181)).

1. Try copying this file into `/lib/` and see if that fixes the issue.
2. If that doesn't work, try copying `libhl.so` to `/lib32/` and/or `/lib64/` and see if that fixes it.

If the above doesn't work, try running a filesystem search for `libhl.so` (not the one in the directory where you built HashLink) and see if it was installed anywhere on your system.

1. If you can't find `libhl.so`, this won't help - try something else.
2. If you can find `libhl.so`, check to see if the environment valuable `LD_LIBRARY_PATH` is set and if it contains the parent directory of the found `libhl.so`.
3. If `LD_LIBRARY_PATH` is set and contains the parent directory of `libhl.so`, this won't help - try something else.
4. Otherwise, add `export LD_LIBRARY_PATH="<dir>:$LD_LIBRARY_PATH"` to your `~/.bashrc` file (where `<dir>` is the parent directory of the `libhl.so` file).

If none of the above steps work, figure out something else and add your fix here.

---

If this error appears when trying to run PHP:

> `PHP Fatal error:  Uncaught Error: Call to undefined function php\mb_internal_encoding() in <position>`

Try the following (steps taken from [here]([here](https://stackoverflow.com/questions/1216274/unable-to-call-the-built-in-mb-internal-encoding-method))).

1. Check to see if the `php-mbstring` package has been installed on your system. If it hasn't, installed it and see if that fixes the issue.
2. If the package is installed, or installing it didn't help, search for the `php.ini` initialization file on your system.
3. In that file, search for the line containing `extension=mbstring` (should be in the Dynamic Extensions section) and remove any preceding semicolons.
    * Semicolons are the comment character for PHP, so if that line is commented out in the initialization file the extension won't be loaded.
4. If a line with `extension=mbstring` doesn't exist in the `php.ini` file, go to the Dynamic Extensions section of the file and add it as a new line somewhere.

If none of the above steps work, figure out something else and add your fix here.
