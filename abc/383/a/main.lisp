(defun process-events (events)
  (reduce (lambda (state event)
            (destructuring-bind (prev-time volume) state
              (destructuring-bind (time add-volume) event
                (let ((new-volume (max 0 (- volume (- time prev-time)))))
                  (list time (+ new-volume add-volume))))))
          events
          :initial-value '(0 0)))

(let* ((n (parse-integer (read-line)))
       (events (loop for i from 1 to n
		     collect (mapcar #'parse-integer
				     (uiop:split-string (read-line) :separator " ")))))
  (format t "~a~%" (cadr (process-events events)))
  )
;; 処理系ごとの離脱用のコード。これがないとエラーが出る
#+sbcl (sb-ext:exit)
#+ccl (ccl:quit)
#+ecl (ext:quit)
#-(or sbcl ccl ecl) (quit)
