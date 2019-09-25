#!/usr/bin/env bash

# Alex Coleman
# 2018/10/15

echo "Setting Git aliases..."

# Git config options & aliases
# git config --global submodule.recurse true
# git config --global core.editor 'code --wait'
git config --global --replace-all alias.aa 'add -A .'
git config --global --replace-all alias.br 'branch'
git config --global --replace-all alias.bra 'branch -a'
git config --global --replace-all alias.brd 'branch -d'
git config --global --replace-all alias.brm 'branch --merged'
git config --global --replace-all alias.cam 'commit -am'
git config --global --replace-all alias.chmodx '!git update-index --chmod=+x'
git config --global --replace-all alias.cloneall 'clone --recurse-submodules'
git config --global --replace-all alias.cm 'commit -m'
git config --global --replace-all alias.co 'checkout'
git config --global --replace-all alias.cob 'checkout -b'
git config --global --replace-all alias.coo '!git fetch && git checkout'
git config --global --replace-all alias.dev '!git checkout dev && git pull origin dev'
git config --global --replace-all alias.staging '!git checkout staging && pull origin staging'
git config --global --replace-all alias.master '!git checkout master && git pull origin master'
git config --global --replace-all alias.find '!git ls-files | grep -i'
git config --global --replace-all alias.grep 'grep -Ii'
git config --global --replace-all alias.la '!git config -l | grep alias | cut -c 7-'
git config --global --replace-all alias.ls 'log --pretty=format:"%C(yellow)%h %Cred%cr %Cblue(%an)%C(cyan)%d%Creset %s" --decorate'
git config --global --replace-all alias.ll 'log --pretty=format:"%C(yellow)%h %Cred%cr %Cblue(%an)%C(cyan)%d%Creset %s" --decorate --stat'
git config --global --replace-all alias.po 'push origin'
git config --global --replace-all alias.pod 'push origin dev'
git config --global --replace-all alias.pos 'push origin staging'
git config --global --replace-all alias.pom 'push origin master'
git config --global --replace-all alias.poh 'push origin HEAD'
git config --global --replace-all alias.plo 'pull origin'
git config --global --replace-all alias.plod 'pull origin dev'
git config --global --replace-all alias.plos 'pull origin staging'
git config --global --replace-all alias.plom 'pull origin master'
git config --global --replace-all alias.ploh 'pull origin HEAD'
git config --global --replace-all alias.rim 'rebase -i master'
git config --global --replace-all alias.rpo 'remote prune origin'
git config --global --replace-all alias.sur 'submodule update --init --recursive'
git config --global --replace-all alias.st 'status'
git config --global --replace-all alias.tree 'log --pretty=format:"%C(yellow)%h %Cred%cr %Cblue(%an)%C(cyan)%d%Creset %s" --decorate --graph --all'
git config --global --replace-all alias.unstage 'reset --soft HEAD^'
