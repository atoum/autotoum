![atoum](http://downloads.atoum.org/images/logo.png)

# autotoum - atoum auto-loop mode

**Feedbacks are appreciated :)**

**Check out the [screencast of autotoum](http://youtu.be/Rwp91TwkmsE)**

**Read the documentation at [http://jubianchi.fr/autotoum/](http://jubianchi.fr/autotoum/)**

## How to install

```sh
$ gem install --version '< 2.6' kicker
$ sudo wget -O /usr/local/bin/autotoum https://raw.github.com/jubianchi/autotoum/master/autotoum
$ sudo chmod +x /usr/local/bin/autotoum
```

## How to use

```
Usage : autotoum [-h] [-d] [-q] [-b path/to/atoum] [-w path/to/sources] [-- extra-args]
     -h : Display this message
     -q : Quiet mode (no output)
     -d : Background mode (no output)

     Path to atoum : path to atoum executable (defaults to bin/atoum)
     Path to sources : the watched files and/or directories (defaults to src, tests/units)
     Extra arguments : Extra arguments are forwarded to the atoum executable

     You can specify several files/directories to watch using a comma (,) separated list:
         $ autotoum -w src,tests/units/subset,tests/units/otherSubset -- -d tests/units
         # Use CTRL+C to quit

     Background mode:
         $ autotoum -d -w src,tests/units/subset,tests/units/otherSubset -- -d tests/units
         $ ...
         $ autotoum stop
 ```