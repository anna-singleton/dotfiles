  (setq initial-buffer-choice "~/Dropbox/notes/todo.org")

  (require 'package)
  (setq package-archives '(("melpa" . "https://melpa.org/packages/")
                           ("org" . "https://orgmode.org/elpa/")
                           ("elpa" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless package-archive-contents
    (package-refresh-contents))

  (unless (package-installed-p 'use-package)
    (package-install 'use-package))
  (require 'use-package)
  (setq use-package-always-ensure 't)

  (use-package ivy
    :diminish
    :bind (("C-s" . swiper)
           :map ivy-minibuffer-map
           ("TAB" . ivy-alt-done)
           ("C-l" . ivy-alt-done)
           ("C-j" . ivy-next-line)
           ("C-h" . ivy-previous-line)
           :map ivy-switch-buffer-map
           ("C-k" . ivy-previous-line)
           ("C-l" . ivy-done)
           ("C-d" . ivy-switch-buffer-kill)
           :map ivy-reverse-i-search-map
           ("C-k" . ivy-previous-line)
           ("C-d" . ivy-reverse-i-search-kill))
    :config
    (ivy-mode 1))

  (use-package ivy-rich
    :init
    (ivy-rich-mode 1))

  (use-package counsel
    :bind (("M-x" . counsel-M-x)
           ("C-x C-f" . counsel-find-file)
           :map minibuffer-local-map
           ("C-r" . counsel-minibuffer-history)))

  (use-package swiper)

  (use-package which-key
    :init (which-key-mode)
    :diminish which-key-mode
    :config
    (setq which-key-idle-delay 0.3))

  (use-package helpful
    :custom
    (counsel-describe-function-function #'helpful-callable)
    (counsel-describe-variable-function #'helpful-variable)
    :bind
    ([remap describe-function] . counsel-describe-function)
    ([remap describe-command] . counsel-describe-command)
    ([remap describe-variable] . counsel-describe-variable)
    ([remap describe-key] . helpful-key))

    (setq user-emacs-directory "~/.cache/emacs")
    (use-package no-littering)
    (setq auto-save-file-name-transforms
          `((".*", (no-littering-expand-var-file-name "auto-save/") t)))

  (setq dired-kill-when-opening-new-dired-buffer t)

  (setq inhibit-startup-message t)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (setq visible-bell t)
  (set-fringe-mode 10)

  (add-to-list 'default-frame-alist '(font . "NotoSansMono"))
  (set-face-attribute 'default nil :font "NotoSansMono" :height 130)

    (use-package doom-themes
      :ensure t
      :config
      (setq doom-themes-enable-bold t
            doom-themes-enable-italic t)
      (load-theme 'doom-snazzy t)
      (doom-themes-visual-bell-config))

  (use-package doom-modeline
    :ensure t
    :init (doom-modeline-mode 1))
  (setq doom-modeline-height 16)
  (setq doom-modeline-modal-icon nil)

  (use-package all-the-icons)

  (column-number-mode)
  (global-display-line-numbers-mode t)

  ;; disable line nums for some modes
  (dolist (mode '(org-mode-hook
                  shell-mode-hook
                  term-mode-hook
                  eshell-mode-hook))
    (add-hook mode (lambda () (display-line-numbers-mode 0))))

  (use-package rainbow-delimiters
    :hook (prog-mode . rainbow-delimiters-mode))

  (defun as/org-babel-tangle-config ()
    (when (or
(string-equal (buffer-file-name) (expand-file-name "~/.dotfiles/.emacs.d/anna-conf.org"))
(string-equal (buffer-file-name) (expand-file-name "~/.dotfiles/systemconf.org")))
      (let ((org-confirm-babel-evaluate nil))
        (org-babel-tangle))))
  (add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'as/org-babel-tangle-config)))

  (add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)

    (defun as/org-mode-setup ()
      (org-indent-mode)
      (visual-line-mode 0)
      (setq org-src-preserve-indentation t))

  (use-package org
    :hook (org-mode . as/org-mode-setup)
    :config
    (setq org-ellipsis "▼"))

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (C . t)
     (plantuml . t)
     (latex . t)
     (jupyter . t)))
  (setq org-confirm-babel-evaluate nil)

  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("cl" . "src c"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))

  ;;(use-package org-superstar)
  ;;(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

  (use-package general
    :config
    (general-create-definer as/leader-keys
      :keymaps '(normal insert visual emacs)
      :prefix "SPC"
      :global-prefix "C-SPC")
    (as/leader-keys
      "t" '(:ignore t :which-key "toggles")
      "o" '(:ignore t :which-key "org-mode")))

  (as/leader-keys
    "oi" '(org-indent-block :which-key "indent org mode block")
    "tw" '(whitespace-mode :which-key "toggle whitespace"))

(general-define-key
 "C-M-j" 'counsel-switch-buffer
 "<escape>" 'keyboard-escape-quit)

  (use-package hydra)

  (defhydra hydra-text-scale (:timeout 4)
    "scale text"
    ("j" text-scale-increase "in")
    ("k" text-scale-decrease "out")
    ("f" nil "finished" :exit t))

  (as/leader-keys
    "ts" '(hydra-text-scale/body :which-key "scale text"))

  (defun as/evil-hook ()
    (dolist (mode '(custom-mode
                    eshell-mode
                    git-rebase-mode
                    sauron-mode
                    term-mode))
      (add-to-list 'evil-emacs-state-modes mode)))

  (use-package evil
    :init
    (setq evil-want-integration t)
    (setq evil-want-keybinding nil)
    :config
    (evil-mode 1)
    (evil-global-set-key 'motion "j" 'evil-next-visual-line)
    (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
    (evil-define-key 'normal 'local "K" 'man)
    (evil-define-key 'visual 'local "C-x C-;" 'comment-or-uncomment-region)
    (evil-set-initial-state 'messages-buffer-mode 'normal)
    (evil-set-initial-state 'dashboard-mode 'normal))

  (use-package evil-collection
    :after evil
    :config
    (evil-collection-init))

  (use-package undo-fu)

  (add-hook 'prog-mode-hook 'electric-pair-mode t)

(setq display-line-numbers-type 'relative)

  (use-package projectile
    :diminish projectile-mode
    :config (projectile-mode)
    :custom((projectile-completion-system 'ivy))
    :bind-keymap ("C-c p" . projectile-command-map)
    :init
    (when (file-directory-p "~/proj")
      (setq projectile-project-search-path '("~/proj"))))

    (use-package counsel-projectile
      :after projectile
      :config (counsel-projectile-mode))

  (use-package magit)

  (use-package lsp-mode
    :commands (lsp lsp-deferred)
    :init
    (setq lsp-keymap-prefix "C-c l")
    :config
    (lsp-enable-which-key-integration t))

    (use-package lsp-ui
      :hook (lsp-mode . lsp-ui-mode)
      :custom
      (lsp-ui-doc-position 'bottom)
      (lsp-ui-doc-max-height 5)
      (lsp-signature-doc-lines 5))

  (use-package lsp-ivy)

  (use-package company
    :after lsp-mode
    :hook (lsp-mode . company-mode)
    :bind (:map company-active-map
                ("<tab>" . company-complete-selection))
    (:map lsp-mode-map
          ("<tab>" . company-indent-or-complete-common))
    :custom
    (company-minimum-prefix-length 1)
    (company-idle-delay 0.0))

  (use-package company-box
    :hook (company-mode . company-box-mode))

  (use-package flycheck
    :ensure t
    :init (global-flycheck-mode))
  (define-key flycheck-mode-map flycheck-keymap-prefix nil)
  (setq flycheck-keymap-prefix (kbd "C-c s"))
  (define-key flycheck-mode-map flycheck-keymap-prefix flycheck-command-map)

  (use-package tree-sitter)
  (use-package tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

  (add-hook 'prog-mode-hook 'company-mode t)

  (use-package origami)
  (add-hook 'prog-mode-hook 'origami-mode t)

   (setq-default indent-tabs-mode nil)
   ;(use-package smart-tabs-mode)
   ;(smart-tabs-insinuate 'c 'java)
   (setq-default c-basic-offset 4)
   (setq-default tab-width 4)

  (use-package yasnippet)

(defun as/c-init-hook ()
  ;;(define-key c-mode-base-map "\C-c" 'c-context-line-break)
  (setq tab-width 4 indent-tabs-mode nil)
  (electric-pair-mode t) ;;turn on auto pair brackets
  (setq backward-delete-char-untabify-method 'hungry) ;; delete tabs at once
  ;(hs-minor-mode) ;; turn on folding support (z a to toggle)
  )
(add-hook 'c-initialization-hook 'as/c-init-hook)

  (use-package company-c-headers)
  (add-to-list 'company-backends 'company-c-headers)

(defun as/c-buffer-init ()
  (lsp)
  (yas-minor-mode))

  (add-hook 'c-mode-hook 'as/c-buffer-init)

  (setq c-default-style "linux"
        c-basic-offset 4)



  (defun as/makefile-init-hook ()
  (setq tab-width 4))

  (add-hook 'makefile-gmake-mode-hook 'as/makefile-init-hook)

  (use-package haskell-mode)

  (use-package lsp-java)
  (add-hook 'java-mode-hook 'lsp)

  (use-package python-mode
    :ensure t
    :hook (python-mode . lsp-deferred))

  (add-hook 'python-mode-hook 'lsp)
  (use-package lsp-jedi
  :ensure t
  :config
  (with-eval-after-load "lsp-mode"
    (add-to-list 'lsp-disabled-clients 'pyls)))

  (use-package jupyter)

(defun display-ansi-colors ()
  (ansi-color-apply-on-region (point-min) (point-max)))

(add-hook 'org-babel-after-execute-hook #'display-ansi-colors)

  (use-package vimrc-mode)

  (use-package fish-mode)
  (use-package fish-completion)
