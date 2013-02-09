![Alt text](http://downloads.atoum.org/images/logo.png) 

# autotoum

**Feedbacks are appreciated :)**

**Check out the [screencast of autotoum](http://youtu.be/Rwp91TwkmsE)**

## Install on Ubuntu

```sh
$ sudo apt-get install inotify-tools
$ sudo wget -O /usr/local/bin/autotoum https://gist.github.com/jubianchi/4731236/raw/autotoum.sh
$ sudo chmo +x /usr/local/bin/autotoum
```
	
## Install on OSX

```sh
$ sudo gem install kicker
$ sudo wget -O /usr/local/bin/autotoum https://gist.github.com/jubianchi/4731236/raw/autotoum-osx.sh
$ sudo chmo +x /usr/local/bin/autotoum
```

**Note: The OSX version should work on any platform supporting ruby.**

## How to use

**To make ```autotoum``` work properly, you will have to configure atoum so that it can be used with [```--test-all```option](http://docs.atoum.org/fr/chapter3.html#test-all)**

```sh
$ cd /path/to/project
$ autotoum bin/atoum tests/units,src

# Use CTRL+C to exit loop
```

### Using notifications (experimental)

I wrote a simple notification system which you can find in [my fork of atoum (branch notifiers)](https://github.com/jubianchi/atoum/tree/notifiers):
	
```php
<?php
//.atoum.php

use \mageekguy\atoum;

$script->addDefaultReport()
	// Growl notifier : uses growlnotify command
	->addField(new atoum\report\fields\runner\result\notifier\growl())
	// OS X Notification Center notifier : uses terminal-notifier gem
	->addField(new atoum\report\fields\runner\result\notifier\terminal())
	// libnotify notifier : uses notify-send from libnotify
	->addField(new atoum\report\fields\runner\result\notifier\libnotify())
;
```

Now you only have to start autotoum in a detached process:

```sh
$ cd /path/to/project
$ autotoum bin/atoum tests/units,src > /dev/null 2>&1 &

# Kill the loop
$ fg
$ ^C
```
