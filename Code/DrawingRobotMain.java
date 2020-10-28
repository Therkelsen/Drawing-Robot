
package dk.sdu.mmmi.rd1.edgedetect;

import DrawingRobot;

public class DrawingRobotMain {
    public static void main(String[] args) {
        
        System.out.println("====================");
        System.out.println("Starting program");
        
        // * For every column in every row, where every other row iterates backwards

        for (int row = 0; row < DrawingRobot.image.height(); row++) {
            if (row % 2 != 0) {
<<<<<<< Updated upstream
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
=======
                for (int col = 0; col < DrawingRobot.image.width(); col++) {
                    DrawingRobot.processImage(col, row);
                }
            } else {
                for (int col = DrawingRobot.image.width()-1; col >= 0; col--) {
                    DrawingRobot.processImage(col, row);
>>>>>>> Stashed changes
                }
            }
        }

        DrawingRobot.print();
    }
}