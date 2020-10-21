
package dk.sdu.mmmi.rd1.edgedetect;

import java.awt.Color;

public class DrawingRobot {

    public static boolean drawOrNot(float gray){
        if (gray > 128) {
            return true;    // Blyant ned
        } else {
            return false;   // Blyant op
        }
    }

    public static int checkSize(int width, int height, int maxWidth, int maxHeight) {
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
    }

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