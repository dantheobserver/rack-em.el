;;; rack-em-test.el --- Tests for rack-em

;;; rack-em-test.el ends here

(ert-deftest kill-region-test ()
  (with-current-buffer (get-buffer-create "*rack em tests*")
    (rack-em-start)
    (insert "Testing")
    (set-mark 0)
    (push-mark 4)
    (should (equal nil rack-em--yank-list))
    (call-interactively 'rack-em-kill-region)
    (should (equal '("Test") rack-em--yank-list))))
