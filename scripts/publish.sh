#! /bin/bash

set -e

# 打印当前工作路径
pwd
remote=$(git config remote.origin.url)
echo "remote is: ${remote}"

mkdir gh-pages-branch
cd gh-pages-branch

git config --global user.email "$GH_EMAIL" >/dev/null 2>&1
git config --global user.name "$GH_NAME" >/dev/null 2>&1
git init
git remote add --fetch origin "$remote"

if git rev-parse --verify origin/gh-pages >/dev/null 2>&1; then
  git checkout gh-pages
  git rm -rf .
else
  git checkout --orphan gh-pages
fi

cp -a "../build/." .

git add -A
git commit --allow-empty -m "Deploy to GitHub"
git push --force --quiet origin gh-pages
cd ..
rm -rf gh-pages-branch

echo "Finished Deployment!"











