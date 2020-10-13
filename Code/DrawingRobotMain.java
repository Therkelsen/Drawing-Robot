
package dk.sdu.mmmi.rd1.edgedetect;

import java.awt.Color;
import DrawingRobot;
import Picture.java;
import jdk.dynalink.linker.GuardingTypeConverterFactory;
import Luminance.java;
import EdgeDetector.java;

public class DrawingRobotMain {
    public static void main(String[] args) {
        
        //  This is where we will put our main code
        
        System.out.println("====================");
        System.out.println("Starting program");
        
        double grayVal;
        //Picture danny = new Picture("Drawing-Robot/assets/danny.jpg");
        Picture shapes = new Picture("Drawing-Robot/assets/shapes.png");
        DrawingRobot draw = new DrawingRobot();
        
        shapes.show();
        
        for (int row = 0; row < shapes.height(); row++) {
            if (row % 2 != 0) {
                for (int col = 0; col <= shapes.width(); col++) {
                    System.out.println(col + ", " + row);
                }
            }  else {
                for (int col = shapes.width(); col >= 0; col--) {
                    System.out.println(col + ", " + row);
                }
            }
        }

    }
}