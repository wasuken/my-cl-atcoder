(defun contest-cnt (a b c)
  (let ((m (min a b c)))
    (cond ((or (zerop a)
	       (zerop c))
	   0)
	  ((= a b c)
	   a)
	  ((or (= m a)
	       (= m c))
	   m
	   )
	  (t
	   (min (floor (/ (+ a b c) 3)) a c)
	  )
    )
  ))

(let* ((n (parse-integer (read-line)))
       (testcases (loop for x from 1 to n
			collect (mapcar #'parse-integer (uiop:split-string (read-line) :separator " ")))))
  (loop for a in testcases
	do (format t "~a~%" (contest-cnt (first a) (second a) (third a))))
  )
;; 処理系ごとの離脱用のコード。これがないとエラーが出る
#+sbcl (sb-ext:exit)
#+ccl (ccl:quit)
#+ecl (ext:quit)
#-(or sbcl ccl ecl) (quit)
