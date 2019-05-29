---
date: 2013-07-13
tags: [ocr]
title: Optical Character Recognition
ThumbUrl: img/code_icon.png
---

What is <abbr title="Optical Character Recognition">OCR</abbr>? It's short for optimal character recognition. ICR is a form of OCR but meant for reading handwritten characters. OCR is essential in any business process where documents are scanned and extracted for text or metadata in order to classify them.

From five years of experience with OCR engines, the following are the recommendations in order:

- [Tesseract](https://github.com/tesseract-ocr/tesseract) Free and open sourced by Google
- [OpenText RecoStar](http://www.opentext.com/2/global/products/products-opentext-products-for-oems-and-vars/products-opentext-capture-recognition-engine.htm) (Capture Recognition Engine) + Design Studio
- [Abbyy](http://www.abbyy.com/) - They also provide a screen reader for screen-scraping terminals
- [Nuance](http://www.nuance.com/) Omnipage
There are also open source, free OCR engines such as Tesseract, which was released by staff from UNLV  oddly enough.

Surprisingly, there are many modern libraries that do on-the-fly OCRing on mobile phones. Such technology has many benefits for both the consumer and business user.

To see an implementation of the Tesseract OCR engine in `Go`, see my [OCR Engine demo](https://github.com/szahn/OCREngineSoCalCodeCamp2018).