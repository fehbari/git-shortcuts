# Collection of useful Git shortcuts to call from Zsh.
# Author: https://github.com/fehbari
#
# These are opinionated and catered to my workflow. Most of the shorcuts chain multiple
# Git commands in a way I find useful. If it doesn't apply to your workflow, feel free 
# to fork or tweak locally so it's useful to how you work.
#
# Prerequisites:
# direnv - https://github.com/direnv/direnv (requires a BASE_BRANCH variable set)
# git-squash - https://github.com/sheerun/git-squash (optional - only for gsquash command)
#
# Installation:
# Copy this file to your home folder as ~/.git-shortcuts.zsh, then add `source ~/.git-shortcuts.zsh` 
# in your ~/.zshrc file. With direnv installed, add the contents of the sample to your .envrc files.
# When you're all set, call `g --help` to learn what you can do.
#
# Uninstall:
# Remove the entry from your ~/.zshrc file and delete ~/.git-shortcuts.zsh from home folder.

g() {
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "\nCollection of useful Git shortcuts.\n"
        echo "Available commands:\n"
        echo "gadd | Stages all new and changed files."
        echo "gbase [-s] | Switch to $BASE_BRANCH and optionally sync with latest."
        echo "gbranch [-n -p -d -c] | Switch to or perform actions on your branches."
        echo "gcommit | Stage all changes and commit work with a message."
        echo "gdiff | Lists all staged and unstaged changes."
        echo "gfetch | Fetch branches and tags, and removes outdated local references."
        echo "gmerge | Merge latest from $BASE_BRANCH into the active branch."
        echo "gpull | git pull but shorter :)"
        echo "gpush [-f] | Push changes from active branch and track remote."
        echo "gsquash | Use git-squash to squash commits and sync with $BASE_BRANCH."
        echo "gtrack | Sets the upstream of branch to origin/branch."
        echo "\nUse -h or --help with any command to see argument details."
    else
        echo "Collection of useful Git shortcuts to call from Zsh."
        echo "Use -h or --help for the list of commands."
    fi
}

gadd() {
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "\ngadd | Stages all new and changed files."
    else
        eval "git add ."
    fi
}

gbase() {
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "\ngbase [-s] | Switch to $BASE_BRANCH and optionally sync with latest."
        echo "\nAvailable arguments:\n"
        echo "-s --sync | Sync with latest changes from origin/$BASE_BRANCH."
    elif [ "$1" = "-s" ] || [ "$1" = "--sync" ]; then
        eval "git checkout $BASE_BRANCH && git pull"
    else
        eval "git checkout $BASE_BRANCH"
    fi
}

gbranch() {
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "\ngbranch [-n -p -d -c] | Switch to or perform actions on your branches."
        echo "\nBasic use: gbranch your/branch-name | Switch to local your/branch-name."
        echo "\nAvailable arguments:\n"
        echo "-n --new | Create and switch to a new branch, based on the latest $BASE_BRANCH."
        echo "-n -p --new --parent | Create and switch to a new branch, based on the current branch (parent)."
        echo "-t --track | Check out and track a remote branch locally."
        echo "-c --clean | Cleanup. Deletes all local branches except for $BASE_BRANCH."
        echo "             Dangerous operation, requires confirmation (y/n)"
        echo "\nUsage: gbranch [--args] your/branch-name"
    elif [ "$1" = "-n" ] || [ "$1" = "--new" ]; then
        if [ "$2" = "-p" ] || [ "$2" = "--parent" ]; then
            eval "git checkout -b $3"
        else
            eval "gbase -s && git checkout -b $2"
        fi
    elif [ "$1" = "-t" ] || [ "$1" = "--track" ]; then
        eval "git checkout -t origin/$2"
    elif [ "$1" = "-d" ] || [ "$1" = "--delete" ]; then
        eval "git branch -D $2"
    elif [ "$1" = "-c" ] || [ "$1" = "--clean" ]; then
        echo "This will delete all local branches except $BASE_BRANCH. \nProceed? (y/n)"; read input;
        if [ $input = "y" ]; then
            eval "git branch | grep -v "$BASE_BRANCH" | xargs git branch -D"
        else
            echo "Mission aborted!";
        fi
    else
        eval "git checkout $1"
    fi
}

gcommit() {
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "\ngcommit | Stage all changes and commit work with a message."
        echo "\nUsage: gcommit \"Your commit message\""
    else
        eval "git add . && git commit -am \"$1\""
    fi
}

gdiff() {
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "\ngdiff | Lists all staged and unstaged changes."
    else
        eval "git diff HEAD --name-status && echo \"\n\""
        eval "git diff --stat HEAD"
    fi
}

gfetch() {
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "\ngfetch | Fetch branches and tags, and removes outdated local references."
    else
        eval "git fetch --prune"
    fi
}

gmerge() {
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "\ngmerge | Merge latest from $BASE_BRANCH into the active branch."
    else
        eval "git merge origin/$BASE_BRANCH"
    fi
}

gpull() {
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "\ngpull | git pull but shorter :)"
    else
        eval "git pull"
    fi
}

gpush() {
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "\ngpush [-f] | Push changes from active branch and track remote."
        echo "\nAvailable arguments:\n"
        echo "-f --force | Force push branch. Never do it on a shared branch!"
        echo "             Dangerous operation, requires confirmation (y/n)"
    elif [ "$1" = "-f" ] || [ "$1" = "--force" ]; then
        echo "Reminder: don't do this on shared branches. \nProceed? (y/n)"; read input;
        if [ $input = "y" ]; then
            eval "git push --force origin HEAD && gtrack"
        else
            echo "Mission aborted!";
        fi
    else
        eval "git push origin HEAD && gtrack"
    fi   
}

gsquash() {
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "\ngsquash | Use git-squash to squash commits and sync with $BASE_BRANCH."
    else
        eval "git merge origin/$BASE_BRANCH && git squash origin/$BASE_BRANCH"
    fi
}

gtrack() {
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "\ngtrack | Sets the upstream of branch to origin/branch."
    else
        branch=$(git symbolic-ref --short HEAD)
        eval "git branch --set-upstream-to origin/$branch"
    fi
}