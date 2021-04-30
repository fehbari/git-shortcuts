# Collection of useful Git shortcuts to call from Zsh.
# Documentation: https://github.com/fehbari/git-shortcuts
#
# Use `g --help` to learn what you can do.

g() {
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "\nCollection of useful Git shortcuts.\n"
        echo "Available commands:\n"
        echo "gadd | Stage all new and changed files."
        echo "gbase [-s] | Switch to $BASE_BRANCH and optionally sync with remote."
        echo "gbranch [-n -p -d -c] | Switch to or perform actions on your branches."
        echo "gcommit | Stage all changes and commit work with a message."
        echo "gdiff | List all staged and unstaged changes."
        echo "gfetch | Fetch branches and tags, and remove outdated local references."
        echo "gmerge | Merge latest from $BASE_BRANCH into the active branch."
        echo "gpull | git pull but shorter :)"
        echo "gpush [-f] | Push changes from active branch and track remote."
        echo "grebase [-a -c -s] | Rebase current branch onto $BASE_BRANCH."
        echo "gsquash | Use git-squash to squash commits and sync with $BASE_BRANCH."
        echo "gtrack | Set the upstream of branch to origin/branch."
        echo "\nUse -h or --help with any command to see argument details."
    else
        echo "Collection of useful Git shortcuts to call from Zsh."
        echo "Use -h or --help for the list of commands."
    fi
}

gadd() {
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "\ngadd | Stage all new and changed files."
    else
        eval "git add ."
    fi
}

gbase() {
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "\ngbase [-s] | Switch to $BASE_BRANCH and optionally sync with remote."
        echo "\nAvailable options:\n"
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
        echo "\nAvailable options:\n"
        echo "-n --new | Create and switch to a new branch, based on the latest $BASE_BRANCH."
        echo "-n -p --new --parent | Create and switch to a new branch, based on the current branch (parent)."
        echo "-t --track | Check out and track a remote branch locally."
        echo "-c --clean | Cleanup. Deletes all local branches except for $BASE_BRANCH."
        echo "             Dangerous operation, requires confirmation (y/n)"
        echo "\nUsage: gbranch [--options] your/branch-name"
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
        echo "\ngdiff | List all staged and unstaged changes."
    else
        eval "git diff HEAD --name-status && echo \"\n\""
        eval "git diff --stat HEAD"
    fi
}

gfetch() {
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "\ngfetch | Fetch branches and tags, and remove outdated local references (prune)."
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
        echo "\nAvailable options:\n"
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

grebase() {
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "\ngrebase [-a -c -s] | Rebase current branch onto $BASE_BRANCH."
        echo "\nAvailable options:\n"
        echo "-a --abort | Undo rebase with conflicts."
        echo "-c --continue | Continue rebase after fixing conflicts."
        echo "-s --skip | Skip the current patch with conflicts."
    elif [ "$1" = "-a" ] || [ "$1" = "--abort" ]; then
        eval "git rebase --abort"
    elif [ "$1" = "-c" ] || [ "$1" = "--continue" ]; then
        eval "git rebase --continue"
    elif [ "$1" = "-s" ] || [ "$1" = "--skip" ]; then
        eval "git rebase --skip"
    else
        eval "git rebase $BASE_BRANCH"
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
        echo "\ngtrack | Set the upstream of branch to origin/branch."
    else
        branch=$(git symbolic-ref --short HEAD)
        eval "git branch --set-upstream-to origin/$branch"
    fi
}
