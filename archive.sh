#!/bin/bash

# 競技プログラミング準備スクリプト
# 使用方法: ./setup.sh abc 333 a

# 引数チェック
if [ $# -ne 3 ]; then
    echo "使用方法: $0 <大会> <番号> <問題>"
    echo "例: $0 abc 333 a"
    exit 1
fi

CONTEST=$1
NUMBER=$2
PROBLEM=$3

# ディレクトリ名を組み立て
TARGET_DIR="${CONTEST}/${NUMBER}/${PROBLEM}"

echo "=== 競技プログラミング準備開始 ==="
echo "作成先: ${TARGET_DIR}"

# ディレクトリ作成
echo "1. ディレクトリ作成中..."
mkdir -p "${TARGET_DIR}"

if [ $? -eq 0 ]; then
    echo "   ✓ ${TARGET_DIR} を作成しました"
else
    echo "   ✗ ディレクトリ作成に失敗しました"
    exit 1
fi

# main.lispとtxtファイルを複製
echo "2. ファイル複製中..."

# main.lispが存在するかチェック
if [ -f "main.lisp" ]; then
    cp main.lisp "${TARGET_DIR}/"
    echo "   ✓ main.lisp を複製しました"
else
    echo "   ! main.lisp が見つかりません"
fi

# txtファイルを複製
txt_files=$(ls *.txt 2>/dev/null)
if [ -n "$txt_files" ]; then
    cp *.txt "${TARGET_DIR}/"
    echo "   ✓ txtファイルを複製しました: $txt_files"
else
    echo "   ! txtファイルが見つかりません"
fi

# txtファイルをクリア
echo "3. txtファイルクリア中..."
for file in *.txt; do
    if [ -f "$file" ]; then
        > "$file"  # ファイルを空にする
        echo "   ✓ $file をクリアしました"
    fi
done

# main.lispをテンプレートで置き換え
echo "4. main.lispをテンプレートで初期化中..."
if [ -f "_template.lisp" ]; then
    cp _template.lisp main.lisp
    echo "   ✓ main.lisp をテンプレートで初期化しました"
else
    echo "   ! _template.lisp が見つかりません"
    echo "   ! テンプレートファイルを作成してください"
    
    # 簡単なテンプレートを作成
    cat > main.lisp << 'EOF'
#!/usr/bin/env ros
;; -*- mode: lisp -*-

;; 入力読み取り
(defun read-ints ()
  "スペース区切りの整数を読み取ってリストで返す"
  (mapcar #'parse-integer (uiop:split-string (read-line))))

(defun main ()
  ;; ここに解答を書く
  (let ((n (read)))
    (format t "~a~%" n)))

;; 実行
(main)
EOF
    echo "   ✓ 基本テンプレートを作成しました"
fi

echo ""
echo "=== 準備完了！ ==="
echo "作業ディレクトリ: ${TARGET_DIR}"
echo "バックアップ: ${TARGET_DIR}/main.lisp, ${TARGET_DIR}/*.txt"
