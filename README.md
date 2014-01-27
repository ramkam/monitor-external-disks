monitor-external-disks
======================

Collects disks statistics each time a disk is mounted
Based on the discussions on [superuser.com](http://superuser.com/questions/226504/unmount-a-volume-as-soon-as-its-inserted-if-its-name-is-xyz)

Contents
 * a plist file (com.x.x.x) to be put in ~/Library/LaunchAgents (it must have the .plist extension)
 * a bash script that does the works when a mount is done

Notes 
 * Time machine drive (df -h) is ignored

First time deployement

 * load it immediately with 
<pre><code>launchctl load ~/Library/LaunchAgents/pathtoplist</code></pre>
 * or wait for next login (it will autoload)

Tests

 * Tested on OSX Lion

Wishlist
 * Background analysis of the files (collect sizes, changes, calc hashes)
 * Upload the collected data to a database (like dropbox datasets or Mysql)
