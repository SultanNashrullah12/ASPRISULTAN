# 6 Skills Installation Guide

Installed on: 2026-10-27

## Skills List

6 skill repositories have been set up for this project:

| # | Skill | Repository | Description |
|---|-------|------------|-------------|
| 1 | `very-deep-search` | https://github.com/matkumatmat/very-deep-search | Multi-agent gather-and-verify pipeline for deep literature search |
| 2 | `humanizer-indonesia` | https://github.com/adhiprib/humanizer-indonesia | Polish Indonesian text to not read as AI-generated or machine-translated |
| 3 | `sharemaxxing` | https://github.com/fachrynuzuli/sharemaxxing | Rewrite social media posts for maximum shareability |
| 4 | `imozuru` | https://github.com/MaryCache/imozuru | Research new fields by tracing terminology → people → media → canonical sources |
| 5 | `tafsir-lookup` | https://github.com/B-ngoen/sirah-tafsir-skills | Verbatim classical Quranic exegesis with exact citations |
| 6 | `sirah-lookup` | https://github.com/B-ngoen/sirah-tafsir-skills | Verbatim Arabic sirah (Prophet biography) and Companion biographies |
| 7 | `hadith-lookup` | https://github.com/B-ngoen/sirah-tafsir-skills | Verbatim Arabic hadith from 12 classical books |

Plus `claude-howto` (tutorial repo with example skills).

## Installation

### Local Installation (One-time setup)

```bash
mkdir -p ~/.claude/skills

# Clone each repository
git clone --depth 1 https://github.com/matkumatmat/very-deep-search.git ~/.claude/skills/very-deep-search
git clone --depth 1 https://github.com/adhiprib/humanizer-indonesia.git ~/.claude/skills/humanizer-indonesia
git clone --depth 1 https://github.com/fachrynuzuli/sharemaxxing.git ~/.claude/skills/sharemaxxing
git clone --depth 1 https://github.com/MaryCache/imozuru.git ~/.claude/skills/imozuru
git clone --depth 1 https://github.com/B-ngoen/sirah-tafsir-skills.git ~/.claude/skills/sirah-tafsir-skills
git clone --depth 1 https://github.com/luongnv89/claude-howto.git ~/.claude/skills/claude-howto

# Create symlinks for nested skills
cd ~/.claude/skills
ln -sfn imozuru/skills/imozuru imozuru-skill
ln -sfn sirah-tafsir-skills/skills/hadith-lookup hadith-lookup
ln -sfn sirah-tafsir-skills/skills/sirah-lookup sirah-lookup
ln -sfn sirah-tafsir-skills/skills/tafsir-lookup tafsir-lookup
```

### Verify Installation

```bash
ls -la ~/.claude/skills/
# Check SKILL.md files are readable:
test -f ~/.claude/skills/very-deep-search/SKILL.md && echo "✓ very-deep-search"
test -f ~/.claude/skills/humanizer-indonesia/SKILL.md && echo "✓ humanizer-indonesia"
test -f ~/.claude/skills/sharemaxxing/SKILL.md && echo "✓ sharemaxxing"
test -f ~/.claude/skills/imozuru-skill/SKILL.md && echo "✓ imozuru"
test -f ~/.claude/skills/hadith-lookup/SKILL.md && echo "✓ hadith-lookup"
test -f ~/.claude/skills/sirah-lookup/SKILL.md && echo "✓ sirah-lookup"
test -f ~/.claude/skills/tafsir-lookup/SKILL.md && echo "✓ tafsir-lookup"
```

## Note: Databases

For `tafsir-lookup`, `sirah-lookup`, and `hadith-lookup` skills:
- Databases (~76 MB total) are automatically downloaded on first use
- Location: `~/.cache/claude-skills/` or within the skill's `assets/` folder
- No manual download required

## Usage Examples

After installation, skills are available in Claude Code:

- **very-deep-search**: For deep literature research with verification
- **humanizer-indonesia**: Polish Indonesian writing style
- **sharemaxxing**: Maximize social media post engagement
- **imozuru**: Trace academic/technical field from general terms to canonical sources
- **tafsir-lookup**: Look up Quranic exegesis: `tafsir QS 2:255 menurut Thabari`
- **sirah-lookup**: Look up Prophet biography: `kisah Badar menurut Ibnu Hisyam`
- **hadith-lookup**: Look up hadith: `HR. Bukhari no. 1`

## Updates

To update all skills:

```bash
cd ~/.claude/skills
for repo in very-deep-search humanizer-indonesia sharemaxxing imozuru sirah-tafsir-skills claude-howto; do
  git -C "$repo" pull
done
```
