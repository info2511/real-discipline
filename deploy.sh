#!/usr/bin/env bash
# deploy.sh — real-discipline launch 重部署流: commit+push → Pages 重建 → verify-live 闸收口。
# MECE 修正3: 把 verify-live.sh 接进一条真流, 让闸后面真有东西(不再是孤立组件)。
set -uo pipefail
cd "$(dirname "$0")"
URL="https://info2511.github.io/real-discipline/"
TOKEN="羞耻是这台机器的燃料"   # 对页才有的刀尖句, 非泛词
echo "== commit+push =="
git add -A
git commit -q -m "redeploy real-discipline ($(date +%F))

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>" 2>&1 | tail -1 || echo "[无改动, 跳过 commit]"
git push -q origin main 2>&1 | tail -2 || echo "[push: up-to-date]"
echo "== 验活闸(GitHub Pages 构建有延迟, 轮询; 没打得开不报上线) =="
"$HOME/projects/verify-live.sh" "$URL" "$TOKEN" "/tmp/real-discipline-live.png" 12
