;;original .emacs config file from my laptop

;;packages to get after basic setup: CEDET, org, yasnippet, autopair


(add-to-list 'load-path "~/.emacs.d/downloaded")

;; use packag management and marmalade to get just about everything else
(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "https://marmalade-repo.org/packages/") t)
;;latest melpa packages
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)

;;stable melpa packages
;;(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)



;;sets linenumbers
(global-linum-mode 1)

;;set sbcl as the inferior lisp
(setq inferior-lisp-program "sbcl")

;;set up slime from git repository
(add-to-list 'load-path "~/slime")
(setq slime-contribs '(slime-js))
(require 'slime-autoloads)

;;set up swank-js hooks for various modes
(global-set-key [f5] 'slime-js-reload)
(add-hook 'js2-mode-hook
          (lambda ()
            (slime-js-minor-mode 1)))
(add-hook 'css-mode-hook
          (lambda ()
            (define-key css-mode-map "\M-\C-x" 'slime-js-refresh-css)
            (define-key css-mode-map "\C-c\C-r" 'slime-js-embed-css)))


;;(add-to-list 'load-path "~/.emacs.d/slime-master/")
;;(require 'slime)
;;(slime-setup)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;; this is equivalent to meta-x
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

(global-set-key (kbd "C-c a") 'my-compile-with-changes)
(global-set-key (kbd "C-c A") 'compile-and-go)

;;instead of the beginning of the line, go to indentation
(global-set-key "\C-a" 'back-to-indentation)

;;options to turn of scrollbar, menubar, tool bar
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
;;(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;;open full screen
(defun toggle-fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
)
(toggle-fullscreen)

;;makes it easier to switch buffers, find files, etc
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

;;stops the startup screen from showing up
(setq inhibit-startup-message t
  inhibit-startup-echo-area-message t)

;;make it so that going to the next line also adds a newline
(setq next-line-add-newlines t)

;;Keyboard Macros
(fset 'my-compile-with-changes
   [?\C-u ?1 ?\M-x ?s ?a ?v ?e ?- ?s ?o ?m ?e ?- ?b ?u ?f ?f ?e ?r ?s return ?\M-x ?c ?o ?m ?p ?i ?l ?e return return])

(put 'my-compile-with-changes 'kmacro t)

(add-hook 'c-mode-common-hook
  (lambda()
    (local-set-key (kbd "C-c <right>") 'hs-show-block)
    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
    (local-set-key (kbd "C-c <down>")  'hs-show-all)
    (hs-minor-mode t)))

(defun save-macro (name)                  
    "save a macro. Take a name as argument
     and save the last defined macro under 
     this name at the end of your .emacs"
     (interactive "SName of the macro :")  ; ask for the name of the macro    
     (kmacro-name-last-macro name)         ; use this name for the macro    
     (find-file "~/.emacs")                   ; open ~/.emacs or other user init file 
     (goto-char (point-max))               ; go to the end of the .emacs
     (newline)                             ; insert a newline
     (insert-kbd-macro name)               ; copy the macro 
     (newline)                             ; insert a newline
     (switch-to-buffer nil))               ; return to the initial buffer

(require 'helm-config)

(require 'auto-complete-config)

(require 'writegood-mode)

(load "~/quicklisp/log4slime-setup.el")
(global-log4slime-mode 1)

;;clojure configuration
(defun cider-namespace-refresh ()
  (interactive)
  (cider-interactive-eval
   "(require 'clojure.tools.namespace.repl)
    (clojure.tools.namespace.repl/refresh)"))

;;(define-key clojure-mode-map (kbd "M-r") 'cider-namespace-refresh)


;;make js2 the default js editing mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

;;dired+ setup
(diredp-toggle-find-file-reuse-dir 1)

;;projectile setup
(projectile-global-mode)

;;add a folder from which to load custom themes
;;emacs 24+ no longer uses the color-theme package
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes
   (quote
    ("f641bdb1b534a06baa5e05ffdb5039fb265fde2764fbfd9a90b0d23b75f3936b" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
