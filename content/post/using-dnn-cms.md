---
date: 2014-04-17
tags: [cms,dnn]
title: Using DotNetNuke (DNN) CMS
---

DotNetNuke (https://www.dnnsoftware.com/) is a CMS in which I do a lot of web development in. For anyone that wants to get into DNN module development, below is an simple action plan to help get their feet wet.

Review UX Design Guidelines (http://uxguide.dotnetnuke.com/CSSFoundation.aspx). Remember that each version of DNN varies in its standards and guidelines. Since comprehensive documentation is hard to find for each version, do your best to support at least one major version. Version 6 is the best version to build your module against.

Read up on module development basics (http://www.chrishammond.com/blog/itemid/2616/using-the-new-module-development-templates-for-dot.aspx).

Download the tutorial on Module Programming 101 from DotNetNuclear.com. You can review the video tutorials as well.

Know who you are developing your modules for. Most tutorials and examples on the web are not enterprise friendly. You have to adopt a whole new development philosophy to do real business heavy enterprise module development in DNN. Mitchel Sellers blogs about Enterprise DNN Development (https://mitchelsellers.com/).

Check out XMod (https://www.dnndev.com/) is a powerful DNN form builder.

## Using DotNetNuke (DNN) on a Load Balanced Web Farm


DNN has been known to have cache issues, especially when used on a load balancer. Since the DNN community edition suffers from a lack of web farm support, caching always behaves unusual whenever a deployment is made. To avoid having to pay royalties and support fees to DotNetNuke for the enterprise edition, some companies opt for a work around the common cache problem. A quick and dirty way to solve this problem is to clear the cache and recycle the app pool.

To clear the DNN cache, one can go to Host > Schedule. For "Purge Cache" and "Purge Module Cache", click the edit icon, then enable the schedule and run it. A hard refresh on the browser (usually CTRL F5) is also recommended.

When making changes to DNN on a web farm, it's best to recycle the app pool. The command below will recycle the app pool

```
%systemroot%\system32\inetsrv\AppCmd.exe recycle APPPOOL MyAppPoolId
```

Using AppCmd, you can get a list of app pools by executing

```
%systemroot%\system32\inetsrv\AppCmd.exe LIST APPPOOL
```

Furthermore, this command can be wrapped in a powershell command and executed remotely

```
function RecycleAppPool($serverName, $appPoolId){
    Invoke-Command $serverName { param($appPoolId) %systemroot%\system32\inetsrv\AppCmd.exe recycle APPPOOL $appPoolId } -Args $appPoolId
}
$WEBPROD1 = "x.x.x.x";
$WEBPROD2 = "x.x.x.x";
RecycleAppPool $WEBPROD1 "SiteAppPoolId"
RecycleAppPool $WEBPROD2 "SiteAppPoolId"
```

To enable Powershell, you may need to run this command in CMD as an admin:

```
Set-ExecutionPolicy unrestricted
```

To enable powershell remoting, run the following command on the remote server you wish to control

```
Enable-PSRemoting -force
```