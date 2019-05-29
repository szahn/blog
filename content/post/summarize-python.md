---
date: 2016-01-15
tags: [python]
title: Summarize Web Posts with React and Python
ThumbUrl: img/code_icon.png
---

Before the end of the year, I vowed to read all 100+ articles that were in my backlog. I had a lot of catching up to do, but if I spent only 15 minutes reading each article, it would still take all day. What if I run my archive through a summarizer so I could quickly see which articles were more important to read than others? This type of technology is not new and hard to find to free online. Both Google and Yahoo have recently acquired startups that summarize online content, so finding a free solution is difficult. There are sites out there that will summarize content for you, and some have APIs, but charge for them. I wanted a free, quick way to summarize content online.

After searching for any open source repositories, I eventually found one that might work which was adapted from <a href="http://ieeexplore.ieee.org/xpl/articleDetails.jsp?arnumber=5392672">The Automatic Creation of Literature Abstracts"</a> by H.P. Luhn. A majority of autosummarizers on GitHub are actually written in Python, so I had to familiarize myself with the language. Python is a great language because of its data structures and poetic-like syntax.

It took about 2 minutes to summarize 98 post which is about 1.3 seconds a post. Not the fastest or more accurate algorithm.

Once I had json data of the summaries, I could focus on building a quick user interface. I chose ReactJS because of it’s fast, virtual dom rendering. I also enjoy the declarative nature of JSX in React. It feels like writing XAML where the markup you write is what will be rendered.

Check out the server and client code at <a href="https://github.com/szahn/ArticleSummary">GitHub</a>.