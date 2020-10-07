
import Picture.java;
import Luminance.java;
import EdgeDetector.java;

public class DrawingRobotMain {
    public static void main(String[] args) {
        //  This is where we will put our main code
        Picture triangle = new Picture("D:/Files/GitHub/Drawing-Robot/Assets/triangle_grayscale.jpg");
        Picture danny = new Picture("D:/Files/GitHub/Drawing-Robot/Assets/danny.jpg");
        for (int col = 0; col < 1280; col++)
            for (int row = 0; row < 720; row++)
                System.out.println(danny.get(col,row));
        
    }
}