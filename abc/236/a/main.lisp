(defun replace-char-at (string position new-char)
  (concatenate 'string
               (subseq string 0 position)
               (string new-char)
               (subseq string (1+ position))))

(defun string-swap (s n m)
  (let* ((a (char s n))
	 (b (char s m)))
    (replace-char-at (replace-char-at s n b) m a)))

(let ((s (read-line))
      (ab (mapcar #'1- (mapcar #'parse-integer (uiop:split-string (read-line) :separator " ")))))
  (format t "~a~%" (string-swap s (first ab) (second ab))))
;; 処理系ごとの離脱用のコード。これがないとエラーが出る
#+sbcl (sb-ext:exit)
#+ccl (ccl:quit)
#+ecl (ext:quit)
#-(or sbcl ccl ecl) (quit)
