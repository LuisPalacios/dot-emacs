;;
;; .emacs de LuisPa (updated may'2021)
;;
;; Here I just set my most used keybindings, for my own information
;; It has nothing to do with this file ($HOME/.emacs), but I
;; document it here
;;
;; C-space        Activar 'Marcar Selección'
;; C-w            Cortar la selección
;; C-y            Pegar la selección cortada
;; C-z            Undo
;; Home           Ir al principio de la línea (Mac: Fn-Inicio)
;; Fin            Ir al final de la línea (Mac: Fn-Fin)
;; C-Home         Ir al principio del documento (Mac: C-Fn-Home)
;; C-Fin          Ir al final del documento (Mac: C-Fn-Fin)
;;
;; Debug del .emacs: emacs --debug-init
;;
;; Evito ventanas muy pequeñas (4 líneas de altura)
(if (< (frame-height) 4)
    (set-frame-height (window-frame) 24))

;; Opcion genérica
(setq frame-title-format "%b - GNU Emacs")

;; Look and feel
(set-foreground-color "gray")
(set-background-color "black")
(set-cursor-color "red")
(set-mouse-color "green")
(set-border-color "light green")

;; Soporte de Ratón cuando arrancamos en modo texto (emacs -new ...)
(xterm-mouse-mode 1)

;; Temas, fuente https://emacsthemes.com/index/1.html
(load-theme 'whiteboard)
(set-cursor-color "red")

;; Mostrar la hora con este formato
(setq display-time-string-forms
      '(24-hours ":" minutes))
(display-time)

;; Activar números de columnas
(column-number-mode)

; At least this mode won't do anything stupid.
(setq default-major-mode 'text-mode)

(setq pop-up-windows nil                ; Don't change my windowconfiguration.
      european-calendar-style t         ; Use european date format.
      pop-up-windows nil                ; Assure my window-configuration is kept.
      require-final-newline t)          ; Fix rotten daimi-setup.

;; Ignorar 'case' en búsquedas
(setq case-fold-search t)

;;
(setq scroll-step 1)

;; Nada de pitidos
(setq ring-bell-function 'ignore)

;; Ya vale de mensajes al arrancar
(setq inhibit-startup-message t)

;; Mostrar paréntesis
(show-paren-mode t)

;; Paso de menús
(menu-bar-mode nil)

;; Backups
;; Put backup files neatly away
(let ((backup-dir "~/.emacs-backups")
      (auto-saves-dir "~/.emacs-auto-saves/"))
  (dolist (dir (list backup-dir auto-saves-dir))
    (when (not (file-directory-p dir))
      (make-directory dir t)))
  (setq backup-directory-alist `(("." . ,backup-dir))
        auto-save-file-name-transforms `((".*" ,auto-saves-dir t))
        auto-save-list-file-prefix (concat auto-saves-dir ".saves-")
        tramp-backup-directory-alist `((".*" . ,backup-dir))
        tramp-auto-save-directory auto-saves-dir))

(setq backup-by-copying t    ; Don't delink hardlinks
      delete-old-versions t  ; Clean up the backups
      version-control t      ; Use version numbers on backups,
      kept-new-versions 5    ; keep some new versions
      kept-old-versions 2)   ; and some old ones, too

;; Save point position between sessions
(save-place-mode t)
(setq save-place-file (locate-user-emacs-file "places" ".emacs-places"))

;; Auto comprimir..
(auto-compression-mode t)

;; Recordar cosillas...
(custom-set-variables
 '(global-font-lock-mode t nil (font-lock))
 '(transient-mark-mode t))

;; Colorines
(custom-set-faces
 '(font-lock-comment-face ((t (:foreground "forest green"))))
 '(highlight ((t (:foreground "blue" :background "indian red"))))
 '(isearch ((t (:inherit region))))
 '(modeline ((t (:foreground "black" :background "steelblue"))))
 '(region ((t (:foreground "white" :background "midnight blue"))))
 '(show-paren-match-face ((t (:foreground "black" :background "steel blue")))))

;; Teclas
;; Si usas o has usado windows estas teclas te ayudar n a no
;; volverte loco.
(global-set-key [end]    'end-of-line)
(global-set-key [home]   'beginning-of-line)
(global-set-key [delete] 'delete-char)
(global-set-key [C-home] 'beginning-of-buffer)
(global-set-key [C-end]  'end-of-buffer)
(global-set-key [?\C-z]  'undo)
(global-set-key [M-f4]   'delete-frame)

;; Keybindings -- Global
;; Ctrl+f para search and replace (Ctrl+S == search)
(global-set-key [(ctrl f)] 'query-replace)

;; Keybindings -- MacOS X
(cond
 ((eq system-type 'Darwin)
  ;;Set option to be the Meta key
  ;;Set apple+c/x/v to copy/cut/paste
  ;;Set apple+q to close emacs (save buffers first)
  ;;Set apple+w to delete frame
  ;;Set apple+e to kill current buffer
  ;;Set apple+z to undo
  ;;Set apple+s to save buffer
  ;;Set apple+n to make frame
  (setq mac-command-key-is-meta nil)
  (global-set-key [(alt v)] 'yank)
  (global-set-key [(alt c)] 'kill-ring-save)
  (global-set-key [(alt x)] 'kill-region)
  (global-set-key [(alt q)] 'save-buffers-kill-emacs)
  (global-set-key [(alt w)] 'delete-frame)
  (global-set-key [(alt e)] 'myKillBuffer)
  (global-set-key [(alt z)] 'undo)
  (global-set-key [(alt s)] 'save-buffer)
  (global-set-key [(alt n)] 'make-frame)
))

;; Desktop
;; Recuerda cosas...
(desktop-save-mode 1)
(when (fboundp 'desktop-load-default)
  (desktop-load-default)
  (mapcar
   (lambda (sym) (add-to-list 'desktop-globals-to-save sym))
   '((buffer-name-history      . 20)
     (dired-regexp-history     . 20)
     (extended-command-history . 30)
     (file-name-history        . 100)
     (grep-history             . 30)
     (minibuffer-history       . 50)
     (query-replace-history    . 60)
     (read-expression-history  . 60)
     (regexp-history           . 60)
     (regexp-search-ring       . 20)
     (search-ring              . 20)
     (shell-command-history    . 50)))
  (desktop-read))

;; Go Spanish and Unicode
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8))
(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-locale-environment "es.UTF-8") ;; old
(set-selection-coding-system 'utf-8) ;; old
(setq buffer-file-coding-system 'utf-8-unix)
(setq default-file-name-coding-system 'utf-8-unix)
(setq default-keyboard-coding-system 'utf-8-unix)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))
(setq default-sendmail-coding-system 'utf-8-unix)
(setq default-terminal-coding-system 'utf-8-unix)
(setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding - old
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; EOF
