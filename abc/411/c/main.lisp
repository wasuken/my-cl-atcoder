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

(defun genlist (n init)
  (loop for i from 0 to (1- n)
	collect init))

(defun adjacent-one-group-count (lst)
  (if lst
      (let ((v (car lst))
	    (ll lst))
	(loop until (not (member v ll))
	      do (progn
		   (setf ll (remove v ll :count 1))
		   (incf v)
		   )
	      )
	(+ 1
	   (adjacent-one-group-count ll)
	   )
	)
      0
      )
  )

(defun main (alist)
  (let ((blist '()))
    (loop for a in alist
	  do (progn
	       (if (member a blist)
		   (setf blist (remove a blist))
		   (setf blist (append blist (list a))))
	       (format t "~a~%" (adjacent-one-group-count (sort blist #'<)))
	       )
	  )
    )
  )

(read-line)
(main (mapcar #'parse-integer (uiop:split-string (read-line) :separator " ")))

;; 処理系ごとの離脱用のコード。これがないとエラーが出る
#+sbcl (sb-ext:exit)
#+ccl (ccl:quit)
#+ecl (ext:quit)
#-(or sbcl ccl ecl) (quit)
