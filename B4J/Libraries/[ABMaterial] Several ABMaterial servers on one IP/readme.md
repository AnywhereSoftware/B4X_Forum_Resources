### [ABMaterial] Several ABMaterial servers on one IP by MichalK73
### 04/24/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/113015/)

Hello.  
  
I was struggling to see several ABMaterial servers visible from one IP on one port. I use it because I have one VPS test server for clients and I put there test versions for them. Each time I gave them a different port for their different ABMAterial server. As you know, each ABMaterial server must have a different port or conflict will occur.  
  
Scheme:  
1. Apache works on port 80, e.g. WEB page  
2. App1 ABMaterial works on port 8080 (AppName - test1)  
3. App2 ABMaterial works on port 8888 (AppName - test2)  
  
With this arrangement we have:  
<http://server.com> - WEB page  
<http://server.com:8080/test1> - App1  
<http://server.com:8888/test2> - App2  
  
Unfortunately, some client companies' proxies did not allow ports other than 80,443. The solution is to use an Apache proxy.  
  
Required modules for Apache:  
mod\_proxy\_connect, mod\_proxy\_express, mod\_proxy\_fcgi, mod\_proxy\_fdpss, mod\_proxy\_ftp, mod\_proxy\_http, mod\_proxy\_scgi, mod\_proxy\_wstunnel, mod\_proxy\_ajp  
  
Tested on CentOS 7. All these modules are in standard but in version 6 there is no 'wstunnel' and you need to search the web or compile manually.  
  
We set up virtual servers in httpd.conf.  
  

```B4X
<VirtualHost *:80>  
    ServerName app1.server.com  
    ProxyPreserveHost On  
    ProxyRequests Off  
    RewriteEngine On  
    ProxyPass /test1 http://localhost:8888/test1  
    ProxyPass /css http://localhost:8888/css  
    ProxyPass /js http://localhost:8888/js  
    ProxyPass /font http://localhost:8888/font  
    ProxyPass /ws ws://localhost:8888/ws  
    ServerAlias app1  
</VirtualHost>  
  
  
<VirtualHost *:80>  
    ServerName app2.server.com  
    ProxyPreserveHost On  
    ProxyRequests Off  
    ProxyPass /test2 http://localhost:8080/test2  
    ProxyPass /css http://localhost:8080/css  
    ProxyPass /js http://localhost:8080/js  
    ProxyPass /font http://localhost:8080/font  
    ProxyPass /ws ws://localhost:8080/ws  
    ServerAlias app2  
</VirtualHost>
```

  
  
After restarting the Apache server we have the result in the form:  
1. <http://server.com> - WEB website  
2. [http://app1.server.com/test1](http://server.com/test1) - webapp ABMaterial (AppName test1)  
3. [http://app2.server.com/test2](http://server.com/test2) - webapp ABMaterial (AppName test2)  
  
In this way, we get rid of the port address because it is automatically handled by the Apache proxy. Works equally well at cloudflare.com where we can force SSL from CF and on our side remains without SSL. You might as well enable SSL on your servers.  
  
Tips: using 'mod\_proxy\_balancer' we can make our own balancer server by distributing the load over several machines with identical ABMaterial servers.  
  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ FOR CADDY SERVER \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_  
  
As I mentioned caddy server works much better, simpler and faster than reverse in Apache. There is no need to add modules and make many entries in the Apache config.  
  
Install caddy server on your server and then edit the config file in /etc/caddy/Caddyfile  
  
As an example, I am providing the file structure for several web servers on one machine. I have 5 ABMaterial sites running on one cheap VPS. Among others the Abmaterial demo   
[Demo ABMaterial](https://demo.123321.best/demo)  
  

```B4X
# The Caddyfile is an easy way to configure your Caddy web server.  
#  
# Unless the file starts with a global options block, the first  
# uncommented line is always the address of your site.  
#  
# To use your own domain name (with automatic HTTPS), first make  
# sure your domain's A/AAAA DNS records are properly pointed to  
# this machine's public IP, then replace ":80" below with your  
# domain name.  
  
:80 {  
    #for static file  
    #root * /var/www/html  
      
    #for default server ABMaterial  
    reverse_proxy localhost:81  
}  
  
  
page1.mydomain.com:80 {  
    # Set this path to your site's directory.  
    # root * /usr/share/caddy  
  
    # Enable the static file server.  
    # file_server  
  
    # Another common task is to set up a reverse proxy:  
    reverse_proxy localhost:8083  
  
    # Or serve a PHP site through php-fpm:  
    # php_fastcgi localhost:9000  
}  
  
page2.mydomain.com:80 {  
    # Set this path to your site's directory.  
    # root * /usr/share/caddy  
  
    # Enable the static file server.  
    # file_server  
  
    # Another common task is to set up a reverse proxy:  
    reverse_proxy localhost:8080  
  
    # Or serve a PHP site through php-fpm:  
    # php_fastcgi localhost:9000  
}  
  
page1.mydomain.com:80 {  
    # Set this path to your site's directory.  
    # root * /usr/share/caddy  
  
    # Enable the static file server.  
    # file_server  
  
    # Another common task is to set up a reverse proxy:  
    reverse_proxy localhost:8888  
  
    # Or serve a PHP site through php-fpm:  
    # php_fastcgi localhost:9000  
}
```