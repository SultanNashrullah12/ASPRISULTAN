#!/bin/bash
# Install 6 Claude Code skills to ~/.claude/skills/
# Usage: bash .claude/scripts/install-skills.sh

set -e

SKILLS_DIR="$HOME/.claude/skills"
mkdir -p "$SKILLS_DIR"

echo "Installing 6 Claude Code skills to $SKILLS_DIR"
echo

REPOS=(
  "matkumatmat/very-deep-search"
  "adhiprib/humanizer-indonesia"
  "fachrynuzuli/sharemaxxing"
  "MaryCache/imozuru"
  "B-ngoen/sirah-tafsir-skills"
  "luongnv89/claude-howto"
)

for repo in "${REPOS[@]}"; do
  owner_repo="$repo"
  repo_name="${repo##*/}"
  target_dir="$SKILLS_DIR/$repo_name"

  echo "[$repo_name]"

  if [ -d "$target_dir/.git" ]; then
    echo "  Updating..."
    git -C "$target_dir" pull --quiet 2>/dev/null && echo "  ✓ Updated" || echo "  ⚠ Update failed"
  else
    echo "  Cloning..."
    git clone --depth 1 --quiet "https://github.com/$owner_repo.git" "$target_dir" 2>/dev/null && echo "  ✓ Installed" || echo "  ✗ Clone failed"
  fi
done

echo
echo "Creating symlinks for nested skills..."

cd "$SKILLS_DIR"

# Create symlinks for imozuru
if [ -d "imozuru/skills/imozuru" ]; then
  ln -sfn "imozuru/skills/imozuru" "imozuru-skill" && echo "  ✓ imozuru-skill"
fi

# Create symlinks for sirah skills
if [ -d "sirah-tafsir-skills/skills" ]; then
  ln -sfn "sirah-tafsir-skills/skills/hadith-lookup" "hadith-lookup" && echo "  ✓ hadith-lookup"
  ln -sfn "sirah-tafsir-skills/skills/sirah-lookup" "sirah-lookup" && echo "  ✓ sirah-lookup"
  ln -sfn "sirah-tafsir-skills/skills/tafsir-lookup" "tafsir-lookup" && echo "  ✓ tafsir-lookup"
fi

echo
echo "Verifying installation..."
echo

SKILLS_TO_CHECK=(
  "very-deep-search/SKILL.md"
  "humanizer-indonesia/SKILL.md"
  "sharemaxxing/SKILL.md"
  "imozuru-skill/SKILL.md"
  "hadith-lookup/SKILL.md"
  "sirah-lookup/SKILL.md"
  "tafsir-lookup/SKILL.md"
)

all_ok=true
for skill in "${SKILLS_TO_CHECK[@]}"; do
  if [ -f "$SKILLS_DIR/$skill" ]; then
    echo "✓ ${skill%/*}"
  else
    echo "✗ ${skill%/*} (SKILL.md not found)"
    all_ok=false
  fi
done

echo
if [ "$all_ok" = true ]; then
  echo "✅ All skills installed successfully!"
  echo "Skills are available in Claude Code starting from the next turn."
else
  echo "⚠️  Some skills may have failed to install."
  exit 1
fi
