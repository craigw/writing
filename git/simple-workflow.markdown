A Suggested Git Workflow
========================

We have two main integration branches, development and master. These are
places that all our code comes together to be shared with the rest of the
team, and where we push our changes to when we're finished working on
something. Mostly we can just ignore master since all of our work will happen
on development. We merge into master whenever the features on development are
complete and pass QA.

A general rule of thumb when working with Git is never to make any
changes on integration branches - if nothing else it can cause annoying
commit messages:

    commit 8dc86b8a47b3448bc97c833ec227b507eefcb440
    Merge: 3245a49 58141b4
    Author: Craig R Webster <craig@barkingiguana.com>
    Date:   Tue Jul 6 16:09:40 2010 +0100

      Merge branch 'development' of github.com:craigw/foo into development

Commits should be meaningful pieces of work. This clearly isn't.

If you're working with lots of local branches it can also stop you easily
rebasing onto the latest code because pulling into the integration branch
can cause conflicts. Rebasing is amazing, you want to be able to do this
easily and often.

So, if you shouldn't work on integration branches then where do you work?
Git branches are incredibly cheap so create a topic branch for your work.
Work on that branch, rebasing frequently, and when you're done you should
merge the topic branch into the integration branch, squashing your topic
branch into one commit and then push to the remote. Sounds pretty
confusing but it's actually pretty simple. Here's what it looks like when
I'm working at the terminal.

My Workflow
-----------

First pull the latest code into the integration branch.

    $ git checkout development
    $ git pull

Make sure the tests pass - they always should at this stage but it's
important to check in case the build is broken (if it is, fix it).

    $ rake

Now it's time for work. Pick something from the task board and create a
topic branch for it. In this case I'm working on the feature titled "Make
default deposit ten pounds". Choose a descriptive name for your branch.

    $ git checkout -b make-default-deposit-ten-pounds

Here you should do the work. Every time you make a little progress you
should commit. It doesn't matter here if the tests pass or not, although
obviously we're all doing test driven development (right?) so they
usually will.

As you work you'll start to diverge from the integration branch. You'll
add more code to your local branch, and everyone else will be pushing
code to the development branch on origin. The longer this happens the
harder it will be to bring the branches back together. To avoid diverging
too much you should rebase onto the integration branch fairly frequently.
Rebasing takes the changes on one branch and applies them *before* the
changes you've made to another branch.


What Rebasing Does
------------------

Erm. Sorry for the ASCII art. Geek chic, yes?

Say we have a tree that looks like this:

                Someone pushes their changes to origin here
                      v
    ----[aaaaaaaa]----[bbbbbbbb]----[cccccccc]---- (development)
                    \-[dddddddd]------------------ (local-branch)

Rebasing local-branch onto development does this:

    ----[aaaaaaaa]----[bbbbbbbb]----[cccccccc]---- (development)
                                                \-[dddddddd]----

Merging development into local-branch inserts your changes before the
others which is rewriting history:

    ----[aaaaaaaa]------------------[bbbbbbbb]----[cccccccc]----
                    \-[dddddddd]----[bbbbbbbb]----[cccccccc]----

Don't rewrite history or Git will make you cry when you try to share your
changes.


Anyway, back to the workflow
----------------------------

That's what rebasing does, here's how to do it:

Make sure you've got the latest changes locally:

    $ git checkout development
    $ git pull origin development

Rebase your local branch onto the latest changes:

    $ git checkout make-default-deposit-ten-pounds
    $ git rebase development

Your code now incorporates the latest changes from development. Easy, eh?
You can now carry on working.

Eventually you'll be done working on your topic branch, you'll have just
rebased onto the latest changes, and your tests will all pass. They do
all pass, right? If not, fix that now, rebase again, and run the test
again.

Now we want to get the changes you've made to the topic branch pushed to
origin so everyone else can get at them. We'll squash all your changes
into one massive commit so we have one point in the development branch
that contains all the changes related to your topic.

    $ git checkout development
    $ git merge --squash make-default-deposit-ten-pounds
    $ git commit -m "Make the default deposit £10. Completes #3754771."
    $ git push origin development