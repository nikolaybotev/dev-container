#!/bin/bash
# Install Dev Container Configuration
# This script copies devcontainer.json and turn-off-git-signing.sh to a workspace's .devcontainer directory

set -e

if [ $# -eq 0 ]; then
    echo "Usage: $0 <workspace-target-directory>"
    echo ""
    echo "Example:"
    echo "  $0 /path/to/my/project"
    echo ""
    echo "This will create .devcontainer/ in the target directory and copy files from the deployment/ directory:"
    echo "  - devcontainer.json"
    echo "  - turn-off-git-signing.sh"
    exit 1
fi

TARGET_DIR="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEVCONTAINER_DIR="${TARGET_DIR}/.devcontainer"

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Target directory does not exist: $TARGET_DIR"
    exit 1
fi

echo "Installing dev container configuration..."
echo "Target directory: $TARGET_DIR"
echo ""

# Create .devcontainer directory if it doesn't exist
mkdir -p "$DEVCONTAINER_DIR"

# Copy deployment files
echo "Copying deployment files (devcontainer.json etc)..."
cp "${SCRIPT_DIR}/deployment/*" "${DEVCONTAINER_DIR}/"

echo ""
echo "=========================================="
echo "✓ Installation Complete!"
echo "=========================================="
echo ""
echo "Files installed to: ${DEVCONTAINER_DIR}/"
echo "  - devcontainer.json"
echo "  - turn-off-git-signing.sh"
echo ""
echo "Next steps:"
echo "1. Build the dev container image: cd ${SCRIPT_DIR} && ./build-image.sh"
echo "2. Open the workspace in VS Code"
echo "3. Run 'Dev Containers: Reopen in Container'"
echo ""
