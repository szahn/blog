---
date: 2014-07-18
tags: [api]
title: Consuming the Yelp Api
---

Recently, I wanted to develop a mobile app that displayed a walking city tour of your bookmarked places on Yelp so that if you are in a new city and want waypoints generated for the nearest favorite locations, you can quickly get them on the fly. This was harder than I thought because of the limitations of the Yelp API.

I wanted to produce a final solution all Node JS and Angular JS. This meant learning about Node JS, Angular JS and how to wire the two together. The implementation would utilize Google Maps and Geocoding services. I ran into several limitations with their free service, mostly OVER_QUERY_LIMIT errors which would require me to rewrite my code to handle these errors, wait a few seconds and then retry.

The NodeJS server returns some JSON with bookmarked locations which were queried directly from a Yelp URL using [request](https://www.npmjs.org/package/request) and then parsed with [cherrio](https://github.com/cheeriojs/cheerio). The reason I couldn't use their API is that they did not include retrieving bookmarks!

```json
[{title: "Pyramid Alehouse",
streetAddress: "1201 1st Ave S Seattle, WA 98134"
},{title: "Elysian Fields",
streetAddress: "542 1st Ave S Seattle, WA 98104"
},{title: "The Brooklyn Seafood, Steak & Oyster House",
streetAddress: "1212 2nd Ave Seattle, WA 98101"}]
```

The results were a list of waypoints starting from the user's location.

![Image](/img/2014-07-18_14-25-48-e1405718882601.png)

Unfortunately, after deploying the site to OpenShift, I encountered rejects from Yelp. Even after trying several popular proxies, Yelp would not let me call their site.

Therefore, I sent an plea to Yelp, suggesting they open their API a bit more:

"I am a avid user of Yelp and an active reviewer. I am also a developer and would like to write a mobile app that integrated with Yelp. However, I've found the Yelp API to be limiting. For example, I cannot query a list of my bookmarks for a particular city. I plan on displaying these bookmarks on a Google map with waypoints indicating the ideal path to take from my starting point. This way, I can create a walking tour of my favorite Yelp bookmarks within walking distance from me. This appears to be an important feature which Yelp currently lacks. Upon discovery, I've found that I cannot even query my open public bookmarks from my web server as I get a 403: Forbidden error. Is there a legal reason for rejecting my server request? Please add the ability to query bookmarks from the API or provide a way I can get a list of bookmarks from a url such as "http://www.yelp.com/user_details_bookmarks?cc=US&city=Seattle&state=WA&userid=XXX&neighborhood=Downtown" from my web server without getting blocked."

If you're curious, you can find the [code here](https://github.com/szahn/YelpItinerary). It's not finished yet and there is still a ton of refactoring to do.
