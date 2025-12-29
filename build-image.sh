#!/bin/bash
# Build Dev Container Image
# This script builds the dev container image that can be reused without rebuilding

set -e

IMAGE_NAME="${IMAGE_NAME:-nikolaybotev.com/dev:homebrew}"
DOCKERFILE="${DOCKERFILE:-./Dockerfile}"
BUILD_CONTEXT="${BUILD_CONTEXT:-.}"

echo "=========================================="
echo "Building Dev Container Image"
echo "=========================================="
echo "Image:      ${IMAGE_NAME}"
echo "Dockerfile: ${DOCKERFILE}"
echo "Context:    ${BUILD_CONTEXT}"
echo ""

# Build the image
echo "Building image..."
docker build \
    -t "${IMAGE_NAME}" \
    -f "${DOCKERFILE}" \
    "${BUILD_CONTEXT}"

echo ""
echo "=========================================="
echo "✓ Build Complete!"
echo "=========================================="
echo ""
echo "Image: ${IMAGE_NAME}"
echo ""
echo "To use this image:"
echo "1. Install the dev container configuration in your workspace:"
echo "   ./install.sh <workspace-directory>"
echo "2. Open the workspace in VS Code"
echo "3. Run 'Dev Containers: Reopen in Container'"
echo ""
