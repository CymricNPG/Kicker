# Kicker
A simple Kicker Management Application with GRAILS


A simple web frontend based on grails for managing hobby foosball (tabletop football) games without fixed teams. Provides
a minimum frontend to enter games and calculate the players elo.


You can:
- create players
- enter games
- show highscore based on elo calculation

Prerequisite:
-------------
- jre 1.7 or 1.8 (http://www.java.com/)

Installation:
-------------

Standalone:
- checkout the latest release from github (https://github.com/CymricNPG/Kicker/releases)
- start with: java -jar Kicker-<version>.jar
- Kicker will create (or use) the database files in the same directory (named prodDb.*)
- open with a web browser: http://localhost:8080/

Grails installed (build your own war):
- Checkout the distribution from github
- use "grails war" 
- and deploy it on a application server (http://grails.org/Deployment)
- Tomcat: You may need to increase the upload size, if you want to install it with the Tomcat-Manager:
  http://maxrohde.com/2011/04/27/large-war-file-cannot-be-deployed-in-tomcat-7/
- Kicker.war uses as default the h2 database (more information at http://grails.org/doc/latest/guide/single.html#3.3%20The%20DataSource)

Build:
------
- Checkout with git: git clone https://github.com/CymricNPG/Kicker.git
- "gradlew.bat -Dgrails.env=production assemble" (see more at http://grails.org/)


License:
--------

The Software is released under GPLv3: see LICENSE

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
