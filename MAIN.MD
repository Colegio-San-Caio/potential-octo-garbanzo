# MAIN - potential-octo-garbanzo - KAI OLAF KETELHUT

## What is this?
Font repo. NOT the website.
Website repo is: kaiolafketelhut.github.io / ~/site-index
Do not mix the two repos.

## HARD RULES
1. fnt/MAIN.FNT = font data, KEEP. Never delete, never rename.
2. NO *.bak / *.BAK files. Ever.
3. NO cover.jpg / cover.png here. Cover lives only in site-index.
4. No index.html / main.html here. HTML lives only in site-index.

## Agents
- bluh = checker agent. Run: ./bluh.sh
- bluh definition: claude/agents/bluh.md

## Hooks
- .git/hooks/pre-commit = blocks .bak

## Commands
- Check: ./bluh.sh
- Push: git add -A; git commit -m "..."; git push
