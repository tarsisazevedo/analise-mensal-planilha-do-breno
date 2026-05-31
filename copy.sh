#!/bin/bash
 
REPO="$HOME/projects/analise-mensal-planilha-do-breno"
ORIGEM="$HOME/Documents/Claude/Projects/Analise financeira"
 
cp "$ORIGEM/README.md" "$REPO/"
cp "$ORIGEM/analise-financeira.skill" "$REPO/"
mkdir -p "$REPO/analise-financeira/references"
cp "$ORIGEM/analise-financeira/SKILL.md" "$REPO/analise-financeira/"
cp "$ORIGEM/analise-financeira/references/estrutura.md" "$REPO/analise-financeira/references/"
 
cd "$REPO"
git add .
git commit -m "feat: add skill and README"
git push
 
echo "Pronto!"