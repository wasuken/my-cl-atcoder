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

(defun max-two-index (lst)
  (position (cadr (sort (copy-seq lst) #'>)) lst))

(read-line)
(let ((sp (mapcar #'parse-integer (uiop:split-string (read-line) :separator " "))))
  (format t "~a~%" (1+ (max-two-index sp))))

;; 処理系ごとの離脱用のコード。これがないとエラーが出る
#+sbcl (sb-ext:exit)
#+ccl (ccl:quit)
#+ecl (ext:quit)
#-(or sbcl ccl ecl) (quit)
