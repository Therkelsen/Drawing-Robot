
package com.company;

public class DrawingRobotMain {
    public static void main(String[] args) throws InterruptedException {
        
        System.out.println("====================");
        System.out.println("Starting program");

        RobotClient rc = new RobotClient("127.0.0.1", 80);
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
            //Thread.sleep(500);
        }

        System.out.println("Instructions: ");

        for (int i = 0; i < DrawingRobot.inst.size(); i++) {
            if (i % 2 != 0) {
                System.out.println("Sending data");
                DrawingRobot.instructions = DrawingRobot.instructions.concat(String.valueOf(DrawingRobot.inst.get(i)));
                rc.write(DrawingRobot.instructions + "\n");
                System.out.println(DrawingRobot.instructions);
                DrawingRobot.instructions = "";
            } else {
                DrawingRobot.instructions = DrawingRobot.instructions.concat(String.valueOf(DrawingRobot.inst.get(i)));
            }
        }
        DrawingRobot.print();
        
        rc.disconnect();
        System.out.println("Program done");
    }
}