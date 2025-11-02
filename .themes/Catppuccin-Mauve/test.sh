#!/usr/bin/env bash

CUR_THEME_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
THEME="$(echo "${CUR_THEME_DIR##*/}")"

echo $THEME
