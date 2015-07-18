A simple Kicker Management Application with GRAILS
Version 3.1

You can:
- Enter new Player
- Enter new Games
- Show Highscore list

Prerequisite:
-------------
- jre 1.7 or 1.8 (http://www.java.com/)
- jetty/tomcat/...

Installation:
-------------

Standalone:
(standalone is currently not working with grails 3.0.2, use older versions of Kicker)
- Checkout the distribution from sourceforge or uncompress Kicker-3.0.jar from Kicker-complete-3.0.7z
- start with: java -jar Kicker-3.0.jar
- open with a web browser http://localhost:8080/

Grails installed (build your own war):
- Checkout the distribution from sourceforge or uncompress src.7z from Kicker-complete-3.0.7z
- use "grails war" and deploy it on a application server (http://grails.org/Deployment)

Existing Servlet Container:
- download latest Kicker-complete-3.0.7z and uncompress it
- inside the archive you can find the Kicker.war file
- deploy it on a container e.g. tomcat
  see http://grails.org/Deployment for more information, which containers are supported
- Kicker.war uses as default database h2, but uses the wrong database file (see open issues)
- Tomcat: You may increase the upload size, if installed through the Manager:
  http://maxrohde.com/2011/04/27/large-war-file-cannot-be-deployed-in-tomcat-7/

Build:
------
- Checkout with git: git clone git://git.code.sf.net/p/kicker/git kicker-git
- "grails war" or "gradlew.bat -Dgrails.env=production assemble" (see more at http://grails.org/)

Database:
---------
- Installation in a web container
  - standard is a file based h2 database
  - the default configuration is located in:
      <tomcat directory>/webapps/Kicker/WEB-INF/classes/Kicker-config.properties

For more information look in http://grails.org/doc/latest/guide/single.html#3.3%20The%20DataSource

Open Issues:
------------
- Wrong Database selection on tomcat (war deployment): https://github.com/grails/grails-core/issues/9043
- generated batch file is invalid with: gradlew -Dgrails.env=production assemble

License:
--------

The Software is released under GPLv3: see gpl.txt

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
