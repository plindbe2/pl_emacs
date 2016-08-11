(fset '80-char-limit
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("80" 0 "%d")) arg)))

(fset 'pl-docstring
   "\C-s\C-[sr^def \C-m\C-a\C-@\C-n\C-[w\C-y\C-p\C-@\C-n\C-[xreplace-regexp \C-m^\\([^(]+(\\)\\([^)]+\\)\\().*\\)\C-m\\2\C-m\C-a\C-@\C-n\C-[xreplace-regexp\C-m^\C-m\"\"\"\C-q\C-j\C-m\C-p\C-p\C-@\C-n\C-p    @param \C-a\C-@\C-n\C-[xreplace-regexp\C-m, \C-m\C-q\C-j    @param \C-m\C-a\C-n\C-n")

(fset 'pl-find-tag-glob
   "\C-c\C-ky\C-c\C-k,\C-y")

(fset 'pl-scroll-up
   "\C-u10\C-v")

(fset 'pl-scroll-down
   "\C-u10\M-v")
