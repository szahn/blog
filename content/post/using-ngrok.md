---
date: 2016-07-21
draft: false
title: Using NGrok to Expose Localhost
ThumbUrl: img/code_icon.png
---

If you are developing on localhost, there may be a time you'll want to expose your local server to the public internet for testing. For example, if you wanted to test a [Zapier](https://zapier.com/) hook. [Ngrok](https://ngrok.com/) creates a tunnel from your localhost to the public internet to do this.

To do this, simply run:
```bash
ngrok http [port]
```