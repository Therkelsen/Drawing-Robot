
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
        /*
        for (int row = 1; row < shapes.height(); row++) {
            int i = 1;
            if (i % 2 == 0) {
                for (int col = i; col < shapes.width(); col++) {
                    grayVal = draw.convertGray(shapes.get(col,row).getRed(), shapes.get(col,row).getGreen(), shapes.get(col,row).getBlue());
                    draw.drawOrNot(grayVal);
                    System.out.println("Coords [x,y]: [" + col + ","+ row
                    + "] | Grayscale value : [" + grayVal 
                    + "] | Draw : " + draw.drawOrNot(grayVal));
                }
            } else {
                for (int col = i; col <= 1; col++) {
                    grayVal = draw.convertGray(shapes.get(col,row).getRed(), shapes.get(col,row).getGreen(), shapes.get(col,row).getBlue());
                    draw.drawOrNot(grayVal);
                    System.out.println("Coords [x,y]: [" + col + ","+ row
                    + "] | Grayscale value : [" + grayVal 
                    + "] | Draw : " + draw.drawOrNot(grayVal));
                }
            }
            i++;
        }*/

        /*for (int col = 1; col < shapes.width(); col++) {
            for (int row = 1; row < shapes.height(); row++) {
                if (col % 2 == 0) {
                    for (int i = 255; i < 1; i--) {
                        System.out.println(col + "," + i);
                    }
                } else {
                    System.out.println(col + "," + row);
                }
            }
        }*/
        
        for (int i = 1; i < shapes.width(); i++) {
            if (i % 2 == 0) {
                System.out.println("x");
                for (int col = 1; col < shapes.width(); col++) {
                    for (int row = i; row < shapes.height(); row++) {
                                System.out.println(col + ", " + row);
                    }
                }
            } else {
                System.out.println("y");
                for (int col = shapes.width(); col > 0; col--) {
                    for (int row = i; row < shapes.height(); row++) {
                                System.out.println(col + ", " + row);
                    }
                }
            }
        }
    }
}