(defun is-dim-exist-xy (area x y)
  (and (not (or (minusp x)
		(minusp y)))
       (nth x area)
       (> (length (nth x area)) y)
       (char (nth x area) y)))

(defun around-bl-cnt (area x y)
  (let ((around '(
		  (-1 0)
		  (0 -1)
		  (1 0)
		  (0 1)
		  ))
	)
    (count 1 (loop for a in around collect (let ((i (first a))
						 (j (second a)))
					     (if (not (is-dim-exist-xy area
								       (+ x i)
								       (+ y j)))
						 0
						 (if (string= (char (nth (+ x i) area) (+ y j)) "#")
						     1
						     0)
						 )
					     )
		   ))
    )
  )

(let* ((hw (mapcar #'parse-integer  (uiop:split-string (read-line) :separator " ")))
       (h (1- (first hw)))
       (w (1- (second hw)))
       (area (loop for x from 0 to h collect (read-line)))
       (only-black-points (remove-if-not #'(lambda (x) (string= "#" (char (nth (first x) area) (second x))))
					 (loop for i from 0 to h
					       append (loop for j from 0 to w
							    collect (list i j)))))
       (cnt-l (mapcar #'(lambda (a) (around-bl-cnt area (first a) (second a)))
		      only-black-points)))
  (format t "~a~%"
	  (if cnt-l
	      (if (every #'(lambda (x) (or (= x 2) (= x 4))) cnt-l)
		  "Yes"
		  "No")
	      "Yes"))
  )
;; 処理系ごとの離脱用のコード。これがないとエラーが出る
#+sbcl (sb-ext:exit)
#+ccl (ccl:quit)
#+ecl (ext:quit)
#-(or sbcl ccl ecl) (quit)
