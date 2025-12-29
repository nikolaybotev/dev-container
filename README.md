# Dev Container Configuration

This directory contains the VS Code Dev Container configuration for this project.

## Quick Start

### First Time Setup

1. **Build the base image**:
   ```bash
   ./build-image.sh
   ```

2. **Install the dev container configuration in your workspace**:
   ```bash
   ./install.sh <workspace-directory>
   ```

   This will create a `.devcontainer/` directory in your workspace and copy files from the `deployment/` directory:
   - `devcontainer.json`
   - `turn-off-git-signing.sh`

3. **Open in Dev Container**:
   - Open the workspace in VS Code
   - Run `Cmd+Shift+P` → "Dev Containers: Reopen in Container"
   - Wait for container to start (uses pre-built image, should be fast)

### Daily Usage

Just open the project in VS Code - the container will start automatically using the pre-built image.

**No rebuild needed** unless you change the Dockerfile or want to update packages.

## Configuration Files

### `deployment/devcontainer.json`
Main configuration file (installed to workspaces) that:
- Uses pre-built image: `nikolaybotev.com/dev:homebrew`
- Mounts workspace, config, and SSH keys
- Sets up VS Code extensions
- Disables git commit signing on container start

### `Dockerfile`
Defines the base image with:
- Homebrew package manager
- Cloud CLIs (gcloud, aws, gh, glab)
- Development tools (terraform, vim, htop, mc)
- Custom bootstrap configuration

### Scripts

- **`build-image.sh`** - Build/rebuild the base Docker image
- **`install.sh`** - Install dev container configuration to a workspace (copies files from `deployment/`)
- **`deployment/turn-off-git-signing.sh`** - Disables git commit and tag signing (runs on container start)

## Features

### ✅ Pre-Built Image
- Fast container startup (no rebuild each time)
- Consistent environment
- Rebuild only when Dockerfile changes

### ✅ SSH Key Access
- Runtime mount of `~/.ssh` from host
- Git operations use your host SSH keys
- GitHub/GitLab authentication works

### ✅ Cloud CLI Tools
- Google Cloud SDK (gcloud)
- AWS CLI (aws)
- GitHub CLI (gh)
- GitLab CLI (glab)

### ✅ Development Tools
- Terraform
- vim, htop, mc
- Custom bootstrap configuration

### ⚠️ Git Commit Signing
**Note**: Git commits from within the dev environment will **not** be signed. The `turn-off-git-signing.sh` script automatically disables commit and tag signing when the container starts.

## Mounted Directories

From host → container:

| Host Path | Container Path | Purpose |
|-----------|----------------|---------|
| `~/git` | `/workspaces/git` | Workspace (your code) |
| `~/.claude` | `/home/linuxbrew/.claude` | Claude AI config |
| `~/.config` | `/home/linuxbrew/.config` | User config files |
| `~/.ssh` | `/home/linuxbrew/.ssh` | SSH keys |

## When to Rebuild

Rebuild the image when you:
- Change the `Dockerfile`
- Want to update brew packages
- Add/remove system tools

```bash
# Rebuild the image
./build-image.sh

# Restart the container
# VS Code: Cmd+Shift+P → "Dev Containers: Rebuild Container"
```

## Switching Between Image Modes

### Current: Pre-Built Image (Recommended)

```json
{
  "image": "nikolaybotev.com/dev:homebrew"
}
```

- ✅ Fast startup
- ✅ No rebuild on container restart
- ✅ Consistent environment

### Alternative: Auto-Build

```json
{
  "build": { "dockerfile": "Dockerfile" }
}
```

- ❌ Slower startup
- ❌ Rebuilds on every container restart
- ✅ Always uses latest Dockerfile

## Troubleshooting

### Container won't start

```bash
# Check if image exists
docker images | grep nikolaybotev.com/dev

# If missing, build it
./build-image.sh
```

### SSH not working

```bash
# Check if .ssh is mounted
ls -la ~/.ssh/

# Test SSH agent
ssh-add -l

# Test GitHub connection
ssh -T git@github.com
```

### Slow container startup

If using auto-build mode, switch to pre-built image:

1. Build the image once: `./build-image.sh`
2. Update `devcontainer.json` to use `"image"` instead of `"build"`
3. Restart container

## Advanced Usage

### Installing Configuration in a New Workspace

```bash
# From the dev-container directory
./install.sh /path/to/your/workspace
```

This will create `.devcontainer/` in your workspace with the necessary files.

### Pushing Image to Registry

```bash
# Build
./build-image.sh

# Tag for registry
docker tag nikolaybotev.com/dev:homebrew your-registry/dev:homebrew

# Push
docker push your-registry/dev:homebrew

# Update devcontainer.json
{
  "image": "your-registry/dev:homebrew"
}
```

### Using Different Base Image

Edit `Dockerfile`:

```dockerfile
# Change this line
FROM homebrew/brew:latest

# To something else, e.g.
FROM ubuntu:22.04
```

Then rebuild: `./build-image.sh`

### Adding More Tools

Edit `Dockerfile` to add more tools:

```dockerfile
# Add at the end
RUN brew install your-tool
```

Then rebuild: `./build-image.sh`

## Files Reference

```
dev-container/
├── README.md                    # This file
├── Dockerfile                   # Base image definition
├── Dockerfile-alpine            # Alternative Alpine-based image
├── build-image.sh               # Build base Docker image
├── install.sh                   # Install config to a workspace
└── deployment/                  # Files to install to workspaces
    ├── devcontainer.json        # VS Code Dev Container config
    └── turn-off-git-signing.sh  # Disable git signing (runs on container start)
```

## Resources

- [VS Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)
- [Dev Container Specification](https://containers.dev/)
- [Homebrew](https://brew.sh/)
