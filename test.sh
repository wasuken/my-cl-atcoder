#!/bin/bash
for file in [0-9]*.txt; do
    # ファイルが存在し、かつ空でない場合のみ処理を実行
    if [ -f "$file" ] && [ -s "$file" ]; then
        ros -L sbcl -Q -- --script main.lisp < "$file"
        echo ""
    elif [ -f "$file" ]; then
        # ファイルは存在するが空の場合
        echo "ファイル $file は空です。スキップします。"
        echo ""
    fi
done
