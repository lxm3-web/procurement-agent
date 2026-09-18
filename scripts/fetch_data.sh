#!/usr/bin/env bash
# 從公開的 Google Sheet 更新五張表成 CSV。抓不到（沒網路、環境擋 docs.google.com）就沿用 repo 內附的快照，照樣能跑。
SHEET_ID="1drsIQsef0R-Kxf3lccrOr6-FYX8O9r9sufl1mNdx5gU"
cd "$(dirname "$0")/../data"
for t in inventory production_schedule vendors policy supplier_notices; do
  case "$t" in
    supplier_notices) key="notice_date";; policy) key="rule_id";; vendors) key="vendor_name";;
    production_schedule) key="order_id";; *) key="material_code";;
  esac
  tmp="${t}.csv.new"
  if curl -sL --max-time 15 "https://docs.google.com/spreadsheets/d/${SHEET_ID}/gviz/tq?tqx=out:csv&sheet=${t}" -o "$tmp" && head -1 "$tmp" | grep -q "$key"; then
    mv "$tmp" "${t}.csv"; printf '%-22s %s 列（已更新）\n' "$t" "$(($(wc -l < "${t}.csv") - 1))"
  else
    rm -f "$tmp"
    if [ -f "${t}.csv" ]; then printf '%-22s %s 列（沿用快照）\n' "$t" "$(($(wc -l < "${t}.csv") - 1))"
    elif [ "$t" = supplier_notices ]; then echo "supplier_notices       （無，改讀 inbox/）"
    else echo "⚠️  ${t}：抓不到也沒有快照"; fi
  fi
done
