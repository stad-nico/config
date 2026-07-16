#!/bin/bash
export NAME="Nicolas Stadler"
export EMAIL="stadlernicolas26@gmail.com"
export GITHUB_USERNAME="stad-nico"

# Modern Colors (ANSI escape codes)
export RESET=$'\033[0m'
export BOLD=$'\033[1m'
export DIM=$'\033[2m'
export ITALIC=$'\033[3m'

# Sleek palette
export C_PRIMARY=$'\033[38;5;63m'   # Indigo/Purple
export C_SECONDARY=$'\033[38;5;87m' # Cyan
export C_SUCCESS=$'\033[38;5;114m'  # Soft Green
export C_WARN=$'\033[38;5;215m'     # Soft Orange
export C_ERROR=$'\033[38;5;203m'    # Soft Red
export C_TEXT=$'\033[38;5;252m'     # Light Gray
export C_MUTED=$'\033[38;5;242m'    # Dark Gray

# UI Components
export PREFIX="${C_SECONDARY}❖${RESET}"
export CHECK="${C_SUCCESS}✔${RESET}"
export CROSS="${C_ERROR}✖${RESET}"
export ARROW="${C_PRIMARY}➜${RESET}"
export BULLET="${C_MUTED}•${RESET}"

# Helper function for executing commands
execute() {
    if [ "$DRY_RUN" = "1" ]; then
        echo -e "  ${DIM}» [dry-run] $1${RESET}"
        sleep 0.1
    else
        eval "$1"
    fi
}
