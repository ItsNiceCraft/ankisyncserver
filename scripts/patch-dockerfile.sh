#!/bin/bash
set -e

RUST_VERSION=$(yq '.toolchain.channel' rust-toolchain.toml)
if [[ -z "$RUST_VERSION" ]]; then
  echo "Could not read toolchain.channel from rust-toolchain.toml"
  exit 1
fi

DOCKERFILE="docs/syncserver/Dockerfile"

if [[ ! -f "$DOCKERFILE" ]]; then
  echo "Dockerfile not found at $DOCKERFILE"
  exit 1
fi

sed -i -E "s|^(FROM rust:)[0-9]+\.[0-9]+\.[0-9]+(-alpine[^\s]*)|\1${RUST_VERSION}\2|" "$DOCKERFILE"

echo "Updated Rust version in $DOCKERFILE to $RUST_VERSION"

cat "$DOCKERFILE"