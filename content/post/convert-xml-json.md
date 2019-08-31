---
date: 2018-09-15
tags: [etl, data, json, xml, javascript, node]
draft: false
title: Converting Xml To Json in Node
ThumbUrl: img/code_icon.png
---

There are many big data solutions catering to data transformation. A common business problem when migrating data from one cloud host to another is to not only load data from one type to another, but also discover and alter the schema. Json is overtaking Xml as the popular HTTP payload format for REST services. There are big data <abbr title="Extract Transform Load">ETL</abbr> tools like [AWS Glue](https://aws.amazon.com/glue/) that can scale XML and JSON transformation to gigabytes of data. <b>Interchanging XML and JSON in complex ETL processes may not require big data tools like map reduce and spark</b>. If you only have a few 100 MB of data in your pipeline at a time, you can easily us [AWS Lambda serverless functions](https://aws.amazon.com/lambda/) to process data from blob storage like AWS S3.

There are a plenty of poor ways to stream xml into json. For example, many NPM libraries will load [XML into a DOM](https://www.npmjs.com/package/jsdom) structure to be queried like HTML. The problem with this approach is, for large XMLs, it loads the entire object into the heap. A better alternative would be to a sax-like event stream to parse xml directly into javascript objects.

I've implemented a fast, memory efficient [event based](https://www.npmjs.com/package/saxes) xml stream parser that can generate json equivalent in pure node. Take a look at the [code here](https://github.com/szahn/xml-2-json).