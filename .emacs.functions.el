(defun xah-search-current-word ()
  "Call `isearch' on current word or text selection.
“word” here is A to Z, a to z, and hyphen 「-」 and underline 「_」, independent of syntax table.
URL `http://ergoemacs.org/emacs/modernization_isearch.html'
Version 2015-04-09"
  (interactive)
  (let ( ξp1 ξp2 )
    (if (use-region-p)
        (progn
          (setq ξp1 (region-beginning))
          (setq ξp2 (region-end)))
      (save-excursion
        (skip-chars-backward "-_A-Za-z0-9$")
        (setq ξp1 (point))
        (right-char)
        (skip-chars-forward "-_A-Za-z0-9$")
        (setq ξp2 (point))))
    (setq mark-active nil)
    (when (< ξp1 (point))
      (goto-char ξp1))
    (isearch-mode t)
    (isearch-yank-string (buffer-substring-no-properties ξp1 ξp2))))

(defun other-window-backward (&optional n)
  "Select Nth previous window."
  (interactive "P")
  (other-window (- (prefix-numeric-value n))))

(defun git-mark-all-modified ()
  "Mark every file in the status buffer of git that is modified"
  (interactive)
  (save-excursion
    (save-restriction
      (save-match-data)
      (widen)
      (goto-char (point-min))
      (while (search-forward "Modified" nil t)
        (goto-char (point))
        (git-mark-file)
        (previous-line)
        (move-end-of-line nil)))
    nil))

(defun pl-yank-current-word ()
  "Yank current word (stole from xah-search-current-word)"
  (interactive)
  (let (ξp1 ξp2)
    (save-excursion
      (skip-chars-backward "-_A-Za-z0-9$")
      (setq ξp1 (point))
      (right-char)
      (skip-chars-forward "-_A-Za-z0-9$")
      (setq ξp2 (point))
      (kill-ring-save ξp1 ξp2))))

(defun pl-key-chord-mode-toggle ()
  "Toggle key-chord-mode (not really a mode)"
  (interactive)
  (if (null input-method-function)
      (setq input-method-function 'key-chord-input-method)
    (setq input-method-function nil)))

(defun pl-paste-mode ()
  "Toggle paste mode"
  (interactive)
  (if paste-toggle
      (progn
        (setq paste-toggle nil)
        (setq input-method-function nil)
        (god-local-mode -1)
        (message "Paste ready"))
    (progn
      (setq paste-toggle 1)
      (setq input-method-function 'key-chord-input-method)
      (god-local-mode 1)
      (message "Paste off"))))

(defun chess-uci-position-interactive ()
  "Convert the current GAME position to a UCI position command string."
  (interactive)
  (let ((game chess-module-game))
    (kill-new (concat "position fen " (chess-pos-to-fen (chess-game-pos game 0) t)
            " moves " (mapconcat (lambda (ply)
                                   (let ((source (chess-ply-source ply))
                                         (target (chess-ply-target ply)))
                                     (if (and source target)
                                         (concat (chess-index-to-coord source)
                                                 (chess-index-to-coord target)
                                                 (if (chess-ply-keyword ply :promote)
                                                     (string (downcase (chess-ply-keyword ply :promote)))
                                                   ""))
                                       "")))
                                 (chess-game-plies game) " ")
            "\n"))))

(defun xah-unfontify-region-or-buffer ()
  "Unfontify text selection or buffer."
  (interactive)
  (if (region-active-p)
      (font-lock-unfontify-region (region-beginning) (region-end))
        (font-lock-unfontify-buffer)))

(require 'ps-print)
(when (executable-find "ps2pdf")
  (defun modi/pdf-print-buffer-with-faces (&optional filename)
        "Print file in the current buffer as pdf, including font, color, and
underline information.  This command works only if you are using a window system,
so it has a way to determine color values.

C-u COMMAND prompts user where to save the Postscript file (which is then
converted to PDF at the same location."
        (interactive (list (if current-prefix-arg
                               (ps-print-preprint 4)
                             (concat (file-name-sans-extension (buffer-file-name))
                                     ".ps"))))
        (ps-print-with-faces (point-min) (point-max) filename)
        (shell-command (concat "ps2pdf " filename))
        ;; (delete-file filename)
        ;; (message "Deleted %s" filename)
        (message "Wrote %s" (concat (file-name-sans-extension filename) ".pdf"))))
