#TODO

###Set up Apache

Uncomment this line in: /etc/apache2/httpd.conf

    #Include /private/etc/apache2/extra/httpd-vhosts.conf

Paste this into: /etc/apache2/extra/httpd-vhosts.conf

    NameVirtualHost *:80

    <VirtualHost *:80>
        ServerAdmin webmaster@dummy-host2.example.com
        DocumentRoot /Users/oliver/Code
        ServerAlias *.oliver.dev
        RewriteEngine on
        <Directory /Users/oliver/Code>
            Options Indexes FollowSymLinks MultiViews
            AllowOverride All
            Order allow,deny
            allow from all
        </Directory>

        # For a Symfony type project
        RewriteCond %{HTTP_HOST} !^www.* [NC]
        RewriteCond %{HTTP_HOST} ^([^\.]+)\.oliver.dev
        RewriteCond /Users/oliver/Code/%1/web -d
        RewriteRule ^(.*) /%1/web/$1 [L]

        # For a normal php project
        RewriteCond %{HTTP_HOST} !^www.* [NC]
        RewriteCond %{HTTP_HOST} ^([^\.]+)\.oliver.dev
        RewriteCond /Users/oliver/Code/%1 -d
        RewriteRule ^(.*) /%1/$1 [L]

        ErrorLog "/private/var/log/apache2/%1-error.log"
        CustomLog "/private/var/log/apache2/%1-access.log" common
    </VirtualHost>

If you need SSL follow [this guide](http://blog.andyhunt.info/2011/11/26/apache-ssl-on-max-osx-lion-10-7/).

###Install dnsmasq

    brew install dnsmasq
    echo "address=/oliver.dev/127.0.0.1" > $(brew --prefix)/etc/dnsmasq.conf
    sudo cp -fv /usr/local/opt/dnsmasq/*.plist /Library/LaunchDaemons
    sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
    sudo mkdir -v /etc/resolver
    sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/oliver.dev'


###Add PHP 5.4

    brew tap josegonzalez/php
    brew options php54
    brew tap homebrew/dupes
    brew install php54 --with-debug

To enable PHP in Apache add the following to httpd.conf and restart Apache:

    LoadModule php5_module    /usr/local/opt/php54/libexec/apache2/libphp5.so

    brew install php54-xdebug php54-apc php54-intl

Some php apps need the timezone setting. Symfony2, I'm looking at you.

    ;date.timezone =
    /usr/local/etc/php/5.4/php.ini

    cp /usr/local/Cellar/php54/5.4.21/homebrew-php.josegonzalez.php54.plist ~/Library/LaunchAgents/
    launchctl load -w ~/Library/LaunchAgents/homebrew-php.josegonzalez.php54.plist

Up the membery limit:
    
    memory_limit = 2048M

Up the xdebug nesting level (behat can't cope with low limits like 100):

    vim /usr/local/etc/php/5.4/conf.d/ext-xdebug.ini

    xdebug.max_nesting_level = 500

Install PHPUnit:

    sudo pear channel-discover pear.phpunit.de
    sudo pear channel-discover pear.symfony.com
    sudo pear install --alldeps phpunit/phpunit

Add to php.ini:

    include_path=".:/usr/local/Cellar/php54/5.4.21/lib/php/"

Add to bash path:

    export PATH="$(brew --prefix josegonzalez/php/php54)/bin:/usr/local/bin:$PATH"

###Add mysql

    brew install mysql

To have launchd start mysql at login:

    ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents

###Install Node & less

    brew install node

    npm install -g less #(might need sudo)

###Exim

Sooner or later we'll have an app that needs to send a mail.

    brew install exim
    # TODO - does not currently work - can't download source

###Some projects use MongoDB instead of MySQL

    brew install mongodb php54-mongo
    sudo apachectl restart

To have launchd start mongodb at login:

    ln -sfv /usr/local/opt/mongodb/*.plist ~/Library/LaunchAgents

Then to load mongodb now:

    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist

