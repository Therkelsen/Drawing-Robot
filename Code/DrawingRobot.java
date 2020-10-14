
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

}