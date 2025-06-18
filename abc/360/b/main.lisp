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

(defun split-string-by-n (str n)
  "文字列strをn文字ずつに分割してリストで返す"
  (if (or (null str) (zerop (length str)))
      nil
      (let ((len (length str)))
        (if (<= len n)
            (list str)
            (cons (subseq str 0 n)
                  (split-string-by-n (subseq str n) n))))))

(defun check (s tt)
  "S を先頭から順に w 文字毎に区切ったとき、長さが c 以上の文字列の c 文字目を順番に連結した文字列が T と一致する"
  (block cblock
    (loop for w from 1 to (1- (length s))
	do (let ((sps (split-string-by-n s w)))
	     (loop for c from 0 to (1- w)
		   do (progn
			;; (format t "~%=== ~a,~a" w (1+ c))
			;; ;; (print (remove-if-not #'(lambda (x) (<= c (length x))) sps))
			;; (print (mapcar #'(lambda (x) (char x c))
			;; 	       (remove-if-not #'(lambda (x) (<= c (1- (length x)))) sps)))
			;; (print (list tt (coerce (mapcar #'(lambda (x) (char x c))
			;; 				  (remove-if-not #'(lambda (x)
			;; 						     (<= c (1- (length x))))
			;; 						 sps))
			;; 			  'string)))
			(when (string= tt (coerce (mapcar #'(lambda (x) (char x c))
							  (remove-if-not #'(lambda (x)
									     (<= c (1- (length x))))
									 sps))
						  'string))
			  (return-from cblock T))
			)
		   )
	     )
	))
  )

(let* ((rl (read-line))
       (sps (uiop:split-string rl :separator " ")))
  ;; (format t "~s~%" (uiop:split-string rl :separator " "))
  (if (check (first sps) (second sps))
      (format t "Yes~%")
      (format t "No~%"))
  )

;; 処理系ごとの離脱用のコード。これがないとエラーが出る
#+sbcl (sb-ext:exit)
#+ccl (ccl:quit)
#+ecl (ext:quit)
#-(or sbcl ccl ecl) (quit)
