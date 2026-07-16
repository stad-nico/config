#!/bin/bash
set -e

if [[ "$1" == "--dry-run" ]]; then
    export DRY_RUN=1
fi

source ./variables.sh

SCRIPTS=(
  "install-packages.sh"
  "git-config.sh"
  "install-oh-my-zsh.sh"
  "install-rust.sh"
  "zellij-setup.sh"
  "link-dotfiles.sh"
)

TOTAL_STEPS=${#SCRIPTS[@]}

clear
echo -e "\n${BOLD}${C_PRIMARY}  /// SYSTEM BOOTSTRAP ///  ${RESET}\n"

if [ "$DRY_RUN" = "1" ]; then
    echo -e "  ${BOLD}${C_WARN}⚠ DRY-RUN MODE ACTIVE: No actual changes will be made. ⚠${RESET}\n"
else
    # Cache sudo credentials upfront so the script doesn't hang later
    echo -e "${PREFIX} ${C_TEXT}Please enter your sudo password to begin...${RESET}"
    sudo -v
    # Keep-alive: update existing `sudo` time stamp until `main.sh` has finished
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
fi

for index in "${!SCRIPTS[@]}"; do
  script="${SCRIPTS[index]}"
  step_num=$((index + 1))
  
  echo -e "${BOLD}${C_TEXT}╭─ [${step_num}/${TOTAL_STEPS}] ${C_SECONDARY}${script}${RESET}"
  
  if bash "$script" 2>&1 | sed -e "s/^/${C_MUTED}│${RESET}  /"; then
      echo -e "${BOLD}${C_TEXT}╰─ ${CHECK} ${C_SUCCESS}Success${RESET}\n"
  else
      echo -e "${BOLD}${C_TEXT}╰─ ${CROSS} ${C_ERROR}Failed${RESET}\n"
      exit 1
  fi
  sleep 0.2
done

echo -e "${BOLD}${C_SUCCESS}✦ ALL STEPS COMPLETED SUCCESSFULLY! ✦${RESET}"

if [ "$DRY_RUN" = "1" ]; then
    echo -e "\n${C_WARN}Dry run complete. Run without --dry-run to apply changes.${RESET}"
    exit 0
fi

# GitHub Authentication (Interactive)
echo -e "\n${C_WARN}==========================================================${RESET}"
echo -e "${BOLD}${C_TEXT}GITHUB AUTHENTICATION${RESET}"
echo -e "${C_TEXT}We can now automatically upload your SSH key to GitHub.${RESET}"
echo -e "${C_WARN}==========================================================${RESET}\n"

read -p "$(echo -e ${BOLD}${C_SECONDARY}"Would you like to authenticate with GitHub CLI now? (Y/n): "${RESET})" auth_choice < /dev/tty || true
if [[ "$auth_choice" =~ ^[Yy]$ ]] || [[ -z "$auth_choice" ]]; then
    echo -e "\n${PREFIX} ${C_TEXT}Starting GitHub login flow...${RESET}"
    # Run interactive gh auth
    gh auth login -p ssh -s "admin:public_key" --web < /dev/tty
    echo -e "${CHECK} ${C_SUCCESS}GitHub Authentication Complete!${RESET}"
else
    echo -e "\n${ARROW} ${C_MUTED}Skipping GitHub authentication. You can run 'gh auth login' later.${RESET}"
fi

echo -e "\n${C_TEXT}A reboot is recommended to apply the new Shell and PATH settings.${RESET}\n"

for i in {5..1}; do
    echo -ne "${ARROW} ${C_WARN}Rebooting in $i seconds... (Ctrl+C to cancel)${RESET}\r"
    sleep 1
done

echo -e "\n${C_SECONDARY}Rebooting now... See you on the other side!${RESET}"
exec zsh -l
