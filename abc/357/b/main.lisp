;; (let ((rl (read-line)))
;;   (format t "~s~%" (uiop:split-string rl :separator " "))
;;   (format t "~a~%" (mapcar #'parse-integer (uiop:split-string rl :separator " ")))
;;   )
;; nを読み取って、n回行を読み取る
;; (let ((n (parse-integer (read-line))))
;;   (format t "~a~%" (count-if #'(lambda (x) (string= x "Takahashi"))
;; 		   (loop for x from 0 to (1- n)
;; 			 collect (read-line))))
;;   )

(defun take (n l)
  (if (or (= n 0) (not l))
      '()
      (cons (car l) (take (1- n) (cdr l)))))

(defun drop (n l)
  (if (or (= n 0) (not l))
      l
      (drop (1- n) (cdr l))))

(let* ((s (read-line))
      (scl (loop for c across s
		 collect c)))
  (format t "~a~%"
	  (if (<
	       ;; 小文字だけ
	       (length (remove-if #'(lambda (c) (and (>= (char-code c) (char-code #\A))
						     (<= (char-code c) (char-code #\Z))))
				  scl))
	       ;; 大文字だけ
	       (length (remove-if-not #'(lambda (c) (and (>= (char-code c) (char-code #\A))
							 (<= (char-code c) (char-code #\Z))))
				      scl)))
	      ;; 小文字<大文字->全部大文字
	      (string-upcase s)
	      ;; 小文字>=大文字->全部小文字
	      (string-downcase s)
	      )
	  )
  )

;; 処理系ごとの離脱用のコード。これがないとエラーが出る
#+sbcl (sb-ext:exit)
#+ccl (ccl:quit)
#+ecl (ext:quit)
#-(or sbcl ccl ecl) (quit)
