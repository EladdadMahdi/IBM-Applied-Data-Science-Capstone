#!/bin/bash
# Exécutez localement dans votre env Jupyter Book
pkgs=("scikit-learn" "pandas" "numpy")
badges=()

for pkg in "${pkgs[@]}"; do
  ver=$(pip show $pkg 2>/dev/null | grep Version | cut -d: -f2 | xargs)
  badges+=("![$pkg](https://img.shields.io/badge/$pkg-$ver-blue)")
done

echo "=== BADGES ===" > badges.txt
printf '%s\n' "${badges[@]}" >> badges.txt
echo "Copiez badges.txt dans README.md"
