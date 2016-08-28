### app-info.sh

finds and pulls the specified apk off a device

#### example

`./app-info.sh -p appname`

### decompile.sh

converts apks to jars and then converts jars to java source

#### example

`./decompile.sh`

### install-burp-cert.sh

will install burp's certificate authority to an android device's trust store.
works with DER certificates exported straight from burp.

#### example

`./install-burp-cert.sh -c burp.cer`
