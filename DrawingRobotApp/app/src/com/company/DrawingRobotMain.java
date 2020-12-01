
package com.company;

public class DrawingRobotMain {
    public static void main(String[] args) throws InterruptedException {

        System.out.println("====================");
        System.out.println("Starting program");
        System.out.println();

        System.out.println("Initializing variables");

        //  Initialize variables for socket connection
        String ip = "10.0.0.69";
        int port = 12345;

        //  Initialize variables for image processing
        String imagePath = "app/Assets/swarte_piet.png";

        int blackOrWhiteThreshold = 60;

        System.out.println("Connecting to Drawing Robot");

        //  Create objects for socket connection and image processing
        //  then connect to socket
        RobotClient rc = new RobotClient(ip, port);
        DrawingRobot dr = new DrawingRobot(imagePath, blackOrWhiteThreshold);
        rc.connect();

        System.out.println("Is connected: " + rc.isConnected());
        System.out.println();

        System.out.println("Starting image processing");
        // For every column in every row, where every other row iterates backwards
        for (int row = 0; row < dr.image.height(); row++) {
            if (row % 2 == 0) {
                for (int col = 0; col < dr.image.width(); col++) {
                    dr.convertImage(col, row);
                    dr.processImage(col, row);
                }
            } else {
                for (int col = dr.image.width() - 1; col >= 0; col--) {
                    dr.convertImage(col, row);
                    dr.processImage(col, row);
                }
            }

        }
        System.out.println("Image processing done");
        System.out.println("Transferring instructions: ");
        Thread.sleep(2500);
        //rc.write("Number of pairs of coordinate sets: " + dr.inst.size());
        int x = 0;
        for (int i = 0; i < dr.inst.size(); i++) {
            if (i % 2 != 0) {
                System.out.print("Sending data : ");
                dr.instructions = dr.instructions.concat(String.valueOf(dr.inst.get(i)));
                rc.write(dr.instructions);
                System.out.println(dr.instructions);
                dr.instructions = "";
                x++;

            } else {
                dr.instructions = dr.instructions.concat(String.valueOf(dr.inst.get(i)));
            }
            Thread.sleep(150);
        }
        Thread.sleep(2500);
        rc.write("DONE");
        dr.print(ip, port, x);
        System.exit(0);
    }
}