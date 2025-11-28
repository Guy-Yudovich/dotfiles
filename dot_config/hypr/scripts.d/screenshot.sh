#!/bin/bash

set -e

SCREENSHOT_DIR="${SCREENSHOT_DIR:-$HOME/Pictures/Screenshots}"
FILENAME="screenshot_$(date +%Y%m%d_%H%M%S).png"
FILEPATH="${SCREENSHOT_DIR}/${FILENAME}"
TMP_FILEPATH="/tmp/${FILENAME}"
mkdir -p "${SCREENSHOT_DIR}"

if [[ "${FREEZE,,}" == "true" ]]; then
	wayfreeze &
	WAYFREEZE_PID=$!
fi

grimblast save area "${TMP_FILEPATH}"

if [[ "${FREEZE,,}" == "true" ]]; then
	kill "${WAYFREEZE_PID}" 2> /dev/null
fi

if ! [[ -f "${TMP_FILEPATH}" ]]; then
	exit 0
fi

satty --filename "${TMP_FILEPATH}" \
    --output-filename "${FILEPATH}" \
    --copy-command 'wl-copy'
