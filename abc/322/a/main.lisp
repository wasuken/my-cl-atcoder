(read-line)
(let* ((s (read-line))
       (rst (search "ABC" s)))
  (format t "~a~%" (if rst
		       (1+ rst)
		       -1)))
;; 処理系ごとの離脱用のコード。これがないとエラーが出る
#+sbcl (sb-ext:exit)
#+ccl (ccl:quit)
#+ecl (ext:quit)
#-(or sbcl ccl ecl) (quit)
