(defun qcode-to-s (v)
  (if (zerop v)
      "."
      (string (code-char (+ 64 v)))))

(let* ((hw (mapcar #'parse-integer (uiop:split-string (read-line) :separator " ")))
       (h (first hw))
       (al (loop for i from 1 to h
		 collect (mapcar #'parse-integer
				 (uiop:split-string (read-line) :separator " ")))))
  (loop for line in al
	do (format t "~{~a~}~%" (mapcar #'qcode-to-s line))))
;; 処理系ごとの離脱用のコード。これがないとエラーが出る
#+sbcl (sb-ext:exit)
#+ccl (ccl:quit)
#+ecl (ext:quit)
#-(or sbcl ccl ecl) (quit)
