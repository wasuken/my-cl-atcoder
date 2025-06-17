;; (let ((rl (read-line)))
;;   (format t "~s~%" (uiop:split-string rl :separator " "))
;;   (format t "~a~%" (mapcar #'parse-integer (uiop:split-string rl :separator " ")))
;;   )

(defun take (n l)
  (if (or (= n 0) (not l))
      '()
      (cons (car l) (take (1- n) (cdr l)))))

(defun drop (n l)
  (if (or (= n 0) (not l))
      l
      (drop (1- n) (cdr l))))

(defun same-buy (n tt a)
  (loop for i below n
	thereis (and (char= (char tt i) #\o)
		     (char= (char tt i) (char a i)))))

(let ((n (read))
      (tt (read-line))
      (a (read-line)))
  (if (same-buy n tt a)
      (format t "Yes~%")
      (format t "No~%"))
  )

;; 処理系ごとの離脱用のコード。これがないとエラーが出る
#+sbcl (sb-ext:exit)
#+ccl (ccl:quit)
#+ecl (ext:quit)
#-(or sbcl ccl ecl) (quit)
