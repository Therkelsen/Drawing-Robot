
package com.company;

public class DrawingRobotMain {
    public static void main(String[] args) throws InterruptedException {
        
        System.out.println("====================");
        System.out.println("Starting program");

        String ip = "10.0.0.69";
        int port = 12345;

        RobotClient rc = new RobotClient(ip, port);
        rc.connect();
        System.out.println("Is connected: " + rc.isConnected());
        
        // For every column in every row, where every other row iterates backwards

        for (int row = 0; row < DrawingRobot.image.height(); row++) {
            if (row % 2 == 0) {
                for (int col = 0; col < DrawingRobot.image.width(); col++) {
                    DrawingRobot.processImage(col, row);
                }
            } else {
                for (int col = DrawingRobot.image.width()-1; col >= 0; col--) {
                    DrawingRobot.processImage(col, row);
                }
            }

        }

        System.out.println("Instructions: ");
        Thread.sleep(5000);
        //rc.write("Number of pairs of coordinate sets: " + DrawingRobot.inst.size());
        int x = 0;
        for (int i = 0; i < DrawingRobot.inst.size(); i++) {
            if (i % 2 == 0) {
                x++;
            }
        }
        //rc.write(String.valueOf(x));
        for (int i = 0; i < DrawingRobot.inst.size(); i++) {
            if (i % 2 != 0) {
                System.out.print("Sending data : ");
                DrawingRobot.instructions = DrawingRobot.instructions.concat(String.valueOf(DrawingRobot.inst.get(i)));
                rc.write(DrawingRobot.instructions);
                System.out.println(DrawingRobot.instructions);
                DrawingRobot.instructions = "";
                //rc.disconnect();

            } else {
                //rc.connect();
                DrawingRobot.instructions = DrawingRobot.instructions.concat(String.valueOf(DrawingRobot.inst.get(i)));
            }
            Thread.sleep(500);
        }
        Thread.sleep(2000);
        rc.write("DONE");
        DrawingRobot.print(ip, port);
        System.exit(0);
    }
}