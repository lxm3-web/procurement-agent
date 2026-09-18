# detect — 掃一下有沒有異常

1. 跑 `scripts/fetch_data.sh` 更新 `data/`
2. 讀 `inbox/` 裡副檔名是 `.txt` 的每一封（`.done` 結尾的是已處理，跳過），從信裡抓：通知日、供應商、料號、延遲天數、原因；若 `data/supplier_notices.csv` 存在，也把 `status` 不是 done 的列一起算進來
3. 對每一筆先算「撐幾天」（inventory），照撐幾天由少到多排
4. 另外掃 `inventory`：`current_stock < safety_stock` 但沒有通知的料號，列成「提醒」，不處理
5. 回報格式：
   ```
   待處理 N 筆：
   1. AB123 晶片A — 原供應商延遲 14 天，庫存撐 1 天 ← 建議先處理
   2. …
   提醒（低於安全庫存、尚無通知）：M010、…
   要我處理第 1 筆嗎？
   ```
6. 沒有待處理 → 說「目前沒有異常通知」，把提醒列出來就好
