# ialign.el #

Emacs package that provides an interactive version of the
`align-regexp` command.

In action: [screencast](./demo.gif)

## Additional packages ##

If you have an optional package - [pcre2el][pcre2el] - installed, you can use
PCRE regexps for alignment.

# Usage #

To use it, mark a region and then call `ialign`.  You can enter a
regexp in the minibuffer that will be passed to `align-regexp`
command.  As the contents of minibuffer change, the region is
realigned.  You can also specify other arguments to `align-regexp`:

-   Increment/decrement spacing (padding) with `C-c -` and `C-c +`
-   Repeat the alignment throughout the line with `C-c C-r`.
-   Go to next/previous history element with `M-n` and `M-p`.
-   Toggle tabs with `C-c C-t`.
-   Toggle case sensitivity with `C-c M-c`.
-   Toggle PCRE mode with `C-c C-p` (requires [pcre2el]).
-   Increment/decrement the parenthesis group which will be modified
    with `C-c [` and `C-c ]`. Negative parenthesis group means justify
    (prepend space to each group).

# License

```
Copyright (C) 2017-2025 Michał Krzywkowski

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
```

<!-- Local Variables: -->
<!-- coding: utf-8 -->
<!-- fill-column: 79 -->
<!-- End: -->


[pcre2el]: https://github.com/joddie/pcre2el
