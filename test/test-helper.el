;;; test-helper.el --- Helpers for rack-em-test.el

;;; test-helper.el ends here
(require 'f)

(defvar root-test-path
  (f-dirname (f-this-file)))

(defvar root-path
  (f-parent root-test-path))

(defun helper-create-region (beg end)
  (goto-char beg)
  (push-mark end t)
  (activate-mark))

(require 'rack-em-mode (f-expand "rack-em.el" root-path))
