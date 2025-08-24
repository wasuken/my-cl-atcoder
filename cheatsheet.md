# AtCoder Common Lisp 頻出パターン集

## 基本的な入出力パターン

### 一行読み込み・分割・整数変換
x```lisp
;; 文字列として読み込み
(let ((s (read-line)))
  ;; 処理
  )

;; スペース区切りで分割
(let ((tokens (uiop:split-string (read-line) :separator " ")))
  ;; 処理
  )

;; スペース区切りで分割して整数に変換
(let ((nums (mapcar #'parse-integer (uiop:split-string (read-line) :separator " "))))
  ;; 処理
  )
```

### N回読み込み
```lisp
;; N個の文字列を読み込み
(let ((n (parse-integer (read-line))))
  (let ((lines (loop for i from 0 to (1- n)
                     collect (read-line))))
    ;; 処理
    ))

;; 特定条件の個数をカウント
(let ((n (parse-integer (read-line))))
  (format t "~a~%" (count-if #'(lambda (x) (string= x "Takahashi"))
                             (loop for i from 0 to (1- n)
                                   collect (read-line)))))
```

## ユーティリティ関数

### リスト操作
```lisp
(defun take (n l)
  "リストの先頭n個を取得"
  (if (or (= n 0) (not l))
      '()
      (cons (car l) (take (1- n) (cdr l)))))

(defun drop (n l)
  "リストの先頭n個を削除"
  (if (or (= n 0) (not l))
      l
      (drop (1- n) (cdr l))))
```

### 文字列操作
```lisp
(defun split-string-by-n (str n)
  "文字列をn文字ずつに分割"
  (if (or (null str) (zerop (length str)))
      nil
      (let ((len (length str)))
        (if (<= len n)
            (list str)
            (cons (subseq str 0 n)
                  (split-string-by-n (subseq str n) n))))))

(defun sn (s n)
  "文字列sをn回繰り返し"
  (if (zerop n)
      ""
      (concatenate 'string s (sn s (1- n)))))
```

### 数学・幾何
```lisp
(defun dist (p1 p2)
  "2点間の距離の二乗"
  (let ((dx (- (first p2) (first p1)))
        (dy (- (second p2) (second p1))))
    (+ (* dx dx) (* dy dy))))

(defun triangle-p (p1 p2 p3)
  "3点が直角三角形を成すか判定（ピタゴラスの定理）"
  (let ((a2 (dist p1 p2))
        (b2 (dist p1 p3))
        (c2 (dist p2 p3)))
    (or (= (+ a2 b2) c2)
        (= (+ a2 c2) b2)
        (= (+ b2 c2) a2))))
```

## よく使う処理パターン

### 文字の大文字小文字判定・変換
```lisp
;; 大文字小文字の個数比較
(let* ((s (read-line))
       (chars (loop for c across s collect c))
       (lowercase-count (length (remove-if #'(lambda (c) 
                                             (and (>= (char-code c) (char-code #\A))
                                                  (<= (char-code c) (char-code #\Z))))
                                          chars)))
       (uppercase-count (length (remove-if-not #'(lambda (c) 
                                                  (and (>= (char-code c) (char-code #\A))
                                                       (<= (char-code c) (char-code #\Z))))
                                              chars))))
  (if (< lowercase-count uppercase-count)
      (string-upcase s)
      (string-downcase s)))

;; 大文字判定
(upper-case-p (char s i))
```

### 累積処理・時間計算
```lisp
(defun retu (init a lst)
  "キューの処理時間計算（前の人が終わってから開始）"
  (if lst
      (let ((ninit (+ a (car lst))))
        (if (>= init (car lst))
            (cons (+ init a) (retu (+ init a) a (cdr lst)))
            (cons ninit (retu ninit a (cdr lst)))))
      nil))
```

### 連続グループのカウント
```lisp
(defun adjacent-one-group-count (lst)
  "連続する整数のグループ数をカウント"
  (if lst
      (let ((v (car lst))
            (ll lst))
        (loop until (not (member v ll))
              do (progn
                   (setf ll (remove v ll :count 1))
                   (incf v)))
        (+ 1 (adjacent-one-group-count ll)))
      0))
```

### 文字列・配列の検索
```lisp
;; 特定パターンの検索
(every #'(lambda (c) (find c target-string))
       (loop for i from 1 to (1- (length s))
             when (upper-case-p (char s i))
               collect (char s (1- i))))

;; 条件に合致する要素の存在チェック
(loop for i below n
      thereis (and (char= (char str1 i) #\o)
                   (char= (char str1 i) (char str2 i))))
```

## 定型的な出力パターン

### 基本出力
```lisp
;; Yes/No判定
(if condition
    (format t "Yes~%")
    (format t "No~%"))

;; 数値出力
(format t "~a~%" result)

;; リスト要素を改行区切りで出力
(format t "~{~a~%~}" result-list)

;; リスト要素をスペース区切りで出力
(format t "~{~a~^ ~}~%" result-list)
```

## プログラム終了処理

```lisp
;; 処理系ごとの離脱用コード（必須）
#+sbcl (sb-ext:exit)
#+ccl (ccl:quit)
#+ecl (ext:quit)
#-(or sbcl ccl ecl) (quit)
```

## よく使う条件分岐パターン

### 範囲判定
```lisp
(cond ((<= r 99) (1+ (- 99 r)))
      ((<= r 199) (1+ (- 199 r)))
      ((<= r 299) (1+ (- 299 r))))
```

### 文字列比較
```lisp
(and (string= (nth 0 tokens) "AtCoder")
     (string= (nth 1 tokens) "Land"))
```

## 頻出アルゴリズムパターン

### 組み合わせ生成
```lisp
;; 全ペア生成（重複組み合わせ）
(let ((result '()))
  (loop for i from 0 to (1- (length sl))
        do (loop for j from 0 to (1- (length sl))
                 when (not (= i j))
                   do (setf result (append result (list (concatenate 'string 
                                                                    (nth i sl) 
                                                                    (nth j sl)))))))
  (remove-duplicates result :test #'string=))
```

### 動的更新処理
```lisp
;; 要素の追加・削除による状態管理
(loop for a in alist
      do (progn
           (if (member a blist)
               (setf blist (remove a blist))
               (setf blist (append blist (list a))))
           ;; 現在の状態を出力
           (format t "~a~%" (process-current-state blist))))
```
