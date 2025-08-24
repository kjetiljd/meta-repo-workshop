Param(
  [string]$Name = "meta-repo-workshop-tools",
  [string]$Tag = "latest"
)

$ErrorActionPreference = "Stop"

# Resolve paths
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Resolve-Path (Join-Path $ScriptDir "..")

# Build image if missing
$img = "$Name:$Tag"
try {
  docker image inspect $img | Out-Null
} catch {
  Write-Host "Building $img from $ScriptDir" -ForegroundColor Cyan
  docker build -t $img $ScriptDir
}

# Run shell with repo mounted at /work
Write-Host "Starting shell with repo mounted at /work" -ForegroundColor Cyan
# Use quotes for Windows path
$mount = "$($RepoRoot.Path):/work"
docker run --rm -it -v $mount -w /work $img bash

