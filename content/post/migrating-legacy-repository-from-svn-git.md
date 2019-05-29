---
date: 2014-11-06
tags: [svn,git,windows]
title: Migrating a Legacy Repository from SVN to Git on Windows
ThumbUrl: img/code_icon.png
---

There may come a time when you stumble upon an ancient SVN repository nested with multiple projects and need to efficiently collaborate with others on a single project in that repository. Well, we all know Git is better than SVN in many ways. It's faster and the decentralized, distributed nature of Git provides better security and redundancy. We all remember the story of codespaces.com, where a single hacker hacked into their Amazon servers in the cloud and they were forced to shut down. All users who had their single SVN repository on codespaces.com lost it all.

There is a simple tool that migrates SVN to Git quite well. [Atlassian](https://www.atlassian.com/git/tutorials/migrating-overview/) has provided documentation on how to do this with their custom tool, however it's slow and does not work well on Windows. Using the svn2git gem, migrating a 400MB SVN repository is a breeze and only takes a few minutes.

Download the [Ruby installer](http://rubyinstaller.org/downloads/).
Download the svn2git gem: gem install svn2git.
Create a new empty folder for the git repository

```
Run svn2git.bat <svn-project-sub-path> --no-minimize-url
```

Be sure to add a `.gitignore` file then, commit and push to the remote origin.

That's it! Still need to keep your SVN repository in sync for some strange reason? Check out the [SmartGit Client](http://www.syntevo.com/).