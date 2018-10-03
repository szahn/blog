---
date: 2018-10-01
tags: [linux,shell,zip,unzip]
title: How to unzip files in Linux shell
slug: how-unzip-files-in-directory-linux-shell
---

To unzip multiple files in a directory, run the following:

`for f in *.zip; do unzip $f -d ${f::-4}; done`