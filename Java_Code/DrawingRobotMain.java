
package dk.sdu.mmmi.rd1.edgedetect;

import DrawingRobot;
import dk.sdu.mmmi.rd1.robotcomm.RobotClient;

public class DrawingRobotMain {
    public static void main(String[] args) {
        
        System.out.println("====================");
        System.out.println("Starting program");

        RobotClient rc = new RobotClient("127.0.0.1", 80);
        rc.connect();
        System.out.println("Is connected: " + rc.isConnected());
        
        RobotClient rc = new RobotClient("127.0.0.1",80);
        
        // * For every column in every row, where every other row iterates backwards

        for (int row = 0; row < DrawingRobot.image.height(); row++) {
            if (row % 2 != 0) {
                for (int col = 0; col < DrawingRobot.image.width(); col++) {
                    DrawingRobot.processImage(col, row);
                }
            } else {
                for (int col = DrawingRobot.image.width()-1; col >= 0; col--) {
                    DrawingRobot.processImage(col, row);
                }
            }
            System.out.println("Sending data");
            rc.write("Hej");
            //rc.write("(" + (row+1) + ")" + "\n");
            //rc.write(DrawingRobot.instructions + "\n");
            DrawingRobot.instructions = "";
        }
        
<<<<<<< Updated upstream
        
        
        //DrawingRobot.print();
        rc.disconnect();
        System.out.println("Program done");
=======
        DrawingRobot.print();
        
        rc.connect();
        System.out.println("Is connected: " + rc.isConnected());
        rc.write(DrawingRobot.instructions);
>>>>>>> Stashed changes
    }
}