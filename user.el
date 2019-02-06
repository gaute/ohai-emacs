;; Default position and size.
(setq default-frame-alist
      '((width . 128)
        (height . 72)
        (left . 0)
        (top . 0)))

(setq auto-mode-alist
  (append
   '(("\\.pb[so]\\'" . web-mode)
     ("\\.php5?\\'" . web-mode)
     ("\\.vm\\'" . web-mode)
     ("\\.twig\\'" . web-mode))
   auto-mode-alist))

(setq web-mode-enable-auto-indentation nil)

(put 'narrow-to-region 'disabled nil)

;; Don't let ffap (helm-find-files) get confused in HTML tags.
(defadvice ffap-file-at-point (after ffap-file-at-point-after-advice ())
  (if (string= ad-return-value "/")
      (setq ad-return-value nil)))
(ad-activate 'ffap-file-at-point)

(setq projectile-completion-system 'helm)
(setq projectile-switch-project-action 'helm-projectile)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(setq browse-url-generic-program "open")
(global-set-key (kbd "C-c C-v") 'browse-url-of-buffer)

(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
          '(javascript-jshint)))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(setq emojify-user-emojis '((":memo:" . (("name" . "Memo")
                                         ("unicode" . "📝")
                                         ("style" . "github")))))
(when (featurep 'emojify)
  (emojify-set-emoji-data))

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(load (concat dotfiles-dir "private.el") 'noerror)
