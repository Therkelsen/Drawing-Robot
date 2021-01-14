
package app.src;

public class DrawingRobotMain {
    public static void main(String[] args) throws InterruptedException {

        System.out.println("====================");
        System.out.println("Starting program");
        System.out.println();

        System.out.println("Initializing variables");

        //  Initialize variables for socket connection
        String ip = "10.0.0.69";
        int port = 12345;

        //  Initialize variables for image processing
        String imagePath = "Java/Assets/Untitled4.png";

        int blackOrWhiteThreshold = 80;

        System.out.println("Connecting to Drawing Robot");

        //  Create objects for socket connection and image processing
        //  then connect to socket
        RobotClient robcom = new RobotClient(ip, port);
        ImageProcessing imgpro = new ImageProcessing(imagePath, blackOrWhiteThreshold);
        robcom.connect();

        System.out.println("Is connected: " + robcom.isConnected());
        System.out.println();

        System.out.println("Starting image processing");
        // For every column in every row, where every other row iterates backwards
        for (int row = 0; row < imgpro.image.height(); row++) {
            if (row % 2 != 0) {
                for (int col = 0; col < imgpro.image.width(); col++) {
                    imgpro.convertImage(col, row);
                    imgpro.processImage(col, row);
                }
            } else {
                for (int col = imgpro.image.width() - 1; col >= 0; col--) {
                    imgpro.convertImage(col, row);
                    imgpro.processImage(col, row);
                }
            }

        }
        System.out.println("Image processing done");
        System.out.println("Transferring instructions: ");
        Thread.sleep(2500);

        int x = 1;
        for (int i = 0; i < imgpro.inst.size(); i++) {
            if (i % 2 != 0) {
                System.out.print("Sending data [" + x + "] of [" + imgpro.inst.size()/2 + "] | ["
                        + String.format("%.2f", (2*((float)x/(float)imgpro.inst.size()*100)))
                        + "%] done | Data: ");
                imgpro.instructions = imgpro.instructions.concat(String.valueOf(imgpro.inst.get(i)));
                robcom.write(imgpro.instructions);
                System.out.println(imgpro.instructions);
                imgpro.instructions = "";
                x++;

            } else {
                imgpro.instructions = imgpro.instructions.concat(String.valueOf(imgpro.inst.get(i)));
            }
            Thread.sleep(250);
        }
        Thread.sleep(2500);
        robcom.write("DONE");
        imgpro.print(ip, port, x);
        System.exit(0);
    }
}