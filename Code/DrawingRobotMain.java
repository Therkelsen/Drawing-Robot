
package dk.sdu.mmmi.rd1.edgedetect;

import java.awt.Color;
import Picture.java;
import Luminance.java;
import EdgeDetector.java;

public class DrawingRobotMain {
    public static void main(String[] args) {
        
        //  This is where we will put our main code
        
        System.out.println("====================");
        System.out.println("Starting program");

        Picture danny = new Picture("Drawing-Robot/assets/danny.jpg");
        
        danny.show();
        
        for (int col = 1; col < danny.width(); col++)
            for (int row = 1; row < danny.height(); row++)
                System.out.println("Coords [x,y]: [" + col + ","+ row
                + "] | Colors [r,g,b]: ["
                + danny.get(col,row).getRed() + ","
                + danny.get(col,row).getGreen() + ","
                + danny.get(col,row).getBlue() + "]");

                System.out.println("Program done");
        
        
    }
}