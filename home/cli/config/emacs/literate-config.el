(defun sort-words (reverse beg end)
        "Sort words in region alphabetically, in REVERSE if negative.
          Prefixed with negative \\[universal-argument], sorts in reverse.

          The variable `sort-fold-case' determines whether alphabetic case
          affects the sort order.

          See `sort-regexp-fields'."
        (interactive "*P\nr")
        (sort-regexp-fields reverse "\\w+" "\\&" beg end))

      (add-hook 'shell-mode-hook 'compilation-shell-minor-mode)

      (setq TeX-auto-save t)
      (setq TeX-parse-self t)
      (setq-default TeX-engine 'xetex)
      (setq-default TeX-master nil) ; Query for master file.
      (add-hook 'LaTeX-mode-hook 'visual-line-mode)
      (add-hook 'LaTeX-mode-hook 'flyspell-mode)
      (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
      (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
      (setq reftex-plug-into-AUCTeX t)

      (setq gud-netcoredbg-command-name "netcoredbg --interpreter=vscode")

      ;; (advice-remove 'org-babel-do-load-languages #'ignore)
      ;;  (add-to-list 'org-src-lang-modes '("jupyter" . python))

      ;; (org-babel-do-load-languages
      ;;  'org-babel-load-languages
      ;;  '((haskell . t)
      ;;    (sql . t)
      ;;    (shell . t)
      ;;    (python . t)
      ;;    (jupyter . t)

      ;;   ;; ... other languages you might have
      ;;    ))
      ;;    (add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

      ;; (defun org-babel-execute:fsharp (body params)
      ;; (let* ((command (concat "echo '" body "' | dotnet fsi --nologo | grep 'val it:.* =' | sed 's/^.*= //'"))
      ;;        (result (string-trim (shell-command-to-string command))))
      ;;   result))

      ;; (defun org-babel-execute:fsharp (body params)
      ;;   (let* ((command (concat "echo '" body "' | dotnet fsi"))
      ;;          (result (string-trim (shell-command-to-string command))))
      ;;     result))

      ;; (use-package ob-fsharp
      ;;   :straight t
      ;;   :config
      ;;   (add-to-list 'org-babel-load-languages '(fsharp . t)))

      (setq doc-view-resolution 400)

      (require 'org-tempo)

      (custom-set-variables
       ;; custom-set-variables was added by Custom.
       ;; If you edit it by hand, you could mess it up, so be careful.
       ;; Your init file should contain only one such instance.
       ;; If there is more than one, they won't work right.
       '(package-selected-packages
         '(ledger-mode csv-mode elm-mode clojure-mode go-mode fsharp-mode protobuf-mode org-roam-ui org-roam restclient org-bullets which-key nix-mode helm all-the-icons doom-modeline doom-themes gnuplot-mode gnuplot jupyter haskell-mode)))


      (setq org-directory "~/sync/orgmode/gtd")
      (setq org-agenda-files (directory-files org-directory t "\\.org$"))
      (setq org-agenda-skip-unavailable-files t)
      (setq org-refile-targets
            '((nil :maxlevel . 3)
          (org-agenda-files :maxlevel . 3)))

    ;;  (setq org-refile-targets '((nil :maxlevel . 2)))

      (setq org-capture-templates '(
        ("t" "Todo [inbox]" entry (file+headline "~/sync/orgmode/gtd/inbox.org" "Inbox") "\n* TODO %i%?\n")
        ("c" "Todo [main]" entry (file+headline "~/sync/orgmode/gtd/main.org" "Inbox") "\n* TODO %i%?\n")
       ))

      (global-set-key (kbd "C-c a") #'org-agenda)
      (global-set-key (kbd "C-c c") #'org-capture)
      (setq org-todo-keywords
            '((sequence "TODO(t)" "IN-PROGRESS(i)" "SUSPENDED(s)" "IN-REVIEW(r)" "|" "WAITING(w)" "DONE(d)" "CANCELED(c)")))
      (setq org-enforce-todo-dependencies t)

      (setq org-agenda-prefix-format '((agenda . " %i %-12:c%?-12t%-6e% s")
                                       (todo . " %i %-12:c %-6e")
                                       (tags . " %i %-12:c")
                                       (search . " %i %-12:c")))
      (setq org-agenda-skip-scheduled-if-deadline-is-shown t)

      (setq org-clock-persist 'history)
      (org-clock-persistence-insinuate)

      (setq org-timer-default-timer 25)

      (defun my-org-mode-hook ()
        (org-indent-mode t))
      (add-hook 'org-mode-hook 'my-org-mode-hook)

      (setq org-format-latex-options (plist-put org-format-latex-options :scale 4))

      (setq org-confirm-babel-evaluate nil)

      (setq inhibit-startup-message t)

      (toggle-scroll-bar -1)

      (scroll-bar-mode -1)

      (tool-bar-mode -1)

      (menu-bar-mode -1)

      (show-paren-mode 1)

      (delete-selection-mode 1)

     (global-hl-line-mode -1)

;     (global-display-line-numbers-mode t)
   ;   (defun my-relative-line-numbers-hook ()
      ; (setq display-line-numbers 'relative))

;      (add-hook 'display-line-numbers-mode-hook 'my-relative-line-numbers-hook)
    (add-hook 'prog-mode-hook #'display-line-numbers-mode)
      (setq backup-directory-alist '(("." . "~/.emacs_saves")))
      (setq vc-make-backup-files t)


      (global-visual-line-mode 1)

      (setq ido-enable-flex-matching t)
      (setq ido-everywhere t)
      (ido-mode 1)

      (require 'package)
      (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
      (package-initialize)

      (use-package haskell-mode
        :ensure t)

      (use-package jupyter
        :ensure t)

      (use-package gnuplot
        :ensure t)

      (use-package gnuplot-mode
        :ensure t)

      ;; (use-package doom-themes
        ;; :ensure t
        ;; :config
        ;; (load-theme 'doom-one t)
        ;; (doom-themes-visual-bell-config))

      ;; (set-face-attribute 'default nil :font "Iosevka Nerd Font-9")

      ;;    (set-face-attribute 'default nil :font "JetBrainsMono Nerd Font-22")
;  (setq org-hide-emphasis-markers t)
;  (font-lock-add-keywords 'org-mode
;                        '(("^ +\\([-*]\\) "
;                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))


      ;;(use-package doom-modeline
      ;;:ensure t
      ;;:hook (after-init . doom-modeline-mode))

      (use-package all-the-icons
        :ensure t)

      (use-package helm
        :ensure t)

      (use-package nix-mode
        :ensure t
        )

      (use-package which-key
        :ensure t
        :config (which-key-mode))


      (use-package restclient
        :ensure t
        )

      (use-package org-roam
        :ensure t
        :init
        (setq org-roam-v2-ack t)
        :custom
        (org-roam-directory "~/sync/orgmode/library")
        (setq org-roam-dailies-directory "journal/")
        (org-roam-completion-everywhere t)
        :bind (("C-c n l" . org-roam-buffer-toggle)
               ("C-c n f" . org-roam-node-find)
               ("C-c n i" . org-roam-node-insert)
               :map org-mode-map
               ("C-M-i" . completion-at-point)
               :map org-roam-dailies-map
               ("Y" . org-roam-dailies-capture-yesterday)
               ("T" . org-roam-dailies-capture-tomorrow))
        :bind-keymap
        ("C-c n d" . org-roam-dailies-map)
        :config
        (require 'org-roam-dailies) ;; Ensure the keymap is available
        (org-roam-db-autosync-mode))

      (use-package org-roam-ui
        :ensure t
        :config
        (setq org-roam-ui-sync-theme t
              org-roam-ui-follow t
              org-roam-ui-update-on-save t
              org-roam-ui-open-on-start t))

      ;; use-package with package.el:
      (use-package dashboard
        :ensure t 
        :init
        (setq initial-buffer-choice 'dashboard-open)
        (setq dashboard-center-content nil) ;; set to 't' for centered content
        (setq dashboard-items '((agenda . 5)
                                (recents . 5 ))))
     (use-package protobuf-mode
        :ensure t)

      (use-package fsharp-mode
        :defer t
        :ensure t)

      (use-package go-mode
        :defer t
        :ensure t)
      (add-hook 'go-mode-hook #'eglot-ensure)

      (use-package csharp-mode
        :defer t
        :ensure t)
      (add-hook 'chsarp-mode-hook #'eglot-ensure)
      ;;  (add-to-list 'eglot-server-programs
      ;;               `(csharp-mode . ("OmniSharp" "-lsp")))

      (use-package clojure-mode
        :ensure t)

      (use-package elm-mode
        :ensure t)
      (add-hook 'elm-mode-hook 'elm-format-on-save-mode)

      (use-package csv-mode
        :ensure t
        )

      (use-package markdown-mode
        :ensure t
        :mode ("README\\.md\\'" . gfm-mode)
        :init (setq markdown-command "multimarkdown"))

      (use-package ledger-mode
        :ensure t
        :init
        :config
        (setq ledger-reports
              '(("cashflow" "ledger -f %(ledger-file) --cost -X EUR bal ^Income ^Expenses")
                ("cashflow-rsd" "ledger -f %(ledger-file) --cost -X RSD bal ^Income ^Expenses")
                ("net-worth" "ledger -f %(ledger-file) --cost -X EUR bal ^Assets ^Liabilities")
                ("net-worth-rsd" "ledger -f %(ledger-file) --cost -X RSD bal ^Assets ^Liabilities")
                ("prices" "ledger prices -f %(ledger-file)")
                ("bal" "%(binary) -f %(ledger-file) --cost -X EUR bal")
                ("bal-rsd" "%(binary) -f %(ledger-file) --cost -X RSD bal")
                ("reg" "%(binary) -f %(ledger-file) --cost -X EUR reg")
                ("reg-rsd" "%(binary) -f %(ledger-file) --cost -X RSD reg")
                ("payee" "%(binary) -f %(ledger-file) --cost -X EUR reg @%(payee)")
                ("payee-rsd" "%(binary) -f %(ledger-file) --cost -X RSD reg @%(payee)")
                ("account" "%(binary) -f %(ledger-file) --cost -X EUR reg %(account)")  
                ("account-rsd" "%(binary) -f %(ledger-file) --cost -X RSD reg %(account)")))  
        )



      (custom-set-faces
       ;; custom-set-faces was added by Custom.
       ;; If you edit it by hand, you could mess it up, so be careful.
       ;; Your init file should contain only one such instance.
       ;; If there is more than one, they won't work right.
       )

      ;; for waybar
      (defun my-org-timer-remaining-time ()
        "Return the remaining time of the current org-timer as a formatted string."
        (if (and org-timer-countdown-timer 
                 (timerp org-timer-countdown-timer))
            (let ((time-left (- (time-to-seconds (timer--time org-timer-countdown-timer))
                                (time-to-seconds (current-time)))))
              (if (> time-left 0)
                  (format-seconds "%h:%02m" time-left)
                "Time's up!"))
          "No timer set"))

      ;; If font is loaded before frame creation it is reset
      (add-to-list 'after-make-frame-functions
                   (lambda (frame)
                     (select-frame frame)
                     (set-face-attribute 'default nil :font "Alegreya-9")))

(setq org-hide-emphasis-markers t)

(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(let* ((variable-tuple
        (cond ((x-list-fonts "Alegreya")         '(:font "Alegreya"))
              ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
              ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
              ((x-list-fonts "Verdana")         '(:font "Verdana"))
              ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
              (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
       (base-font-color     (face-foreground 'default nil 'default))
       (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

  (custom-theme-set-faces
   'user
   `(org-level-8 ((t (,@headline ,@variable-tuple))))
   `(org-level-7 ((t (,@headline ,@variable-tuple))))
   `(org-level-6 ((t (,@headline ,@variable-tuple))))
   `(org-level-5 ((t (,@headline ,@variable-tuple))))
   `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
   `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))
   `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.5))))
   `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.75))))
   `(org-document-title ((t (,@headline ,@variable-tuple :height 2.0 :underline nil))))))


  (custom-theme-set-faces
 'user
 '(variable-pitch ((t (:family "Alegreya" :height 96 :weight thin))))
 '(fixed-pitch ((t ( :family "Fira Code Retina" :height 80)))))


(add-hook 'org-mode-hook 'variable-pitch-mode)
(add-hook 'org-mode-hook 'visual-line-mode)

;  (deftheme org-beautify "Sub-theme to beautify org mode")
  ;
  ;  (defcustom org-beautify-theme-use-box-hack 't
  ;    "Use a 3 pixel box with the background color to add spacing.
  ;  Note that this has a side effect that can make the theme look
  ;  really bad under some circumstances."
  ;    :type 'boolean)
  ;
  ;  (let* ((sans-font (cond ((x-list-fonts "Alegreya") '(:font "Alegreya"))
  ;                          ((x-list-fonts "Verdana") '(:font "Verdana"))
  ;                          ((x-family-fonts "Sans Serif") '(:family "Sans Serif"))
  ;                          (nil (warn "Cannot find a Sans Serif Font.  Please report at: https://github.com/jonnay/org-beautify-theme/issues"))))
  ;         (base-font-color (face-foreground 'default  nil 'default))
  ;         (background-color (face-background 'default nil 'default))
  ;         (headline `(:inherit default :foreground ,base-font-color))
  ;         (primary-color (face-foreground 'mode-line nil))
  ;         (secondary-color (face-background 'secondary-selection nil 'region))
  ;         (padding (if org-beautify-theme-use-box-hack
  ;                      `(:line-width 5 :color ,background-color)
  ;                      nil))
  ;         (org-highlights `(:foreground ,base-font-color :background ,secondary-color)))
  ;    (custom-theme-set-faces 'org-beautify
  ;                            `(org-agenda-structure ((t (:inherit default ,@sans-font :height 2.0 :underline nil))))
  ;                            `(org-level-8 ((t ,headline)))
  ;                            `(org-level-7 ((t ,headline)))
  ;                            `(org-level-6 ((t ,headline)))
  ;                            `(org-level-5 ((t ,headline)))
  ;                            `(org-level-4 ((t ,headline)))
  ;                            `(org-level-3 ((t (,@headline  :box ,padding))))
  ;                            `(org-level-2 ((t (,@headline ,@sans-font :height 1.25 :box ,padding))))
  ;                            `(org-level-1 ((t (,@headline ,@sans-font :height 1.5  :box ,padding ))))
  ;                            `(org-document-title ((t (:inherit org-level-1 :height 2.0 :underline nil :box ,padding))))
  ;
  ;                            `(org-block ((t (:foreground ,base-font-color :background ,background-color :box nil))))
  ;                            `(org-block-begin-line ((t ,org-highlights)))
  ;                            `(org-block-end-line ((t ,org-highlights)))
  ;
  ;                            `(org-checkbox ((t (:foreground "#000000", :background "#93a1a1" :box (:line-width -3 :color "#93a1a1" :style "released-button")))))
  ;
  ;                            `(org-headline-done ((t (:strike-through t))))
  ;                            `(org-done ((t (:strike-through t))))))

    ;;;###autoload
 ;   (when (and (boundp 'custom-theme-load-path) load-file-name)
 ;     (add-to-list 'custom-theme-load-path
 ;                  (file-name-as-directory (file-name-directory load-file-name))))

    ;; Local Variables:
    ;; no-byte-compile: t
    ;; End:

;    (provide-theme 'org-beautify)
    ;;; org-beautify-theme.el ends here
  ( use-package spacemacs-light
    :ensure t
    :config
    (load-theme 'spacemacs-light t))
