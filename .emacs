; list the packages you want
(setq package-list '(
                        ;;packages used by multiple project types
                        auto-complete
                        projectile
                        helm helm-core helm-projectile helm-helm-commands
                        yasnippet
                        rainbow-delimiters
                        rainbow-identifiers
                        flx
                        flx-ido
                        undo-tree
                        
                        ;;packages used by specific project types
                        
                        slime
                        
                        cider
                        clojure-mode
                        
                        json-mode
                        yaml-mode
                        
                        restclient
                        ))

(setq package-archives '(
            ;;("gnu" . "http://elpa.gnu.org/packages/")
            ("marmalade" . "http://marmalade-repo.org/packages/")
            ("melpa" . "http://melpa.milkbox.net/packages/")))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available 
(or (file-exists-p package-user-dir) (package-refresh-contents))

;;alternative method to fetch list of packages available
;;(unless package-archive-contents
;;  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
             
;;stop emacs from creating backup files             
(setq backup-inhibited t)

;;make sure all changes to files auto-revert (useful for git)
(global-auto-revert-mode)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;;visual stuff
(condition-case nil
    (progn
      (global-linum-mode 1)
      (menu-bar-mode 1)
      (tool-bar-mode -1)
      (scroll-bar-mode -1))
  (error
   (message "Could not set up visual settings (is emacs running from the command line?)")
   (
   ;;do-recovery-stuff
   )))

(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)


;;(setq next-line-add-newlines t)
(setq next-line-add-newlines nil)


;;set backup variables
(setq make-backup-files nil
      ;; backup-by-copying t
      ;; version-control t
      ;; delete-old-versions t
      ;; kept-old-versions 6
      ;; kept-new-versions 9
      auto-save-default nil
      )

;;put backups in one directory (so I don't litter all over the servers)
(setq backup-directory-alist `(("." . "~/.saves")))


;;alternative key binding for the usual M-x minibuffer combo
(global-set-key(kbd"C-x C-m")'execute-extended-command)

(define-key global-map (kbd "C-x C-k") 'kill-region)

(define-key global-map (kbd "C-a") 'back-to-indentation)

(define-key global-map (kbd "C-w") 'backward-kill-word)



;; tabs are done with spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq show-trailing-whitespace 1)

(setq js-indent-level 4)

;;packages setup


(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook #'rainbow-identifiers-mode)

(ac-config-default)

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)
(setq ido-auto-merge-work-directories-length -1)
