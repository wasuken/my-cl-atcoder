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

(defun dist (p1 p2)
  (let ((dx (- (first p2) (first p1)))
	(dy (- (second p2) (second p1))))
    (+ (* dx dx) (* dy dy)))
  )

(defun triangle-p (p1 p2 p3)
  (let ((a2 (dist p1 p2))
	(b2 (dist p1 p3))
	(c2 (dist p2 p3)))
    (or (= (+ a2 b2) c2)
	(= (+ a2 c2) b2)
	(= (+ b2 c2) a2)))
  )

(let* ((p1 (mapcar #'parse-integer (uiop:split-string (read-line) :separator " ")))
       (p2 (mapcar #'parse-integer (uiop:split-string (read-line) :separator " ")))
       (p3 (mapcar #'parse-integer (uiop:split-string (read-line) :separator " "))))
  (if (triangle-p p1 p2 p3)
      (format t "Yes~%")
      (format t "No~%"))
  )

;; 処理系ごとの離脱用のコード。これがないとエラーが出る
#+sbcl (sb-ext:exit)
#+ccl (ccl:quit)
#+ecl (ext:quit)
#-(or sbcl ccl ecl) (quit)
