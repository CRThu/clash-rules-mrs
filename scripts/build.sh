#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${BASE_URL:-https://fastly.jsdelivr.net/gh/Loyalsoldier/clash-rules@release}"
RAW_DIR="raw/loyalsoldier"
OUT_DIR="out/loyalsoldier"

mkdir -p "$RAW_DIR" "$OUT_DIR"

DOMAIN_RULES=("reject" "icloud" "apple" "google" "proxy" "direct" "private" "gfw" "greatfire" "tld-not-cn")
IPCIDR_RULES=("telegramcidr" "cncidr" "lancidr")

echo "===> [1/2] Converting domain rulesets to .mrs (loyalsoldier)..."
for name in "${DOMAIN_RULES[@]}"; do
  echo "  -> Converting $name.txt -> $name.mrs"
  curl -fsSL "$BASE_URL/$name.txt" -o "$RAW_DIR/$name.txt"
  mihomo convert-ruleset domain yaml "$RAW_DIR/$name.txt" "$OUT_DIR/$name.mrs"
done

echo "===> [2/2] Converting ipcidr rulesets to .mrs (loyalsoldier)..."
for name in "${IPCIDR_RULES[@]}"; do
  echo "  -> Converting $name.txt -> $name.mrs"
  curl -fsSL "$BASE_URL/$name.txt" -o "$RAW_DIR/$name.txt"
  mihomo convert-ruleset ipcidr yaml "$RAW_DIR/$name.txt" "$OUT_DIR/$name.mrs"
done

echo "===> Conversion completed successfully."
ls -lh "$OUT_DIR"
