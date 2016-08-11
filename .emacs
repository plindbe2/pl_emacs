;;; package --- Summary

;;; Commentary:
;;; Cool

;;; Code:

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-x%" 'evil-jump-item)
(global-set-key "\C-x\C-ka" '80-char-limit)
(global-set-key "\C-c\C-ks" 'xah-search-current-word)
(global-set-key [f8] 'other-window)
(global-set-key "\C-x\C-kg" 'git-status)
(global-set-key [f7] (lambda ()
  (interactive)
  (git-status
   (git-get-top-dir "."))))
(global-set-key [f6] 'pl-paste-mode)
(global-set-key "\C-xp" 'other-window-backward)
(global-set-key "\C-c\C-ky" 'pl-yank-current-word)
(global-set-key "\C-c\C-k," 'tags-search)
(global-set-key "\C-c\C-kf" 'flycheck-mode)
(global-set-key "\C-c\C-kn" 'pl-scroll-up)
(global-set-key "\C-c\C-kp" 'pl-scroll-down)
(global-set-key "\C-c\C-k\M-," 'pl-find-tag-glob)
(global-set-key "\C-\M-[" (lambda() (interactive) (god-local-mode 1)))
(global-set-key "\C-\M-]" (lambda() (interactive) (god-local-mode -1)))
(global-set-key "\C-c\C-kq" (lambda() (interactive)
                              (pl-key-chord-mode-toggle)
                              (electric-indent-mode)))
(global-set-key "\C-c\C-kp" 'pl-paste-mode)
(global-set-key (kbd "<escape>") (lambda() (interactive) (god-local-mode -1)))

;;; Org
(setq org-log-done t)
(setq org-agenda-files (list "~/Documents/work.org"))

;; Misc settings
(set-face-attribute 'default nil :height 100)
(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(setq ruby-indent-level 4)
(setq initial-scratch-message "")
(defvaralias 'c-basic-offset 'tab-width)
(add-hook 'html-mode-hook
          (lambda()
            (setq sgml-basic-offset 4)))
(add-hook 'log-edit-mode-hook
          (lambda()
            (auto-fill-mode t)))
(add-hook 'python-mode-hook
          (lambda()
            (setq fill-column 79)))
(add-hook 'php-mode-hook
          (lambda()
            (setq fill-column 79)))
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(column-number-mode 1)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup)
(setq haskell-indent-offset 2)
(setq paste-toggle 1)
(defalias 'yes-or-no-p 'y-or-n-p) ; y or n is enough
(defalias 'list-buffers 'ibuffer) ; always use ibuffer
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.php[s345t]?\\.example\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.conf\\.example\\'" . conf-unix-mode))
(setq ps-print-header nil)

;;; MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; Chords
(require 'key-chord)
(key-chord-mode 1) ; turn on key-chord-mode
(key-chord-define-global "jk"     (lambda() (interactive) (god-local-mode 1)))
(key-chord-define-global "jl"     (lambda() (interactive) (god-local-mode -1)))
(key-chord-define-global "x2"     'split-window-below)
(key-chord-define-global "x3"     'split-window-right)
(key-chord-define-global "x0"     'delete-window)
(key-chord-define-global "x1"     'delete-other-windows)
(key-chord-define-global "xo"     'other-window)
(key-chord-define-global "xp"     'other-window-backward)
(key-chord-define-global "xa"     'xah-search-current-word)
(key-chord-define-global "cy"     'pl-yank-current-word)
(key-chord-define-global "xb"     'switch-to-buffer)
(key-chord-define-global "xk"     'kill-buffer)
(key-chord-define-global "c]"     'pl-xclip)
(key-chord-define-global "c5"     'evil-jump-item)
(key-chord-define-global "xu"     'winner-undo)
(key-chord-define-global "xg"     (lambda()
                                    (interactive)
                                    (magit-status)
                                    (delete-other-windows)))
;;; Flycheck stuff
(add-hook 'after-init-hook #'global-flycheck-mode)
(defun flycheck-python-setup ()
  (flycheck-mode))
(add-hook 'python-mode-hook #'flycheck-python-setup)

(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(add-to-list 'load-path "~/.emacs.d/git")
(require 'git)
(require 'god-mode)
(add-to-list 'god-exempt-major-modes 'magit-popup-mode)
(god-mode-all)
(winner-mode 1)
(add-to-list 'load-path "~/.emacs.d/ses21-031130")
(require 'ses)
(load-file "~/tmp/tmp.el")

(provide '.emacs)
;;; .emacs ends here
