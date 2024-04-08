---
title: Command Limit Length
author: lehai
date: 2023-12-10 14:10:00 +0800
categories: [web,ctf]
tags: [web,ctf,write-up]
image:
  path: /assets/img/favicons/cookiearena.png
---

[Address challenge](https://battle.cookiearena.org/challenges/web/command-limit-length)


### Chanllenge Details
- Format flag:CHH{XXX}
- Web
- Command Injection

### Web Analysis

This website is used for remote command execution. But there are some commands such as ls, cat, sh,... that are blocked


![](/assets/img/writeup/Command-Limit-Length/1.png)
![](/assets/img/writeup/Command-Limit-Length/2.png)

We perform a bypass filter payload: <b style="color:red;">'l's.</b>. To understand more about bypass [Here](https://book.hacktricks.xyz/linux-hardening/bypass-bash-restrictions)

![](/assets/img/writeup/Command-Limit-Length/3.png)

As a result, we have performed a bypass. But one more thing is that it only allows input limit of 4 characters. We immediately named the hacktrick dictionary to continue searching and get results [Here](https://book.hacktricks.xyz/linux-hardening/bypass-bash-restrictions#rce-with-4-chars) 

![](/assets/img/writeup/Command-Limit-Length/4.png)

But the sh command was blocked so these failed

After a day of tossing and turning, I came up with an idea. I brought the idea into the Kali Linux environment to have an intuitive view.

I created a test folder and flag.txt to test the idea

![](/assets/img/writeup/Command-Limit-Length/5.png)


My idea is to use the > command to create a new file named cat <b style="color:red;">>cat</b>. Then I use the command <b style="color:red;">*</b>.

![](/assets/img/writeup/Command-Limit-Length/6.png)
![](/assets/img/writeup/Command-Limit-Length/7.png)

<b style="color:red;">BUMP!!!</b> I was able to read the flag file with a single character. Now I will explain how it works. First, we create a file named cat instead of the cat command. Next we use the command * this * command works by getting the names of all files in the current folder location. First it reads each file separately, then it reads 2 files and from there it continues to increase if there are more files. At one point, the command cat flag.txt will be issued. So we have read the flag.

Now I'm going to try it on challenge 

![](/assets/img/writeup/Command-Limit-Length/8.png)
![](/assets/img/writeup/Command-Limit-Length/9.png)
![](/assets/img/writeup/Command-Limit-Length/10.png)

## Thank you for watching!!!

<h1 align="center">Hi 👋, I'm Aes </h1>





