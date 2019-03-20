(require 'ora-elisp-style-guide)

;;;###autoload
(defun ora-emacs-lisp-hook ()
  (ignore-errors
    (prettify-symbols-mode)
    (lispy-mode 1)
    (company-mode)
    (set (make-local-variable 'company-backends)
         '((company-elisp :with company-dabbrev-code)))
    ;; (abel-mode)
    (diminish 'abbrev-mode)
    ;; (yas-minor-mode-on)
    (auto-compile-mode 1)
    (semantic-mode -1)
    (add-to-list 'completion-at-point-functions 'lispy-complete-fname-at-point)))

(use-package lispy
    :config
  (progn
    (setq lispy-no-permanent-semantic t)
    (setq lispy-delete-backward-recenter nil)
    (setq lispy-helm-columns '(70 100))
    (lispy-set-key-theme '(oleh special lispy c-digits))
    (setq lispy-avy-style-symbol 'at-full)))

(defun ora-package-symbol ()
  (interactive)
  (let ((prefix (concat (file-name-nondirectory
                         (directory-file-name
                          (file-name-directory (buffer-file-name))))
                        "-")))
    (unless (looking-back prefix (line-beginning-position))
      (insert prefix))
    (complete-symbol nil)))

(define-key lisp-mode-shared-map (kbd "β") 'ora-package-symbol)

(define-key lisp-mode-shared-map (kbd "C-c C-z")
  (lambda ()
    (interactive)
    (switch-to-buffer-other-window "*scratch*")))
(define-key lisp-mode-shared-map (kbd "C-c C-l") 'eval-buffer)
(define-key emacs-lisp-mode-map (kbd "C-M-i") nil)
(define-key lisp-interaction-mode-map (kbd "C-M-i") nil)

(defun lisp--match-hidden-arg (limit) nil)

(setq prettify-symbols-alist
      '(("lambda" . ?λ)))
(font-lock-add-keywords 'emacs-lisp-mode
                        (ora-fontify-glyph "\\\\\\\\|" "∨"))
(font-lock-add-keywords 'emacs-lisp-mode
                        (ora-fontify-glyph "\\\\\\\\(" "("))
(font-lock-add-keywords 'emacs-lisp-mode
                        (ora-fontify-glyph "\\\\\\\\)" ")"))
(font-lock-add-keywords 'emacs-lisp-mode
                        '(("^;;;###[-a-z]*autoload.*$" 0 'shadow t))
                        'end)

(when (version< emacs-version "24.4")
  (defun prettify-symbols-mode ()))

(defun conditionally-enable-lispy ()
  (when (eq this-command 'eval-expression)
    (lispy-mode 1)))

(add-hook 'minibuffer-setup-hook 'conditionally-enable-lispy)

(defun ora-lisp-interaction-hook ()
  (lispy-mode 1)
  (company-mode 1))

(provide 'ora-elisp)
