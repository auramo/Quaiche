
Quaiche
=======

An OSX dashboard widget which provides the next departures of the buses/stops that you're interested in. 

<img src="/screenshot.png"/>

Installation
------------

There is an installation script called install.sh at the root directory. It copies the Ruby scripts which contain most of the functionality to /usr/local/quaiche and it also copies the widget directory to your Desktop. From there you can double click the widget to install it onto your Dashboard. 

Note that the widget has a hard-coded path to the Ruby script /usr/local/quaiche/content_provider.rb so you must install the Ruby scripts into that directory unless you also edit the path (which is in Quaiche.js).

Note: you need to install the JSON gem, at least in older Ruby versions (like 1.8.x).

Default configuration
---------------------

When the widget has been started successfully for the first time, it creates a directory ".quaiche" under he user's home directory, for example:

/Users/jorma/.quaiche

A default example configuration containing a few bus stops and working credentials for the API is written to the directory to a file named quaiche.conf. This file is in YAML format (http://www.yaml.org), and should be used as a starting point to create your own configuration containing the bus stops and buses you are interested in.

The protocol
------------

The "HTTP GET" API is here:

http://developer.reittiopas.fi/pages/en/http-get-interface-version-2.php#lines

Go to "1.6 Stop information"

By default it uses the username/password combo:

schmuser
hslbusstop

You can try these credentials directly like this:

http://api.reittiopas.fi/hsl/prod/?request=stop&format=json&code=3331&user=schmuser&pass=hslbusstophttp://api.reittiopas.fi/hsl/prod/?request=stop&format=json&code=3331&user=schmuser&pass=hslbusstop

