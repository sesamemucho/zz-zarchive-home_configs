;; bbdb
;; 2.35

(autoload 'bbdb "bbdb")
(add-to-list 'load-path (concat local-pkg-dir "bbdb/lisp")) ; Get the latest version
(eval-after-load "bbdb"
  '(progn
     ;;(require 'bbdb)
     (bbdb-initialize 'gnus 'message 'sc 'w3)

     ;; The following lines are straight from suggested defaults in bbdb-sc.el
     (bbdb-insinuate-sc)
     (setq sc-preferred-attribution-list
           '("sc-lastchoice" "x-attribution" "sc-consult"
             "initials" "firstname" "lastname"))

     (setq sc-attrib-selection-list
           '(("sc-from-address" ((".*" . (bbdb/sc-consult-attr
                                          (sc-mail-field "sc-from-address")))))))

     (setq sc-mail-glom-frame
           '((begin                        (setq sc-mail-headers-start (point)))
             ("^x-attribution:[ \t]+.*$"   (sc-mail-fetch-field t) nil t)
             ("^\\S +:.*$"                 (sc-mail-fetch-field) nil t)
             ("^$"                         (progn (bbdb/sc-default)
                                                  (list 'abort '(step . 0))))
             ("^[ \t]+"                    (sc-mail-append-field))
             (sc-mail-warn-if-non-rfc822-p (sc-mail-error-in-mail-field))
             (end                          (setq sc-mail-headers-end (point)))))
     )
  )

;; remember
;(add-to-list 'load-path (concat local-pkg-dir "remember-1.9/")) ; Get the latest version
;(add-to-list 'Info-default-directory-list (concat local-pkg-dir "remember-1.9/"))

;; ;; org mode
;; ;; The following lines are always needed.  Choose your own keys.
;; (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;; (global-set-key "\C-cl" 'org-store-link)
;; (global-set-key "\C-ca" 'org-agenda)
;; (add-hook 'org-mode-hook 'turn-on-font-lock)  ; org-mode buffers only

;; From John Wiegley (http://www.newartisans.com/blog_files/org.mode.day.planner.php)

(add-to-list 'load-path (concat local-share-top "org-6.28e/lisp"))
(add-to-list 'load-path (concat local-share-top "org-6.28e/lisp/contrib"))
(require 'org-install)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;(define-key mode-specific-map [?a] 'org-agenda)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; (eval-after-load "org"
;;   '(progn
;;      (define-prefix-command 'org-todo-state-map)

;;      (define-key org-mode-map "\C-cx" 'org-todo-state-map)

;;      (define-key org-todo-state-map "x"
;;        #'(lambda nil (interactive) (org-todo "CANCELLED")))
;;      (define-key org-todo-state-map "d"
;;        #'(lambda nil (interactive) (org-todo "DONE")))
;;      (define-key org-todo-state-map "f"
;;        #'(lambda nil (interactive) (org-todo "DEFERRED")))
;;      (define-key org-todo-state-map "l"
;;        #'(lambda nil (interactive) (org-todo "DELEGATED")))
;;      (define-key org-todo-state-map "s"
;;        #'(lambda nil (interactive) (org-todo "STARTED")))
;;      (define-key org-todo-state-map "w"
;;        #'(lambda nil (interactive) (org-todo "WAITING")))

;;      (define-key org-agenda-mode-map "\C-n" 'next-line)
;;      (define-key org-agenda-keymap "\C-n" 'next-line)
;;      (define-key org-agenda-mode-map "\C-p" 'previous-line)
;;      (define-key org-agenda-keymap "\C-p" 'previous-line)

;;      ))

(setq org-directory "~/org/pim/")
(setq org-default-notes-file (concat org-directory "nlug.org.gpg"))
(org-remember-insinuate)

(setq org-agenda-files (quote ("~/org/pim/todo.org.gpg" "~/org/pim/home.org.gpg" "~/org/pim/dates.org.gpg" "~/org/pim/system_notes.org.gpg" "~/org/pim/nlug.org.gpg")))
(setq org-agenda-ndays 7)
(setq org-agenda-show-all-dates t)
(setq org-agenda-todo-list-sublevels nil)
(setq org-todo-keywords
      '((sequence "TODO" "WAITING" "|" "DONE")))
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-start-on-weekday nil)
;; (setq org-agenda-exporter-settings nil)
;; (require 'ps-print)
;; (setq ps-landscape-mode nil)
;; (setq ps-number-of-colums 1)
(setq org-agenda-exporter-settings
      '((ps-number-of-columns 1)
        (ps-landscape-mode t)
        (org-agenda-add-entry-text-maxlines 5)
        ))

(setq org-deadline-warning-days 14)
(setq org-fast-tag-selection-single-key (quote expert))
(setq org-remember-store-without-prompt t)
(setq org-remember-templates
      (quote (("General" ?t "** TODO %? %t\n\n" "~/org/pim/todo.org.gpg" "Tasks")
              ("Phone"   ?p "** TODO %? %t" "~/org/pim/home.org.gpg" "Phone calls")
              ("Appt"    ?a "** TODO %? %T" "~/org/pim/home.org.gpg" "Appointments")
              ("Note"    ?n "** %? %u" "~/org/pim/home.org.gpg" "Notes")
              ("Home"    ?h "** TODO %? %t" "~/org/pim/home.org.gpg" "Tasks")
              ("Garden"  ?g "** TODO %? %t" "~/org/pim/home.org.gpg" "Garden")
              ("Trip"    ?r "** TODO %? %t" "~/org/pim/home.org.gpg" "Trip")
              ("Someday" ?s "** TODO %? %u" "~/org/pim/home.org.gpg" "Tasks")
              ("To Buy " ?b "** TODO %? %t :shop:" "~/org/pim/home.org.gpg" "Want list")
             )))

     (setq org-agenda-custom-commands
           '(
             ("X" agenda ""
              ((ps-number-of-columns 1)
               (ps-landscape-mode t)
               (org-agenda-ndays 1)
               (org-agenda-prefix-format " [ ] ")
               (org-agenda-with-colors nil)
               (org-agenda-remove-tags t))
              ("~/temp/agenda.ps"))
             ("S" "Shop"
              ((tags "shop"))
              ((org-show-entry-below t)
               (org-show-hierarchy-above t)
               (ps-number-of-columns 1)
               (ps-landscape-mode nil)
               (org-agenda-prefix-format " [ ] ")
               (org-agenda-with-colors nil)
               (org-agenda-remove-tags t))
              ("~/temp/shop.ps"))
             ("Y" alltodo "" nil ("~/temp/todo.html" "~/temp/todo.txt" "~/temp/todo.ps"))
             ;; ("h" "Agenda and Home-related tasks"
             ;;  ((agenda "")
             ;;   (tags-todo "home")
             ;;   (tags "garden"))
             ;;  nil
             ;;  ("~/views/home.html"))
             ;; ("o" "Agenda and Office-related tasks"
             ;;  ((agenda)
             ;;   (tags-todo "work")
             ;;   (tags "office"))
             ;;  nil
             ;;  ("~/views/office.ps"))
             ;; ("Z" "TD" ((todo "recur"))
             ;;  ((ps-number-of-columns 1)
             ;;   (ps-landscape-mode t)
             ;;   (org-agenda-ndays 1)
             ;;   (org-agenda-prefix-format " [ ] ")
             ;;   (org-agenda-with-colors nil)
             ;;   (org-agenda-remove-tags t))
             ;;  ("~/temp/agenda.ps"))
             ))

(defun org-export-icalendar ()
  (interactive)
)

(setq org-reverse-note-order t)

(add-to-list 'load-path (concat local-user-top-dir "share/emacs/site-lisp/remember"))
(require 'remember)


;(setq remember-annotation-functions '(org-remember-annotation))
;(setq remember-handler-functions '(org-remember-handler))
;(add-hook 'remember-mode-hook 'org-remember-apply-template)


(define-key global-map [(control meta ?r)] 'remember)
(define-key global-map [(pause)] 'remember)

(provide 'ssmm-pim)