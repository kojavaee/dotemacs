;; Color theme
(load-theme 'solarized-dark t)

;; Setting fonts for GUI emacs
(if (display-graphic-p)
    (progn
      (set-face-attribute
       'default nil :font "Ubuntu Mono 12")
      (dolist (charset '(kana han symbol cjk-misc bopomofo))
        (set-fontset-font (frame-parameter nil 'font)
                          charset
                          (font-spec :family "文泉驿等宽微米黑" :size 16)))))

;; Change auto-save dir
(defvar my-backup-dir (concat temporary-file-directory "emacs-backup"))

(setq backup-directory-alist
      `((".*" . ,my-backup-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,my-backup-dir t)))

(if (not (file-accessible-directory-p my-backup-dir))
    (make-directory my-backup-dir))

;; Undo tree
(global-undo-tree-mode)

;; TextMate minor mode
(eval-after-load 'textmate
  '(progn
     (define-key *textmate-mode-map* [(meta return)] nil)
     (define-key *textmate-mode-map* [(control c)(control k)] nil)))

(textmate-mode)
(add-to-list '*textmate-project-roots* "project.clj")
(add-to-list '*textmate-project-roots* "setup.py")
(add-to-list '*textmate-project-roots* ".ropeproject")

;; IDO hacks
;; Display ido results vertically, rather than horizontally
(setq ido-decorations
      (quote ("\n-> "
              """\n   " "\n   ..." "[" "]"
              " [No match]" " [Matched]"
              " [Not readable]" " [Too big]"
              " [Confirm]")))
(defun ido-disable-line-trucation ()
  (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)

(require 'yasnippet)
(yas-global-mode 1)

;; ===== Custom keybindings ====
;;
;; Buffer and window switching
(global-set-key (kbd "C-,") 'previous-buffer)
(global-set-key (kbd "C-.") 'next-buffer)

;; Find files in current project
(global-set-key (kbd "C-S-r") 'find-file-in-project)

;; Expand-region
(global-set-key (kbd "C-=") 'er/expand-region)
