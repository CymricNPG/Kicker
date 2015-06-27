A simple Kicker Management Application with GRAILS 
Version 2.7

You can:
- Enter new Player
- Enter new Games
- Show Highscore list

Prerequisite:
-------------
- jdk 1.6 (http://www.java.com/ or http://java.sun.com/)
- optional: jetty/tomcat/...

Installation:
-------------

Standalone:
- get the latest deployment (Kicker-complete-2.7.zip)
- uncompress it
- double-click on starter.jar or "java -jar starter.jar"
- wait some time
- open webbrowser and go to http://127.0.0.1:8080/Kicker

Grails installed (build your own war):
- Checkout the sourcecode from sourceforge or uncompress src.zip from Kicker-complete-2.7.zip
- use "grails war" and deploy it on a application server (http://grails.org/Deployment)
- or use "ant deploy" to create a complete application with source, war and standalone version

Existing Servlet Container: 
- download latest Kicker-complete-2.7.zip and uncompress it
- inside the unzipped directory you can find the Kicker.war file 
- deploy it on a container e.g. tomcat
  see http://grails.org/Deployment for more information, which containers are supported
- Kicker.war uses as default database h2.

Database:
---------
- standalone version:
  - uses a file based h2 database with hard coded attributes. The database will be created in the same 
    directory as the starter.jar
  - You can override the settings with ${userHome}/.grails/Kicker-config.properties or ${userHome}/.grails/Kicker-config.groovy
    (Stop the application before editing this file!)
 
- Installation in a web container
  - standard is a file based h2 database
  - the default configuration is located in:
      <tomcat directory>/webapps/Kicker/WEB-INF/classes/Kicker-config.properties
   
For more information look in http://grails.org/doc/latest/guide/single.html#3.3%20The%20DataSource

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
