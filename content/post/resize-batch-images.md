---
date: 2010-07-14
tags: [pdf]
title: How to Resize Images
ThumbUrl: img/code_icon.png
---

Despite <abbr title="software as a service">SaaS</abbr> solutions like [Cloudinary](https://cloudinary.com/) that can manipulate images for you in the cloud. You may still want to take advantage of free and open source libraries on your own servers. Using [ImageMagick](https://imagemagick.org) you can easily batch scale images.

```bash
mogrify -resize x250 -quality 80 -path ../thumbs *.jpg
```