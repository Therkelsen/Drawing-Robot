
package dk.sdu.mmmi.rd1.edgedetect;

import DrawingRobot;

public class DrawingRobotMain {
    public static void main(String[] args) {
        
        System.out.println("====================");
        System.out.println("Starting program");
        
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
        }
        
        DrawingRobot.print();
    }
}