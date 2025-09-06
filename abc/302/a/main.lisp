(let* ((ab (mapcar #'parse-integer (uiop:split-string (read-line) :separator " ")))
       (a (first ab))
       (b (second ab)))
  (format t "~a~%" (ceiling (/ a b))))
;; 処理系ごとの離脱用のコード。これがないとエラーが出る
#+sbcl (sb-ext:exit)
#+ccl (ccl:quit)
#+ecl (ext:quit)
#-(or sbcl ccl ecl) (quit)
