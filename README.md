# procurement-agent — 採購異常處理專員（CC 版）

同事拿到這包後：
1. 安裝 Claude Code（一次）
2. 在這個資料夾開終端機，輸入 `claude`
3. 把供應商的延遲通知存成 txt 丟進 `inbox/`（已附一封示範）→ 說「掃一下」→ 它列出待處理異常 → 說「處理 AB123」→ 它把詢價信寫到 `outbox/` → 看完說「寄」

不用裝 Google Drive、不用登入任何帳號：五張表的快照已在 `data/`；能連網時 `scripts/fetch_data.sh` 會從公開 Sheet 更新。

**在瀏覽器跑**：claude.ai/code → New session → 選這個 repo → 打「掃一下」。

**demo 完要歸零**：把 `inbox/*.txt.done` 改回 `.txt`、清空 `outbox/`、`log/incident_log.md` 只留表頭。
資料全部是教學用假資料。
