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

(defun retu (init a lst)
  (if lst
      (let ((ninit (+ a (car lst))))
	(if (>= init (car lst))
	    ;; スタートが前のやつが終わってから
	    (cons (+ init a) (retu (+ init a) a (cdr lst)))
	    ;; スタートがそのまま
	    (cons ninit (retu ninit a (cdr lst))))
	)
      )
  )

;; 一人当たりA秒
(let* ((na (mapcar #'parse-integer (uiop:split-string (read-line) :separator " ")))
       (tlist (mapcar #'parse-integer (uiop:split-string (read-line) :separator " ")))
       (a (nth 1 na)))
  (format t "~{~a~%~}" (retu 0 a tlist))
  )

;; 処理系ごとの離脱用のコード。これがないとエラーが出る
#+sbcl (sb-ext:exit)
#+ccl (ccl:quit)
#+ecl (ext:quit)
#-(or sbcl ccl ecl) (quit)
