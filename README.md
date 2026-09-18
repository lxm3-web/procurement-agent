# procurement-agent — 採購異常處理專員（CC 版）

同事拿到這包後：
1. 安裝 Claude Code（一次）
2. 在這個資料夾開終端機，輸入 `claude`
3. 把供應商的延遲通知存成 txt 丟進 `inbox/`（已附一封示範）→ 說「掃一下」→ 它列出待處理異常 → 說「處理 AB123」→ 它把詢價信寫到 `outbox/` → 看完說「寄」

不用裝 Google Drive、不用登入任何帳號：資料從公開的 Google Sheet 用 `scripts/fetch_data.sh` 抓下來。
資料全部是教學用假資料。
