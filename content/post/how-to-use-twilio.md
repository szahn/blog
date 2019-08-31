---
date: 2019-01-25
tags: [api, crm, javascript, node]
draft: false
title: How to Use Twilio for SMS
ThumbUrl: img/twilio-mark-red.png
---

With <abbr title="customer relation management">CRM</abbr> software being high in demand, there is always a need to keep in touch with the end user. Using [Twilio](https://www.twilio.com/), you can easily register new virtual phone numbers to send and recieve text messages and voice calls.

# Phone Number Registration

First, obtain an account sid and auth token from the [console](https://www.twilio.com/console). Imagine giving each user their own phone number. Phone number registration is simple and only costs $1 a month. To register a phone number, search for an available one by area code.

```javascript
const client = require('twilio');

async function purchasePhoneNumber({areaCode}) {

    console.log(`Purchasing (${areaCode}) phone number...`)

    const phoneNumbers = await client.availablePhoneNumbers('US')
        .local
        .list({areaCode: areaCode});

    if (!phoneNumbers.length){
        throw new Error(`No phone numbers available for area code ${areaCode}. Try another area code.`);
    }

    const {phoneNumber} = phoneNumbers[0];

    const {dateCreated, friendlyName, phoneNumber : purchasedNumber, sid} = await client.incomingPhoneNumbers.create({phoneNumber: phoneNumber})

    return {
        created: dateCreated,
        name: friendlyName,
        purchasedNumber: purchasedNumber,
        sid: sid
    };

}
```

# Text Messaging

Once a phone number is obtained, it can be registered with an existing VoIP system with [SIP registration](https://www.twilio.com/docs/voice/api/sip-registration). To send a text message:

```javascript
async function sendMessage({to, from, message}){
    console.log(`Sending message '${message}' from ${from} to ${to}.`)
    const {errorCode, errorMessage, status} = await client.messages.create({
        body: message,
        to: to,
        from: from
    });

    return {
        errorCode, 
        errorMessage, 
        status
    };
}

```

Get the [full source code at Github](https://github.com/szahn/TwilioIntegration).