#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")/.."

export SOUNDEFFECT_MODEL_DIR=${SOUNDEFFECT_MODEL_DIR:-"/path/to/SoundEffect-v2-hf"}
export SOUNDEFFECT_DEVICE=${SOUNDEFFECT_DEVICE:-"cuda"}

HOST=${HOST:-"0.0.0.0"}
PORT=${PORT:-7861}
SHARE=${SHARE:-0}
# Set GRADIO_ROOT_PATH when serving behind a reverse proxy (e.g. /proxy/7861/).
GRADIO_ROOT_PATH=${GRADIO_ROOT_PATH:-""}

EXTRA=()
if [ "$SHARE" = "1" ]; then
  EXTRA+=(--share)
fi
if [ -n "$GRADIO_ROOT_PATH" ]; then
  EXTRA+=(--root_path "$GRADIO_ROOT_PATH")
fi

TORCHDYNAMO_DISABLE=${TORCHDYNAMO_DISABLE:-1} \
  python examples/gradio_app.py \
    --model_dir "$SOUNDEFFECT_MODEL_DIR" \
    --device "$SOUNDEFFECT_DEVICE" \
    --host "$HOST" \
    --port "$PORT" \
    "${EXTRA[@]}"
