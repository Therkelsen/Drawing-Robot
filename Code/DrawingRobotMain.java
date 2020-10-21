
package dk.sdu.mmmi.rd1.edgedetect;

import java.awt.Color;

import javax.swing.plaf.synth.SynthSplitPaneUI;

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
        
        Color grayVal = new Color(0,0,0);
        Color black = new Color(0,0,0);
        Color white = new Color(255,255,255);

        int threshold = 60;
        float grVal;
        int draw;

        String instructions = "Test, ";

        //int xVal = 0;
        
        Picture image = new Picture("Drawing-Robot/assets/danny.jpg");
        Picture convertedImage = new Picture(image.width(), image.height());
        
        //int[][] startDraw = new int[image.width()][2];
        //int[][] endDraw = new int[image.width()][2];

        image.show();
        
        for (int row = 0; row < image.height(); row++) {
            if (row % 2 != 0) {
                for (int col = 0; col < image.width(); col++) {
                    
                    grayVal = Luminance.toGray(image.get(col,row));
                    convertedImage.set(col, row, grayVal);
                    grVal = convertedImage.get(col,row).getRed();
                    
                    if (DrawingRobot.drawOrNot(grVal, threshold)) {
                        convertedImage.set(col, row, black);
                        //startDraw[col][row] = 1;
                    } else {
                        convertedImage.set(col, row, white);
                    }

                    convertedImage.show();

                    draw = DrawingRobot.drawOrNot(grVal, threshold) ? 1 : 0;

                    String s = String.valueOf(col) + "-"
                    + draw + ",";
                    instructions = instructions.concat(s);
                }
            } else {
                for (int col = image.width()-1; col >= 0; col--) {
                    
                    grayVal = Luminance.toGray(image.get(col,row));
                    convertedImage.set(col, row, grayVal);
                    grVal = convertedImage.get(col,row).getRed();

                    if (DrawingRobot.drawOrNot(grVal, threshold)) {
                        convertedImage.set(col, row, black);
                    } else {
                        convertedImage.set(col, row, white);
                    }
                    
                    draw = DrawingRobot.drawOrNot(grVal, threshold) ? 1 : 0;

                    String s = String.valueOf(col) + "-"
                    + draw + ",";
                    instructions = instructions.concat(s);
                }
            }
        }

        System.out.println("Instructions: ");
        System.out.println(instructions);
        System.out.println("End of instructions");
        System.out.println("");

        System.out.println("Length of string: " + instructions.length() + "characters");

        System.out.println("Program done");
    }
}