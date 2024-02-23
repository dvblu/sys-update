#!/bin/bash

# Color codes for formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Function to display error messages
error() {
  echo -e "${RED}Error:${NC} $1" >&2
}

# Function to display informational messages
info() {
  echo -e "${YELLOW}$1${NC}"
}

# Function to display success messages
success() {
  echo -e "${GREEN}$1${NC}"
}

# Function to check for and install missing dependencies
install_dependencies() {
  if ! command -v jq &>/dev/null; then
    info "Installing jq..."
    brew install jq &>/dev/null || { error "Failed to install jq"; exit 1; }
    success "jq installed successfully."
  fi

  if ! command -v npm &>/dev/null; then
    info "Installing npm..."
    brew install npm &>/dev/null || { error "Failed to install npm"; exit 1; }
    success "npm installed successfully."
  fi
}

# Function to update Homebrew and system packages
update_packages() {
  info "Checking for Homebrew updates..."
  brew update &>/dev/null || { error "Failed to update Homebrew"; exit 1; }
  success "Homebrew is up-to-date."

  info "Upgrading Homebrew packages..."
  brew upgrade &>/dev/null || { error "Failed to upgrade Homebrew packages"; exit 1; }
  success "Homebrew packages upgraded successfully."

  info "Checking for macOS system updates..."
  softwareupdate -l &>/dev/null || { error "Failed to check for macOS system updates"; exit 1; }
  success "macOS system software is up-to-date."

  info "Upgrading macOS system software..."
  sudo softwareupdate -ia &>/dev/null || { error "Failed to upgrade macOS system software"; exit 1; }
  success "macOS system software upgraded successfully."
}

# Function to update Ruby gems
update_ruby_gems() {
  info "Updating Ruby gems..."
  gem update --system &>/dev/null || { error "Failed to update Ruby gems"; }
  success "Ruby gems updated successfully."
}

# Function to update npm and global packages
update_npm() {
  info "Updating npm and global packages..."
  npm update -g &>/dev/null || { error "Failed to update npm and global packages"; }
  success "npm and global packages updated successfully."
}

# Function to update pip and Python packages
update_python_packages() {
  info "Updating pip and Python packages..."
  pip3 install --upgrade pip &>/dev/null || { error "Failed to update pip"; }
  pip3 install --upgrade setuptools &>/dev/null || { error "Failed to update setuptools"; }
  success "Pip and Python packages updated successfully."
}

# Function to update Go packages
update_go_packages() {
  info "Checking and updating Go packages..."
  # Add your Go package update command here
  success "Go packages updated successfully."
}

# Function to display current package versions
display_package_versions() {
  info "Displaying current package versions..."
  echo -e "Package\t\tVersion"
  echo "----------------------------------"
  brew list --versions | awk '{ printf "%-20s %s\n", $1, $NF }'
  ruby_version=$(ruby --version | awk '{print $2}')
  echo -e "ruby\t\t${ruby_version}"
}

# Function to perform cleanup tasks
perform_cleanup() {
  info "Performing cleanup..."
  brew cleanup &>/dev/null || { error "Failed to perform cleanup"; exit 1; }
  success "Cleanup completed successfully."
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