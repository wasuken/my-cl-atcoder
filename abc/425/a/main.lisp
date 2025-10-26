(let ((n (read)))
  (format t "~a~%" (apply '+ (loop for i from 1 to n collect (* (expt (- 1) i) (expt i 3))))))
;; 処理系ごとの離脱用のコード。これがないとエラーが出る
#+sbcl (sb-ext:exit)
#+ccl (ccl:quit)
#+ecl (ext:quit)
#-(or sbcl ccl ecl) (quit)
