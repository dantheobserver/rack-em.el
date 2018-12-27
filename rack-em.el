;; rack-em.el - Racks up kills and pops em out.

;; Possible usages - kill-ring-yank-pointer
;; display-buffer-in-side-window
;; save-excursion

;; (defcustom rack-em-additonal-yank-commands)
;; (defcustom rack-em-global-ring-count)
;; (defvar rack-em--mode-ring '())
;; (defvar rack-em--session-list '())
;; (defvar rack-em--global-list nil) ;; Just the kill ring?
(defvar rack-em--yank-list '())

(defun rack-em--add-from-kill-ring ()
  (add-to-list 'rack-em--yank-list
               (substring-no-properties (first kill-ring))))

(defun rack-em-start ()
  (setq rack-em-yank-list '()))

(defun rack-em-expand-forward
    (beg end)
  (interactive (list
                (region-beginning)
                (region-end)))
  (if (region-active-p)
      (let ((positions (if (< beg end) [beg end] [end beg])))
        (progn
          (transient-mark-mode nil)
          (set-mark (nth 0 positions))
          (push-mark (nth 1 positions))
          (push-mark (forward-word-strictly))))))

(defun rack-em-kill-region
  (beg end)
  (interactive (list
                (region-beginning)
                (region-end)))
  (if (region-active-p)
      (progn
        (kill-region beg end)
        (rack-em--add-from-kill-ring))))

;; (defun rack-em-kill-line ()
;;   (interactive)
;;     (rack-em-kill-region (beginning))
;;   )

(provide 'rack-em-mode)
