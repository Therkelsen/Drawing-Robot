
package dk.sdu.mmmi.rd1.edgedetect;

import java.awt.Color;

import java.util.ArrayList;

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
    static int prevDraw = 0;

    static String s = "";

    // * Loading image and initializing an image to convert onto
    static Picture image = new Picture("assets/danny.jpg");

    //static ArrayList<String> instructions = new ArrayList<String>();
    static String instructions = "";

    public static boolean drawOrNot(float gray, int threshold) {
        
        // *  If the intensity of gray is higher than the set limit
        // *  Pencil down (Draw), if not, Pencil up (Stop drawing)
        
        if (gray < threshold) { 
            return true;    
        } else {
            return false;
        }

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

        //image.show();

        draw = drawOrNot(grVal, threshold) ? 1 : 0;

        if (draw != prevDraw) {
            s = String.valueOf(col+1) + " " + String.valueOf(row + 1) + ",";
            instructions = instructions.concat(s);
        }
        
        prevDraw = draw;
    }

    public static void print() {

        // * Print everything in the terminal

        System.out.println("Instructions: ");
        System.out.println(instructions);
        System.out.println("End of instructions");
        System.out.println("");

        System.out.println("Length of instructions: [" + instructions.length() + "] pairs");
        System.out.println("Size of image: [" + image.width() + " * " + image.height() + "] px = [" + (image.width()*image.height()) + "] px");
        
    }

}