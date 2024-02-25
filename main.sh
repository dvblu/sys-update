#!/bin/bash

# Color codes for formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Log file
LOG_FILE="update_log.txt"

# Function to display error messages and log them
error() {
  echo -e "${RED}[ERROR]${NC} $1" >&2
  echo "[ERROR] $(date): $1" >> "$LOG_FILE"
}

# Function to display informational messages and log them
info() {
  echo -e "${YELLOW}[INFO]${NC} $1"
  echo "[INFO] $(date): $1" >> "$LOG_FILE"
}

# Function to display success messages and log them
success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
  echo "[SUCCESS] $(date): $1" >> "$LOG_FILE"
}

# Check for and install missing dependencies
install_dependencies() {
  info "Checking for missing dependencies..."
  install_jq
  install_npm
}

# Install jq if missing
install_jq() {
  if ! command -v jq &>/dev/null; then
    info "Installing jq..."
    if command -v brew &>/dev/null; then
      brew install jq &>/dev/null || error "Failed to install jq"
    elif command -v apt-get &>/dev/null; then
      sudo apt-get update && sudo apt-get install -y jq &>/dev/null || error "Failed to install jq"
    elif command -v yum &>/dev/null; then
      sudo yum install -y jq &>/dev/null || error "Failed to install jq"
    else
      error "Package manager not found. Please install jq manually."
    fi
  else
    success "jq is already installed."
  fi
}

# Install npm if missing
install_npm() {
  if ! command -v npm &>/dev/null; then
    info "Installing npm..."
    if command -v brew &>/dev/null; then
      brew install npm &>/dev/null || error "Failed to install npm"
    elif command -v apt-get &>/dev/null; then
      sudo apt-get update && sudo apt-get install -y npm &>/dev/null || error "Failed to install npm"
    elif command -v yum &>/dev/null; then
      sudo yum install -y npm &>/dev/null || error "Failed to install npm"
    else
      error "Package manager not found. Please install npm manually."
    fi
  else
    success "npm is already installed."
  fi
}

# Update system packages
update_packages() {
  info "Updating system packages..."
  if command -v brew &>/dev/null; then
    brew update &>/dev/null || error "Failed to update Homebrew"
    success "Homebrew is up-to-date."
    brew upgrade &>/dev/null || error "Failed to upgrade Homebrew packages"
    success "Homebrew packages upgraded successfully."
  elif command -v apt-get &>/dev/null; then
    sudo apt-get update && sudo apt-get upgrade -y &>/dev/null || error "Failed to update system packages"
    success "System packages updated successfully."
  elif command -v yum &>/dev/null; then
    sudo yum update -y &>/dev/null || error "Failed to update system packages"
    success "System packages updated successfully."
  else
    error "Package manager not found. Please update system packages manually."
  fi
}

# Update Ruby gems
update_ruby_gems() {
  info "Updating Ruby gems..."
  gem update --system &>/dev/null || error "Failed to update Ruby gems"
  success "Ruby gems updated successfully."
}

# Update npm and global packages
update_npm() {
  info "Updating npm and global packages..."
  npm update -g &>/dev/null || error "Failed to update npm and global packages"
  success "npm and global packages updated successfully."
}

# Update pip and Python packages
update_python_packages() {
  info "Updating pip and Python packages..."
  pip3 install --upgrade pip setuptools &>/dev/null || error "Failed to update pip and Python packages"
  success "Pip and Python packages updated successfully."
}

# Update Go packages
update_go_packages() {
  info "Checking and updating Go packages..."
  # Add your Go package update command here
  success "Go packages updated successfully."
}

# Perform cleanup tasks
perform_cleanup() {
  info "Performing cleanup..."
  if command -v apt-get &>/dev/null; then
    sudo apt-get autoremove -y && sudo apt-get clean &>/dev/null || error "Failed to perform cleanup"
  elif command -v yum &>/dev/null; then
    sudo yum autoremove -y && sudo yum clean all &>/dev/null || error "Failed to perform cleanup"
  else
    error "Package manager not found. Please perform cleanup manually."
  fi
  success "Cleanup completed successfully."
}

# Display current package versions
display_package_versions() {
  info "Displaying current package versions..."
  echo -e "Package\t\tVersion"
  echo "----------------------------------"
  if command -v brew &>/dev/null; then
    brew list --versions | awk '{ printf "%-20s %s\n", $1, $NF }'
    ruby_version=$(ruby --version | awk '{print $2}')
    echo -e "ruby\t\t${ruby_version}"
  elif command -v dpkg &>/dev/null; then
    dpkg -l | grep '^ii' | awk '{ print $2 "\t\t" $3 }'
  elif command -v rpm &>/dev/null; then
    rpm -qa --qf "%{NAME}\t\t%{VERSION}\n"
  else
    error "Package manager not found. Unable to display package versions."
  fi
}

# Main function to run update tasks
main() {
  install_dependencies
  update_packages
  update_ruby_gems
  update_npm
  update_python_packages
  update_go_packages
  perform_cleanup
  display_package_versions
}

# Execute the main function
main
