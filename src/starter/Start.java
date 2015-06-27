/**
 *   A simple foosball management application
 *   Copyright (C) 2008 Roland Spatzenegger
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program.  If not, see http://www.gnu.org/licenses/.
 */

import java.io.File;

import org.eclipse.jetty.server.Connector;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.nio.SelectChannelConnector;
import org.eclipse.jetty.webapp.WebAppContext;

/**
 * @author cymric
 * @version $Revision 1.1$
 */
public class Start {

    /**
     * @param args
     */
    public static void main(String[] args) {
        File dir = new File(".");
        String file = null;
        for (String f : dir.list()) {
            if (f.endsWith(".war")) {
                file = f;
            }
        }
        if (file == null) {
            throw new RuntimeException("Cannot find .war file.");
        } else {
            System.err.println("Starting:" + file);
        }
        final Server server = new Server();
        Connector connector = new SelectChannelConnector();
        connector.setPort(8080);
        connector.setHost("127.0.0.1");
        server.addConnector(connector);

        WebAppContext wac = new WebAppContext();
        wac.setContextPath("/Kicker");
        wac.setWar(file);
        server.setHandler(wac);
        server.setStopAtShutdown(true);
        new Thread(new Runnable() {

            @Override
            public void run() {
                while (!server.isStarted()) {
                    try {
                        Thread.sleep(1000);
                    } catch (InterruptedException e) {
                        throw new RuntimeException(e.getMessage());
                    }
                }
                System.err.println("Server started: http://127.0.0.1:8080/Kicker");
            }
        }).start();
        try {
            server.start();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
