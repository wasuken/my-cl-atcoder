(let ((a (read))
      (b (read))
      (c (read)))
  (format t "~a~%"
	  (if (or (= a b)
		  (= a c)
		  (= b c))
	      "Yes"
	      "No"
	      )
	  )
  )

;; 処理系ごとの離脱用のコード。これがないとエラーが出る
#+sbcl (sb-ext:exit)
#+ccl (ccl:quit)
#+ecl (ext:quit)
#-(or sbcl ccl ecl) (quit)
