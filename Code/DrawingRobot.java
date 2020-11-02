
package dk.sdu.mmmi.rd1.edgedetect;

import java.awt.Color;

import DrawingRobot;
import Picture.java;
import Luminance.java;

public class DrawingRobot {

    // * Colors needed
    static Color grayVal = new Color(0,0,0);
    static Color gray = new Color(100,100,100);
    static Color white = new Color(255,255,255);

    // * Variables needed
    static int threshold = 60;
    static float grVal;
    static int draw;
    static int prevDraw = 1;

    static String instructions = "";

    // * Loading image and initializing an image to convert onto
    static Picture image = new Picture("assets/danny.jpg");

    public static boolean drawOrNot(float gray, int threshold) {
        
        // *  If the intensity of gray is higher than the set limit
        // *  Pencil down (Draw), if not, Pencil up (Stop drawing)
        
        if (gray < threshold) { 
            return true;    
        } else {
            return false;
        }
        
        //prevDraw = draw;
    }

    public static void processImage(int col, int row) {
        
        // * Convert image to grayscale, then convert to "black"/white

        grayVal = Luminance.toGray(image.get(col,row));
        image.set(col, row, grayVal);
        grVal = image.get(col,row).getRed();
        
        if (drawOrNot(grVal, threshold)) {
            image.set(col, row, gray);
            //startDraw[col][row] = 1;
        } else {
            image.set(col, row, white);
        }

        // * Update frame displaying image, and add current instruction to string

        image.show();

        draw = drawOrNot(grVal, threshold) ? 1 : 0;

        if (draw == 1 && prevDraw == 0) {
            String s = String.valueOf(col) + " " + String.valueOf(row) 
            + " " + String.valueOf(draw) + ",";
            instructions = instructions.concat(s);
        } else if (draw == 0 && prevDraw == 1) {
            String s = String.valueOf(col) + " " + String.valueOf(row) 
            + " " + String.valueOf(draw) + ",";
            instructions = instructions.concat(s);
        }
        
        prevDraw = draw;
    }

    static void print() {

        // * Print everything in the terminal

        System.out.println("Instructions: ");
        System.out.println(instructions);
        System.out.println("End of instructions");
        System.out.println("");

        System.out.println("Length of string: " + instructions.length() + " characters");

        System.out.println("Program done");
    }

}