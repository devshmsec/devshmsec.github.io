---
layout: post
title: HackTheBox Traceback Walkthrough
date: 2020-08-15 20:30:00 +0530
categories: walkthroughs hackthebox
tags: linux ssh revshell webshell php
permalink: /:categories/:title.html
---

# HackTheBox Traceback Walkthrough

![Traceback Banner](/assets/images/hackthebox/traceback/banner.png)

### Synopsis

Traceback is an easy linux machine by Xh4H.This machine is about webshells as a backdoor.So we are having website which is hacked by Xh4H and he left the backdoor for us.So by getting the list of webshells from Xh4H's github account we got webshell.By uploading our generated ssh key to the machine we can get the shell as webadmin.There is note on the webadmin's home directory that says he left a tool for sysadmin.So after exploiting the lua binary by getting shell as sysadmin we an get the user.txt file.By running the linpeas on box it shows that there is directory of ssh banners which is writeble by sysadmin so by exploiting that we can get root.txt.

## Reconnaissance

### Nmap Scan

```nmap
nmap -sC -sV -Av -oA nmap/traceback 10.10.10.181
```

-sC - _run all the default scripts_  
-sV - _find the version of all the service running on the target_  
-A  - _run the scan in aggressive mode_  
-v  - _show output in verbose mode_  
-oA - _output to a file in all format_  

```nmap
# Nmap 7.80 scan initiated Sat May 30 11:30:44 2020 as: nmap -sC -sV -Av -oA nmap/traceback 10.10.10.181
Increasing send delay for 10.10.10.181 from 0 to 5 due to 64 out of 213 dropped probes since last increase.
Increasing send delay for 10.10.10.181 from 5 to 10 due to 11 out of 22 dropped probes since last increase.
Nmap scan report for 10.10.10.181
Host is up (0.23s latency).
Not shown: 997 closed ports
PORT     STATE    SERVICE VERSION
22/tcp   open     ssh     OpenSSH 7.6p1 Ubuntu 4ubuntu0.3 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   2048 96:25:51:8e:6c:83:07:48:ce:11:4b:1f:e5:6d:8a:28 (RSA)
|   256 54:bd:46:71:14:bd:b2:42:a1:b6:b0:2d:94:14:3b:0d (ECDSA)
|_  256 4d:c3:f8:52:b8:85:ec:9c:3e:4d:57:2c:4a:82:fd:86 (ED25519)
80/tcp   open     http    Apache httpd 2.4.29 ((Ubuntu))
| http-methods: 
|_  Supported Methods: GET POST OPTIONS HEAD
|_http-server-header: Apache/2.4.29 (Ubuntu)
|_http-title: Help us
1121/tcp filtered rmpp
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Read data files from: /usr/bin/../share/nmap
Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Sat May 30 11:31:41 2020 -- 1 IP address (1 host up) scanned in 56.54 seconds
```

So nmap show that there are only 2 ports are open ssh and http.  
So lets just visit the http first.

![Home](/assets/images/hackthebox/traceback/home.png)

It just a single page with a note that the website is been hacked and hacker put a backdoor on the machine for us.
If you check the web shells repository from Xh4H's github, there are lot of webshells, make the list of shells and run gobuster to see if we found anything.

![github webshells](/assets/images/hackthebox/traceback/github.png)

### Gobuster

![gobuster](/assets/images/hackthebox/traceback/gobuster.png)


## Foothold

### Webshell

We found that there is smevk.php webshell on the website. If you read the source code for smvek.php on Xh4H's github webshell repository, the username and password is _admin_. So we can login with that credential.  

![smvek webshell](/assets/images/hackthebox/traceback/smvek.png)

This webshell has lot of features, you can upload, read, write files if you have the permissions.
So lets just go to user's home directory and upload our ssh key so that we can get in the box as webadmin throush ssh.

![sshkeys](/assets/images/hackthebox/traceback/upload.png)

We can login into the box by our private ssh key.

![webadmin](/assets/images/hackthebox/traceback/webadmin.png)

### User flag

There is a note from the hacker for sysadmin that he left a tool for sysadmin to practice.Its a lua binary which runs as interpreter for lua and only sysadmin can run it.So we can use this tool to launch shell for sysadmin by lua command.

![user flag](/assets/images/hackthebox/traceback/users.png)


## Enumeration

### Linpeas

By running the linpeas.sh on the box, it shows that /etc/update-motd.d/ have all the ssh banner scripts which are writable by the sysadmin.

![linpeas](/assets/images/hackthebox/traceback/linpeas.png)

### Root flag

So we edit the 00-header file and append the commands for cating out the root flag.

![edit](/assets/images/hackthebox/traceback/edit.png)

Then when we try to login through ssh the banner also cat the root flag.You can also change the authorized_keys by your ssh key and login as root through ssh.

![root flag](/assets/images/hackthebox/traceback/root.png)

Thanks for reading this walkthrough, If you like it please share it on twitter, reddit or in linkedin.

