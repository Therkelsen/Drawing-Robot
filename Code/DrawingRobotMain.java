
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
        Picture shapes = new Picture("Drawing-Robot/assets/danny.jpg");
        DrawingRobot draw = new DrawingRobot();
        
        shapes.show();
        
        for (int row = 0; row < shapes.height(); row++) {
            if (row % 2 != 0) {
                for (int col = 0; col < shapes.width(); col++) {
                    
                    grayVal = draw.convertGray(shapes.get(col,row).getRed(), 
                    shapes.get(col,row).getGreen(), 
                    shapes.get(col,row).getBlue());
                    
                    System.out.println("Coordinates [col, row]: [" + col + ", " + row
                    + "] | Grayscale value: [" + Math.round(grayVal) + "] | Draw: [" 
                    + draw.drawOrNot(grayVal) + "]");
                }
            } else {
                for (int col = shapes.width()-1; col >= 0; col--) {
                    grayVal = draw.convertGray(shapes.get(col,row).getRed(), 
                    shapes.get(col,row).getGreen(), 
                    shapes.get(col,row).getBlue());
                    
                    System.out.println("Coordinates [col, row]: [" + col + ", " + row
                    + "] | Grayscale value: [" + Math.round(grayVal) + "] | Draw: [" 
                    + draw.drawOrNot(grayVal) + "]");
                }
            }
        }
        System.out.println("Program done");
    }
}