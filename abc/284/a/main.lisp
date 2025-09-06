(defun rev (l &optional acc)
  (if (null l)
      acc
      (rev (cdr l) (cons (car l) acc))))

(let* ((n (parse-integer (read-line)))
       (sl (loop for i from 1 to n
		 collect (read-line))))
  (loop for x in (rev sl)
	do (format t "~a~%" x)))

;; 処理系ごとの離脱用のコード。これがないとエラーが出る
#+sbcl (sb-ext:exit)
#+ccl (ccl:quit)
#+ecl (ext:quit)
#-(or sbcl ccl ecl) (quit)
