Moving commits around
=====================

Sometimes you accidentally commit changes to a branch that you didn't want to.
Here's how to get them onto another branch.

    $ git checkout <branch-you-committed-to>

Get the hashes of the commits you made - do the earliest one first

    $ git log
    $ git checkout <branch-you-want-the-commits>

For each commit you took note of - earliest first - do this:

    $ git cherry-pick <commit hash here>

Now let's remove the commits from the previous branch. When you do a hard 
reset you'll lose *all* changes that you've made since the hash you choose - 
make sure you really want to roll back to that commit. Don't roll back to 
before a commit that's already been pushed. You've seen in Ghost Busters where 
they cross the streams? Yeah, like that.

    $ git checkout <branch-you-committed-to>

Get the hash of the commit that you want to roll back to

    $ git log
    $ git reset --hard <commit hash here>

The commits have now been copied to the branch you wanted them on and removed 
from the branch you accidentally committed to.