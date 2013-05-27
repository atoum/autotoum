![atoum](http://downloads.atoum.org/images/logo.png)

# autotoum - atoum auto-loop mode

**Feedbacks are appreciated :)**

**Check out the [screencast of autotoum](http://youtu.be/Rwp91TwkmsE)**

**Read the documentation at [http://jubianchi.fr/autotoum/](http://jubianchi.fr/autotoum/)**

## Install autotoum

```shell
$ curl https://raw.github.com/jubianchi/autotoum/master/installer | php
$ ./autotoum -h

# Enjoy TDD !
```

### Installer Usage

```shell
$ ./installer --usage
$ curl https://raw.github.com/jubianchi/autotoum/master/installer | php -- --usage
> autotoum installer
> atoum auto-loop mode
--global        : Install autotoum as a global command
--check         : Only run system requirements check

Environment :
AUTOTOUM_GIT_URL : Git repository (default : https://raw.github.com/jubianchi/autotoum/master/autotoum)
AUTOTOUM_PATH   : Installation directory (implies --global, default : /usr/share)
AUTOTOUM_SYMLINK : autotoum bin symlink path (implies --global, default: /usr/local/bin)

Examples :
$ curl https://raw.github.com/jubianchi/autotoum/master/installer | sudo php -- --global
$ curl https://raw.github.com/jubianchi/autotoum/master/installer | AUTOTOUM_PATH=/home/me php
```

## How to use

```
$ autotoum -h
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