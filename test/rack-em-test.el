;;; rack-em-test.el --- Tests for rack-em

;;; rack-em-test.el ends here

(ert-deftest kill-region-test ()
  (with-current-buffer (get-buffer-create "*rack em tests*")
    (insert "Testing\n123")
    (helper-create-region 0 5)
    (call-interactively 'rack-em-kill-region)
    (should (equal ("Test") rack-em--yank-list))))

(ert-deftest multi-kill ()
  (with-current-buffer (get-buffer-create "*rack em tests*")
    (insert "testing 123 abc")
    (helper-create-region 0 9)
    (call-interactively 'rack-em-kill-region)
    (helper-create-region 0 5)
    (call-interactively 'rack-em-kill-region)
    (helper-create-region 0 4)
    (call-interactively 'rack-em-kill-region)
    (should (equal ("testing " "123 " "abc") rack-em--yank-list))))

(ert-deftest pop-from-list ()
  (with-current-buffer (get-buffer-create "*rack em tests*")
    (insert "testing 123 abc")
    (helper-create-region 0 9)
    (call-interactively 'rack-em-kill-region)
    (helper-create-region 0 5)
    (call-interactively 'rack-em-kill-region)
    (helper-create-region 0 4)
    (call-interactively 'rack-em-kill-region)
    (should (equal (rack-em-pop) "abcd"))
    (should (equal (rack-em-pop) "123 "))
    (should (equal (rack-em-pop) "testing "))
    (should (equal '() rack-em--yank-list))
    ))

(ert-deftest top-from-list ()
  (with-current-buffer (get-buffer-create "*rack em tests*")
    (insert "testing 123 abc")
    (helper-create-region 0 9)
    (call-interactively 'rack-em-kill-region)
    (helper-create-region 0 5)
    (call-interactively 'rack-em-kill-region)
    (helper-create-region 0 4)
    (call-interactively 'rack-em-kill-region)
    (should (equal (rack-em-top) "testing "))
    (should (equal (rack-em-top) "123 "))
    (should (equal (rack-em-top) "abc"))
    (should (equal '() rack-em--yank-list))))
