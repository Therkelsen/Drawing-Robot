
package dk.sdu.mmmi.rd1.edgedetect;

import java.awt.Color;

import DrawingRobot;
import Picture.java;
import Luminance.java;
import EdgeDetector.java;

public class DrawingRobotMain {
    public static void main(String[] args) {
        
        System.out.println("====================");
        System.out.println("Starting program");
        
        // * Colors needed
        Color grayVal = new Color(0,0,0);
        Color gray = new Color(100,100,100);
        Color white = new Color(255,255,255);

        // * Variables needed
        int threshold = 60;
        float grVal;
        int draw;
        int prevDraw = 1;

        String instructions = "";

        //int xVal = 0;
        
        // * Loading image and initializing an image to convert onto
        Picture image = new Picture("assets/danny.jpg");
        Picture convertedImage = new Picture(image.width(), image.height());
        
        //int[][] startDraw = new int[image.width()][2];
        //int[][] endDraw = new int[image.width()][2];

        //  Display the loaded image
        image.show();
        
        // * For every column in every row, where every other row iterates backwards
        // * Convert image to grayscale, then convert to "black"/white
        // * Then update frame displaying converted image, and add current instruction to string

        for (int row = 0; row < image.height(); row++) {
            if (row % 2 != 0) {
                for (int col = 0; col < image.width(); col++) {
                    
                    grayVal = Luminance.toGray(image.get(col,row));
                    convertedImage.set(col, row, grayVal);
                    grVal = convertedImage.get(col,row).getRed();
                    
                    if (DrawingRobot.drawOrNot(grVal, threshold)) {
                        convertedImage.set(col, row, gray);
                        //startDraw[col][row] = 1;
                    } else {
                        convertedImage.set(col, row, white);
                    }

                    convertedImage.show();

                    draw = DrawingRobot.drawOrNot(grVal, threshold) ? 1 : 0;
                    
                    if (draw == 1 && prevDraw == 0) {
                        String s = String.valueOf(col) + ",";
                        instructions = instructions.concat(s);
                    } else if (draw == 0 && prevDraw == 1) {
                        String s = String.valueOf(col) + ",";
                        instructions = instructions.concat(s);
                    }
                    
                    prevDraw = draw;
                }
            } else {
                for (int col = image.width()-1; col >= 0; col--) {
                    
                    grayVal = Luminance.toGray(image.get(col,row));
                    convertedImage.set(col, row, grayVal);
                    grVal = convertedImage.get(col,row).getRed();

                    if (DrawingRobot.drawOrNot(grVal, threshold)) {
                        convertedImage.set(col, row, gray);
                    } else {
                        convertedImage.set(col, row, white);
                    }
                    
                    convertedImage.show();

                    draw = DrawingRobot.drawOrNot(grVal, threshold) ? 1 : 0;
                    
                    if (draw == 1 && prevDraw == 0) {
                        String s = String.valueOf(col) + ",";
                        instructions = instructions.concat(s);
                    } else if (draw == 0 && prevDraw == 1) {
                        String s = String.valueOf(col) + ",";
                        instructions = instructions.concat(s);
                    }
                    
                    prevDraw = draw;
                }
            }
        }

        // * Print everything in the terminal
        System.out.println("Instructions: ");
        System.out.println(instructions);
        System.out.println("End of instructions");
        System.out.println("");

        System.out.println("Length of string: " + instructions.length() + " characters");

        System.out.println("Program done");
    }
}