# Git Introduction

## What is Git?

In the simplest terms, git is software that allows you to version control projects, usually consisting of software. What this means in practice is git allows you to track changes to file(s) at user defined points creating a history of the changes to that file(s). What is powerful about this is this allows you to revert changes to code fairly easily, as well as allow for multiple developers (or collaborators) to work on a set of code from the same change point without worrying about overwriting what the other has done (more on this later). To illustrate how this all works, the below will walk you through the process and useful commands of git.

## Creating a Local Git Repository

Say you want to create a local git repository on your computer in the directory ``my_project``, you can initialize the repository as follows:

	cd my_project
	git init

And BOOM! you have your first repository. 

## Adding Files to your Local Repository

Of course, this is not super useful until you start adding code to it. So, say now that you know you want to start your project with a spectra reduction script called ``spectra_reduction.py``. First, you should create the file in your directory and then you can add it to your repository by:

	git add spectra_reduction.py

At this point, the file is only staged to be added to your local repository. At this point, you can add multiple files under the same commit (shown in a sec). Once you are done staging your files, you then commit them to the local repository:

	git commit -m "Add initial script for reducing spectra"

Now your file in its current status has been added to your local repository.

## Recording Changes to Files in your Local Repository

Now, lets say that you added a new function to find radial velocities from a spectra to your script, in order to record this change you need to make a new commit. First, after adding the new function you can run:

	git status

which will show you all files in the repository that have untracked changes along with untracked (i.e.) new files that have not been added to the local repository. In this example, running the command would produce:

	On branch main
	Your branch is up to date with 'origin/main'.

	Changes not staged for commit:
	  (use "git add <file>..." to update what will be committed)
	  (use "git checkout -- <file>..." to discard changes in working directory)

		modified:   spectra_reduction.py

Again, to stage and add the file you would run the following:

	git add spectra_reduction.py
	git commit -m "Add RV fitting function"

## Reseting vs. Checking Out vs. Reverting

There are multiple ways to undo things you have done with git, though all of them have different consequences. For this current example, lets say that we make some changes to the RV fitting function:

	git add spectra_reduction.py
	git commit -m "Change algorithm for RV fitting function"

but we no longer like these changes. There are a few ways we can deal with undoing these changes, which are summarized below.

### Reseting

Reseting in git will actually move the head (i.e. where you are in the commit history) backwards to a certain point. So, say for example we wanted to go backwards one commit and redo adding that function to our file, we could run the following:

	git reset HEAD-1

Now, you have essentially removed the commit of adding the RV fitting function from the history like it never existed. Visually, this looks like the following:

<p align="center">
    <img src='original_branch_back.png' alt='reset' style="width:50%"/>
    <br>
    <b>Before Reset</b>
</p>

<p align="center">
    <img src='after_reset.png' alt='reset' style="width:50%"/>
    <br>
    <b>After Reset</b>
</p>

This can be good/bad depending on the application. One note from most online resources is that this type of action should NEVER be done with a public repository as it removes all of the commits ahead of the new head. There will be better options for public repositories discussed below.

### Checking Out

Checking out is similar in some ways to reset, in that it moves the head to a previous commit. Unlike reset though, it does not remove any of the commits after this, it essentially is just good to allow you to checkout what your project looked like at a certain branch. To checkout the previous commit, you would run:

	git checkout HEAD-1

Visually, this looks like the following:

<p align="center">
    <img src='original_branch_back.png' alt='reset' style="width:50%"/>
    <br>
    <b>Before Checkout</b>
</p>

<p align="center">
    <img src='after_checkout.png' alt='reset' style="width:50%"/>
    <br>
    <b>After Checkout</b>
</p>

As a result, this means you cannot really make any commits after this point without having a "detached head". So, it is usually best to pair this with first creating a new branch for your local repository (discussed later).

### Reverting

Unlike the above two methods, reverting does not move the head backwards, but instead undoes a commit by creating a new commit. So, essentially it reverts your project to the previous commit and tacks this change on as a new commit in the project history. To revert to the previous commit, you would run:

	git revert HEAD-1

Visually, this looks like the following:

<p align="center">
    <img src='original_branch_back.png' alt='reset' style="width:50%"/>
    <br>
    <b>Before Revert</b>
</p>

<p align="center">
    <img src='after_revert.png' alt='reset' style="width:50%"/>
    <br>
    <b>After Revert</b>
</p>

What is beneficial about this is you CAN perform this action on a public repository as it preserves the previous commit history.

## Git Branches

In the above section, we showed how it can be a little bit of a pain to undo/edit work in git in your initial local repository. This especially true if you and a collaborator are both trying to work on some code. A good option for both of these instances then is to simply create a new branch! If we want to create a new branch called ``test``, this is very easy to do:

	git branch test

This will create a new branch in the same state as main when the branch is created. Now, as in the previous example, you can tweak your RV fitting function, and commit this change to the new branch:

	git add spectra_reduction.py
	git commit -m "Change algorithm for RV fitting function"

Visually, this looks like the following:

<p align="center">
    <img src='original_branch_2.png' alt='reset' style="width:50%"/>
    <br>
    <b>Before Branch</b>
</p>

<p align="center">
    <img src='after_branch.png' alt='reset' style="width:50%"/>
    <br>
    <b>After Branch and Commit</b>
</p>

Now, you can continue working on this branch worry free about changes to the main branch, as you can always just switch back to main and ignore this test by running:

	git checkout main

If you do end up liking the work you have done in this test branch then, then you can...

## Merging

Say that you like all of the changes you have made in a new branch, you can then merge these changes back to the main branch. Assuming you are currently on the test branch, you can then merge all commits you have made in ``test`` to ``main`` by:

	git checkout main
	git merge test

This will create a new commit at the head of merge that is a special kind of commit that captures all commits from ``test`` into one unified history. 

Visually, this looks like the following:

<p align="center">
    <img src='after_branch.png'' alt='reset' style="width:50%"/>
    <br>
    <b>Before Merge</b>
</p>

<p align="center">
    <img src='after_merge.png' alt='reset' style="width:50%"/>
    <br>
    <b>After Merge</b>
</p>

Note that if you (or a collaborator) have also made changes to ``main`` while making changes ``test``, git will try its best to merge the branches, except when each branch changed the same part of a file. When trying to merge, git will tell you if there are conflicts and you can display the conflicts by running ``git status``. You can then display the portion of the file that provides the conflict by running ``cat spectra_reduction.py``. Then, you have to edit the line(s) in question in an attempt to resolve the conflict. This isn't always straightforward and will vary from case-to-case, but once the conflict is resolved you should be able to merge the branches. If no conflicts remain, it is usually best practice to then delete the merged branch:

	git branch -d test