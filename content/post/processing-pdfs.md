---
date: 2013-05-18
tags: [pdf]
title: PDF Document Processing
---

If ImageMagick (http://www.imagemagick.org/script/index.php) is the standard open source solution for image processing, then GhostScript (https://www.ghostscript.com/) is the equivalent for PDF processing.

iText is an open source and commercial PDF library. You can view videos on the iText Summit here: http://itextpdf.com/summit.php. These are great to watch if you work with PDFs.

PDFTron (http://www.pdftron.com/pdf2image/) works well even if the pdf has old fonts that are no longer in production such as Arial Bold MT.

`pdf2image -f tiff -d 200 --mono -m 137861.pdf`

Leadtools has been a long favorite due to performance and features: http://demo.leadtools.com/HTML5/ThumbnailDemo.htm

## Dealing with password protected PDFs

There are 2 forms of PDF security: permissions and a password. In order to full utilize all the features of a PDF (such as ready, modify and extract), you have to ensure that the PDFs permissions are set properly.

SysTools PDF Unlocker.  It will remove the security from the PDF (except the password protection). The application is simple.  Point the app to the secured PDF, then point to a directory to save the unlocked PDF.  Rename the PDF to the original name and drop it back into the batch folder.

To fix the Password Protection on a PDF you can use a PDF toolkit to programmatically remove the Security from the PDFs, but again, not the password protection. The tool that I used was the PDFKit.NET from Tall Components (www.tallcomponents.com). AdultPDF Decryption may also remove passwords.