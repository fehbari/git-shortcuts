# git-shortcuts [![Platforms](https://img.shields.io/badge/platform-macos%20|%20linux-blue)]() [![Shell](https://img.shields.io/badge/shell-zsh-blue)]()

## What is this?

A collection of useful Git shortcuts to call from your Zsh terminal.

## What does it do?

It facilitates everyday Git tasks by providing a shorter syntax and convenient functions.

## Not for you?

These shortcuts were created to help my workflow. Most of them chain multiple Git commands in a way that saves me time. If it doesn't apply to your workflow, feel free to fork or tweak locally so it's useful to you.

# Installation

Install the [latest release](https://github.com/fehbari/git-shortcuts/releases/latest) by following the instructions in that page.

# Cheatsheet

Type `g --help` to access this list at any time.

Command               | Options       | Description
--------------------- | ------------- | -----------
[`gadd`](#gadd)       |               | Stage all new and changed files.
[`gbase`](#gbase)     | `-s`          | Switch to base branch and optionally sync with remote.
[`gbranch`](#gbranch) | `-n -p -d -c` | Switch to or perform actions on your branches.
[`gcommit`](#gcommit) |               | Stage all changes and commit work with a message.
[`gdiff`](#gdiff)     |               | List all staged and unstaged changes.
[`gfetch`](#gfetch)   |               | Fetch branches and tags, and remove outdated local references.
[`gmerge`](#gmerge)   |               | Merge latest from base branch into the active branch.
[`gpull`](#gpull)     |               | *git pull* but shorter :)
[`gpush`](#gpush)     | `-f`          | Push changes from active branch and track remote.
[`grebase`](#grebase) | `-a -c -s`    | Rebase current branch onto base branch.
[`gsquash`](#gsquash) |               | Use *git-squash* to squash commits and sync with base branch.
[`gtrack`](#gtrack)   |               | Set the upstream of branch to origin/branch.

# Reference

Use `--help` with any command to see its detailed reference, or read it below.

### gadd

Stage all new and changed files.

---

### gbase

Switch to base branch and optionally sync with remote.

Option      | Description
----------- | -----------
`-s --sync` | Sync with latest changes from remote.

---

### gbranch

Switch to or perform actions on your branches.

**Basic use:**

Switch to local *your/branch-name*:

```
gbranch your/branch-name
```

**Use with options:** 

```
gbranch [--options] your/branch-name
```

Option                 | Description
---------------------- | -----------
`-n --new`             | Create and switch to a new branch, based on the latest base branch.
`-n -p --new --parent` | Create and switch to a new branch, based on the current branch (parent).
`-d --delete`          | Delete a local branch.
`-c --clean`           | Cleanup. Delete all local branches except for base branch. </br> **Dangerous operation**, requires confirmation *(y/n)*

---

### gcommit

Stage all changes and commit work with a message.

**Usage:**

```
gcommit "Your commit message"
```

---

### gdiff

List all staged and unstaged changes.

---

### gfetch

Fetch branches and tags, and remove outdated local references (prune).

---

### gmerge

Merge latest from base branch into the active branch.

---

### gpull

*git pull* but shorter :)

---

### gpush

Push changes from active branch and track remote.

Option       | Description
------------ | -----------
`-f --force` | Force push branch. Never do it on a shared branch! </br> **Dangerous operation**, requires confirmation *(y/n)*

---

### grebase

Rebase current branch onto base branch.

Option          | Description
--------------- | -----------
`-a --abort`    | Undo rebase with conflicts.
`-c --continue` | Continue rebase after fixing conflicts.
`-s --skip`     | Skip the current patch with conflicts.

---

### gsquash

Use [git-squash](https://github.com/sheerun/git-squash) to squash commits and sync with base branch.

---

### gtrack

Set the upstream of branch to *origin/branch*.
