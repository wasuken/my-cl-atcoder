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

(defun main (n sps)
  (loop for i from 0 to (- n 2)
	do (format t "~{~a~^ ~}~%"
		   (let ((cur 0))
		     (loop for j from i to (- n 2)
			   collect (progn
				     (setf cur (+ cur (nth j sps)))
				     cur)))))
  )

(let ((n (parse-integer (read-line)))
      (sps (mapcar #'parse-integer (uiop:split-string (read-line) :separator " "))))
  (main n sps)
  )

;; 処理系ごとの離脱用のコード。これがないとエラーが出る
#+sbcl (sb-ext:exit)
#+ccl (ccl:quit)
#+ecl (ext:quit)
#-(or sbcl ccl ecl) (quit)
