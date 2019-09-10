---
date: 2019-08-15
tags: [html,pyhon,node]
draft: false
title: How to Scrape the Web
ThumbUrl: img/crawler.png
---

From scraping Amazon product reviews, to individual product SKUs and more, automatic web crawling is still a very common business need today. The ability to utilize a cluster of workers to automatically turn html into meaningful data is a very real business proposition. There are many ways to scale automatic web crawling. With the advent of Kubernetes and Docker Swarm, running a replica of 100x containers is very easy to do. However, it's very easy to get blacklisted if not properly throttling those workers.

## Web Scraping Pitfalls

There are many pitfalls to automatic web scraping, such as captchas and device fingerprinting. Once the server recognizes the client by IP or unique device code, it can easily block additional requests. Yes, it's quite possible for each client to have a [unique fingerprint](https://fingerprintjs.com/) that's difficult to spoof.

Solutions to common pitfals may involve Ipv4 address pool diversification, decoupling crawling with Pub/Sub message queues and state machines to properly handing batching, failure and retries. In AWS, one can utilize SQS and Step Functions.

## Scraping HTML with Python

To scrape data from websites in Python, the [BeautifulSoup](https://www.crummy.com/software/BeautifulSoup/) library in combination with [SoupSieve](https://facelessuser.github.io/soupsieve/) for css selector queries is recommended.


Extracting data from html is quite easy. For example, to print low tides per city to the console, table body cells can be identified per row by CSS class selectors. See the [full source code here](https://github.com/szahn/LowTideScraper).

```python
  soup = BeautifulSoup(html, 'html.parser')
  tr = sv.select(".tide-table > tr",  soup)

  curr_date = ""
  timeofday = ""

  for el in tr:
    dateInst = sv.select_one(".date", el)
    if dateInst != None:
      curr_date = dateInst.text.strip()

    tide_time = ""
    tide_time_inst = sv.select_one(".time", el)
    if tide_time_inst != None:
      tide_time = tide_time_inst.text.strip()
    
    timezone = ""
    timezone_inst = sv.select_one(".time-zone", el)
    if tide_time_inst != None:
      timezone = timezone_inst.text.strip()
    
    level = ""
    level_inst = sv.select_one(".level", el)
    if level_inst != None:
      level = level_inst.text.strip()
    

    tide_phase = ""
    tide_phase_inst = sv.select_one(".tide:last-child", el)
    if tide_phase_inst != None:
      tide_phase = tide_phase_inst.text.strip()
    else:
      timeofday_inst = sv.select_one("td:last-child", el)
      if timeofday_inst != None:
        timeofday_val = timeofday_inst.text.strip()
        if timeofday_val == "Sunrise":
          timeofday = timeofday_val
        elif timeofday_val == "Sunset":
          timeofday = timeofday_val
        else:
          timeofday = ""

    if tide_phase == "Low Tide" and (timeofday == "Sunrise" or timeofday == "Sunset"):
      print('{0} {1} {2} {3} {4}'.format(city, curr_date, tide_time, timezone, level))
```

## Scraping with Headless Chrome

Headless Chrome, or [Puppeteer](https://pptr.dev/) is also a recommended approach to scraping web sites. You get the full power and overhead of a Chrome Browser binary with the ability to `eval` Javascript. Since you can execute Javascript, you can easily simulate user behavior such as mouse movement, page scrolling, and form data. So, it's pretty easy to script a login sequence to access private data.

For example, to script logging into LinkedIn, you may code the following:

```js
const puppeteer = require('puppeteer');

async function init({isHeadless}) {
    const browser = await puppeteer.launch({
        headless: isHeadless,
        args:['--no-sandbox'] /*See https://github.com/karma-runner/karma-chrome-launcher/issues/158 */
    });

    return await browser.newPage();
}

const login = (opts => async page =>  {
    await page.goto('https://www.linkedin.com/login');

    await page.type('#username', opts.username);
    await page.type('#password', opts.password);
    await page.click('.login__form button');
    await page.waitForNavigation();

    return page;
});

(async function index() {
    try {

        init({isHeadless: false})
        .then(login({
            username: process.argv[2] || process.env.USERNAME, 
            password: process.argv[3] || process.env.PASSWORD}
        ))
        .catch(err => {
            console.error(err);
        })
        .finally(() => {
            console.log("Finished");
        });

    }
    catch (error){
        console.error(error);
    }
})()
```

```bash
node index.js username password
```

## Scraping Web Feeds with AWS

In addition to HTML, RSS feeds or JSON REST API endpoints are also a common resource to scrape. For example, if you want to migrate a newsletter feed from one service provider to another, you can scrape the RSS feed. To do this gracefully without exceeding the SLA, you can utilize cloud managed queues and blob storage.

![Image](/img/AWSCrawler.png)