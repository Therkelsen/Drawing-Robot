
package dk.sdu.mmmi.rd1.edgedetect;

import java.awt.Color;

public class DrawingRobot {

    public static boolean drawOrNot(float gray, int threshold) {
        if (gray < threshold) { // *  If the intensity of gray is higher than the set limit
            return true;    // * Pencil down (Draw)
        } else {
            return false;   // * Pencil up (Stop drawing)
        }
    }

    /*public static int checkSize(int width, int height, int maxWidth, int maxHeight) {
        if (width < maxWidth || height < maxHeight) {
            if (width != height) {
                if ((width / maxWidth) > (height / maxHeight)) {
                    return width / maxWidth;
                } else {
                    return height / maxHeight;
                }
            } else {
                return width / maxWidth;
            }
        } else {
            return 1;
        }
    }*/

    /*  For main method
    
        int maxWidth = 1100; // In pixels
        int maxHeight = 750; // In pixels

        int prod;

        prod = checkSize(image.width(), image.height(), maxWidth, maxHeight);

        if (prod != 1) {
            image = new Picture((image.width() / prod), (image.height() / prod));
        }
    */

}