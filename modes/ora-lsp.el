(require 'lsp-clients)
(require 'lsp)

(setq lsp-auto-guess-root t)

(defun lsp-mode-line ()
  "Construct the mode line text."
  (concat
   " LSP"
   (unless (lsp-workspaces)
     (propertize "[Disconnected]" 'face 'warning))))

(setq lsp-clients-clangd-executable "/usr/bin/clangd-8")

(provide 'ora-lsp)
