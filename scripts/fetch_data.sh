#!/usr/bin/env bash
# 從公開的 Google Sheet 抓五張表成 CSV，不用登入、不用安裝任何東西
set -e
SHEET_ID="1drsIQsef0R-Kxf3lccrOr6-FYX8O9r9sufl1mNdx5gU"
cd "$(dirname "$0")/../data"
for t in inventory production_schedule vendors policy supplier_notices; do
  curl -sL "https://docs.google.com/spreadsheets/d/${SHEET_ID}/gviz/tq?tqx=out:csv&sheet=${t}" -o "${t}.csv"
  # 分頁不存在時 Google 會回第一張表，用表頭驗一下
  case "$t" in
    supplier_notices) key="notice_date";; policy) key="rule_id";; vendors) key="vendor_name";;
    production_schedule) key="order_id";; *) key="material_code";;
  esac
  if ! head -1 "${t}.csv" | grep -q "$key"; then
    if [ "$t" = supplier_notices ]; then echo "supplier_notices       （Sheet 無此分頁，改讀 inbox/）"; else echo "⚠️  ${t}：Sheet 裡沒有這個分頁（或表頭不對）"; fi; rm -f "${t}.csv"; continue
  fi
  printf '%-22s %s 列\n' "$t" "$(($(wc -l < "${t}.csv") - 1))"
done
