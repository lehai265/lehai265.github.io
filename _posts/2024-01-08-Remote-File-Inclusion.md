---
title: Remote File Inclusion
author: lehai
date: 2024-01-08 14:10:00 +0800
categories: [web]
tags: [web,ctf,write-up]
image:
  path: /assets/img/favicons/cookiearena.png
---

## Remote File Inclusion

#### By @es
 
[Address challenge](https://battle.cookiearena.org/challenges/web/remote-file-inclusion)

### Chanllenge Details
- Format flag:CHH{XXX}
- Web
- RCE
- LFI

### Web Analysis

Web page interface

![](/assets/img/writeup/Remote-File-Inclusion/1.png)

According to the topic, this website has an info.php page, so we go to check it out and see the allow_url_include On section. 

![](/assets/img/writeup/Remote-File-Inclusion/2.png)

First we test the LFI bug.

![](/assets/img/writeup/Remote-File-Inclusion/3.png)

Wow, the website has an LFI bug, now let's go get the flag

![](/assets/img/writeup/Remote-File-Inclusion/4.png)

But life is not as it seems, the flagXXXX.txt has had its last characters randomized so we don't know the exact file name.

We have a way to exploit it [Here](https://www.cdxy.me/?p=752). Payload:data:text/plain;base64,PD9waHAgc3lzdGVtKCJpZCIpPz4=. When decoded it is <?php system("id") ?>

![](/assets/img/writeup/Remote-File-Inclusion/5.png)

As a result, we have performed RCE. Now let's go find the flag

![](/assets/img/writeup/Remote-File-Inclusion/6.png)


![](/assets/img/writeup/Remote-File-Inclusion/7.png)


![](/assets/img/writeup/Remote-File-Inclusion/8.png)


![](/assets/img/writeup/Remote-File-Inclusion/9.png)


![](/assets/img/writeup/Remote-File-Inclusion/10.png)

## Thanks for watching !!!







