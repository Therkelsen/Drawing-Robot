
package src;

//  Importing external classes needed
import java.awt.Color;
import java.util.ArrayList;

public class ImageProcessing {

    // Initialize color objects needed for image processing
    Color gray = new Color(100, 100, 100);
    Color white = new Color(255, 255, 255);

    // Initialize variables needed for image processing
    int threshold;
    float grayVal;
    int draw = 0;
    int prevDraw = 0;

    // Create an image object to convert onto
    Picture image;

    //  Initialize variables for storing/sending instructions
    ArrayList<String> inst;
    String instructions = "";

    public ImageProcessing(String path, int threshold){
        this.image = new Picture(path);
        this.threshold = threshold;
        this.inst = new ArrayList<>();
    }

    public void convertImage(int col, int row) {
        // Convert pixel to grayscale, then convert to black/white (no shading)
        image.set(col, row, Luminance.toGray(image.get(col, row)));
        grayVal = image.get(col, row).getRed();

        if (grayVal < threshold) {
            image.set(col, row, gray);
        } else {
            image.set(col, row, white);
        }

        // Update frame displaying image, and add current instruction to string
        image.show();
    }

    public void processImage(int col, int row) {
        // If the intensity of gray on the pixel is higher than the set limit
        // Pencil down (Draw), if not, Pencil up (Stop drawing)
        draw = (grayVal < threshold) ? 1 : 0;

        //  Only send an instruction if draw is different from prevDraw
        //  (Image goes from black to white, or vice versa
        String s;
        if (draw != prevDraw) {
            if (draw == 1) {
                s = (col + 1) + " " + (row + 1) + " " + draw + ",";
            } else {
                s = (col + 1) + " " + (row + 1) + " " + draw + ",";
            }
            inst.add(s);
        }
        prevDraw = draw;
    }

    public void print(String ip, int port, int size) {
        // Print everything in the terminal
        System.out.println();
        System.out.println("Transfer done");
        System.out.println("Length of instructions: [" + size + "] pairs");
        System.out.println("Size of image: [" + image.width() + " * " + image.height() + "] px = [" + (image.width() * image.height()) + "] px");
        System.out.println();
        System.out.println("Program done");
        System.out.println("Disconnecting from socket ip " + ip + " on port " + port);
        System.out.println("Exiting program");
    }
}