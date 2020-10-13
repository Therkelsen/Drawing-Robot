
package dk.sdu.mmmi.rd1.edgedetect;

public class DrawingRobot {

    public DrawingRobot() {
    }

    public double convertGray(double r, double g, double b) {
                return 0.299*r + 0.587*g + 0.114*b;
    }
    
    public boolean drawOrNot(double gray){
        if (gray < 240) {
            return true;    // Blyant ned
        } else {
            return false;   // Blyant op
        }
    }

}