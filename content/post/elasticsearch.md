---
date: 2018-09-20
tags: [elk,docker,elasticsearch]
draft: false
title: Centralized Logging with Elasticsearch
ThumbUrl: img/logo-elastic.png
---

# How to Centralize Logging with Elasticsearch, Logstash, Kibana

## What is ELK?

An ELK stack is usually made up of system log listener middleware such as [Logstash](https://www.elastic.co/products/logstash). It runs in the background as a daemon or process that collects stream of information from flat files. [Kibana](https://www.elastic.co/products/kibana) is the UI for search through logs interactively. Sure, you can use `grep` or `curl` the [REST API](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-search.html) to search through logs, but having a user interface makes it much easier to visualize events and key metrics.

## Why ELK?

Having a single point of access to applications and system logs is essential to root cause analysis and troubleshooting. The ELK stack makes it possible to aggregate and search through logs. 

There used to be a time when, if you had one service running on Windows that requried doing a full text search on 30 days worth of logs, you'd just open [FileSeek](https://www.fileseek.ca/) and you're good to go. This approach, does not scale for gigabytes of daily logs.

There are plenty of hosted logging solutions like [AWS CloudWatch](https://aws.amazon.com/cloudwatch/) [Sentry](https://sentry.io), [Honeycomb](https://www.honeycomb.io/), [Stackdriver](https://cloud.google.com/stackdriver/). Depending on the volume of logs, you may want to host your own ELK cluster as services like hosted logging may be too costly to retain all log levels over time.

The ELK pipeline lets you choose where logs come from, how they are formatted and where they go.

## Native Centralized Logging

Although it's recommended to use Kubernetes to run Elasticsearch in Docker containers, if you are on an on-premise or local environment where container technology isn't available, you can also run the full ELK stack natively.

### Install Elasticsearch Service

[Download Elasticsearch](https://www.elastic.co/downloads/elasticsearch) 

You can use a package manager or download the binary manually

```bash
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.2.0-amd64.deb
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.2.0-amd64.deb.sha512
shasum -a 512 -c elasticsearch-7.2.0-amd64.deb.sha512 
sudo dpkg -i elasticsearch-7.2.0-amd64.deb
```

If using systemd, to start the service, run:

```bash
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service
```

The default Logtash port is 9200. Confirm logstash is running with `curl http://localhost:9200`

#### Configuring Elasticsearch

Create a new index: `curl -XPUT 'http://localhost:9200/test_index?&pretty`

Index a document:
```bash
curl -XPOST 'http://localhost:9200/test_index/_doc/1?pretty' -d '{"message":"hello world"}' -H 'Content-Type: application/json'
```

Query the index:

```bash
curl -H'Content-Type: application/json' -XPOST "http://localhost:9200/test_index/_search?&pretty" -d'{"query": {"match": {"message": "hello world"}}}'
```

### Install Kibana

[Install Kibana](https://www.elastic.co/guide/en/kibana/current/deb.html#install-deb) using a package manager.

In Debian, you could install it manually with

```bash
wget https://artifacts.elastic.co/downloads/kibana/kibana-7.2.0-amd64.deb
shasum -a 512 kibana-7.2.0-amd64.deb 
sudo dpkg -i kibana-7.2.0-amd64.deb
```

Start the service:

```bash
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service
sudo -i service kibana start
```

Then, visit the homepage: `xdg-open http://localhost:5601`

Be sure to create a default index pattern

### Install Logstash Binary

On Debian, ensure Java 8 or 11 is installed with `java -version`.  Install Open Java with `sudo apt-get install openjdk-9-jdk-headless`

[Install Logstash](https://www.elastic.co/downloads/logstash) with `sudo apt-get update && sudo apt-get install logstash` or download the binary directly with `curl -O https://artifacts.elastic.co/downloads/logstash/logstash-7.2.0.zip && unzip logstash-7.2.0.zip` 

Configure the `logstash.conf` for your system

The example configuration below will feed all system logs to logstash which isn't something you should do in production

```
input { 
    file { 
        id => "system_logs" 
        path => "/var/log/*.log"
    } 
}

output {
  elasticsearch { hosts => ["localhost:9200"] }
  stdout { codec => rubydebug }
}```

Run Logstash:

```bash
bin/logstash -f ~/logstash.conf
```


## Containerized ELK 

You can run Elasticsearch on Docker. Due to [Docker networking complexities](https://www.elastic.co/blog/docker-networking), it's recommended to use the [Kubernetes operator](https://www.elastic.co/elasticsearch-kubernetes).

## Hosted ELK

Amazon provides a [hosted Elasticsearch service](https://aws.amazon.com/elasticsearch-service/) which is recommended if you are ok with paying for an Elasticsearch EC2 instance.


# TL;DR

Hosting your own Elasticsearch service is simple. Use an on-premise ELK cluster if you have high volume of data with a long retention period, otherwise, use a managed centralized logging provider.