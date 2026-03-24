#!/bin/bash

source ./variables.sh

SCRIPTS=(
  "install-packages.sh"
  "git-config.sh"
  "install-oh-my-zsh.sh"
  "install-rust.sh"
  "setup-ssh.sh"
)

TOTAL_STEPS=${#SCRIPTS[@]}

for index in "${!SCRIPTS[@]}"; do
  script="${SCRIPTS[index]}"

  clear

  echo -e "\033[1;36m==========================================\033[0m"
  echo -e "\033[1m🚀 PROGRESS: Step $((index + 1)) of $TOTAL_STEPS ($script)\033[0m"
  echo -e "\033[1;36m==========================================\033[0m\n"

  DARK_GRAY=$'\e[38;5;240m'
  RESET=$'\e[0m'

  bash "$script" 2>&1 | sed -E "s/\x1B\[[0-9;]*[mK]//g; s/^/${DARK_GRAY}/; s/$/${RESET}/"

  sleep 1
done

clear

echo -e "DONE!"
echo -e "A reboot is recommended to apply the new Shell and PATH settings."

for i in {5..1}; do
    echo -ne "${YELLOW}Rebooting in $i seconds... (Ctrl+C to cancel)${RESET}\r"
    sleep 1
done

echo -e "\n${BLUE}Rebooting now... See you on the other side!${RESET}"
exec zsh -l
