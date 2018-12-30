;; rack-em.el - Racks up kills and pops em out.

;; Possible usages - kill-ring-yank-pointer
;; display-buffer-in-side-window
;; save-excursion

(require 'cl)
(require 'seq)
(require 'dash)

(defvar rack-em--yank-list '())

(defun rack-em--list-count ()
  (count rack-em--yank-list))

(defun rack-em--add-from-kill-ring ()
  (setq rack-em--yank-list
        (-concat rack-em--yank-list
                 (list (substring-no-properties (first kill-ring))))))

(defun rack-em-start ()
  (setq rack-em--yank-list '()))

(defun rack-em-kill-region
  (beg end)
  (interactive (list
                (region-beginning)
                (region-end)))
  (if (region-active-p)
      (progn
        (kill-region beg end)
        (rack-em--add-from-kill-ring))))

(-let ((a (-last-item '(1 2 3 4 5)))
       (b 1))
  b)
(defun rack-em-pop ()
  (-let ((end-item (-last-item rack-em--yank-list))
         (res (-drop-last 1 rack-em--yank-list)))
    (setq rack-em--yank-list res)
    end-item))

(defun rack-em-top ()
  (let (((top-item) (elt rack-em--yank-list))
        (res (-drop 1 rack-em--yank-list)))
    (setq rack-em--yank-list res)
    top-item))

;; (defun rack-em-expand-forward
;;     (beg end)
;;   (interactive (list
;;                 (region-beginning)
;;                 (region-end)))
;;   (if (region-active-p)
;;       (let ((positions (if (< beg end) [beg end] [end beg])))
;;         (progn
;;           (transient-mark-mode nil)
;;           (set-mark (nth 0 positions))
;;           (push-mark (nth 1 positions))
;;           (push-mark (forward-word-strictly))))))

;; (defun rack-em-kill-line ()
;;   (interactive)
;;     (rack-em-kill-region (beginning))
;;   )

(provide 'rack-em-mode)
