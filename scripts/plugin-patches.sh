#!/usr/bin/env bash
# Apply or revert local patches to lazy.nvim-managed plugins.
#
# Patches live in <config>/patches/<plugin-name>/*.patch and are applied to
# ~/.local/share/nvim/lazy/<plugin-name>. Idempotent in both directions:
#
#   plugin-patches.sh apply    # apply all patches not yet applied
#   plugin-patches.sh revert   # restore pristine upstream state
#
# "revert" is meant to run before :Lazy update/sync/restore so git can check
# out the new commit cleanly; "apply" re-applies afterwards. If a patch has
# been merged upstream it is detected as already applied and skipped, so it
# can simply be deleted from patches/ once that happens.

set -euo pipefail

LAZY_DIR="${LAZY_DIR:-$HOME/.local/share/nvim/lazy}"
PATCHES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../patches" && pwd)"
ACTION="${1:-apply}"
STATUS=0

for plugin_dir in "$PATCHES_DIR"/*/; do
  plugin="$(basename "$plugin_dir")"
  repo="$LAZY_DIR/$plugin"

  if [[ ! -d "$repo/.git" ]]; then
    echo "WARN [$plugin] not installed at $repo, skipping"
    continue
  fi

  for patch in "$plugin_dir"*.patch; do
    [[ -e "$patch" ]] || continue
    name="$(basename "$patch")"

    case "$ACTION" in
      apply)
        if git -C "$repo" apply --reverse --check "$patch" 2>/dev/null; then
          echo "OK   [$plugin] $name already applied (or merged upstream)"
        elif git -C "$repo" apply --check "$patch" 2>/dev/null; then
          git -C "$repo" apply "$patch"
          echo "OK   [$plugin] $name applied"
        else
          echo "FAIL [$plugin] $name no longer applies cleanly -- upstream changed, regenerate the patch"
          STATUS=1
        fi
        ;;
      revert)
        # Only touch the tree if it is actually dirty; a clean tree either has
        # no patch applied or the fix was merged upstream (leave that alone).
        if git -C "$repo" diff --quiet; then
          echo "OK   [$plugin] $name working tree clean, nothing to revert"
        elif git -C "$repo" apply --reverse --check "$patch" 2>/dev/null; then
          git -C "$repo" apply --reverse "$patch"
          echo "OK   [$plugin] $name reverted"
        else
          echo "FAIL [$plugin] $name tree is dirty but patch does not reverse cleanly -- resolve manually"
          STATUS=1
        fi
        ;;
      *)
        echo "usage: $(basename "$0") [apply|revert]" >&2
        exit 2
        ;;
    esac
  done
done

exit "$STATUS"
