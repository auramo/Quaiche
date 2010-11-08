
Installation
------------

There is an installation script called install.sh at the root directory. It copies the Ruby scripts which contain most of the functionality to /usr/local/quaiche and it also copies the widget directory to your Desktop. From there you can double click the widget to install it onto your Dashboard. 

Note that the widget has a hard-coded path to the Ruby script /usr/local/quaiche/content_provider.rb so you must install the Ruby scripts into that directory unless you also edit the path (which is in Quaiche.js).

Default configuration
---------------------

When the widget has been started successfully for the first time, it creates a directory ".quaiche" under he user's home directory, for example:

/Users/jorma/.quaiche

A default example configuration containing a few bus stops and working credentials for the API is written to the directory to a file named quaiche.conf. This file is in YAML format (http://www.yaml.org), and should be used as a starting point to create your own configuration containing the bus stops and buses you are interested in.

The protocol
------------

The "HTTP GET" API is here:

http://developer.reittiopas.fi/pages/en/http-get-interface.php

Go to "1.9 Stop timetable"

By default it uses the username/password combo:

schmuser
hslbusstop

You can try these credentials directly like this:

http://api.reittiopas.fi/public-ytv/fi/api/?stop=2222209&user=schmuser&pass=hslbusstop


