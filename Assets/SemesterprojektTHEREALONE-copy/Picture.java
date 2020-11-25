
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/******************************************************************************
 *  Compilation:  javac Picture.java
 *  Execution:    java Picture imagename
 *  Dependencies: none
 *
 *  Data type for manipulating individual pixels of an image. The original
 *  image can be read from a file in jpg, gif, or png format, or the
 *  user can create a blank image of a given size. Includes methods for
 *  displaying the image in a window on the screen or saving to a file.
 *
 *  % java Picture mandrill.jpg
 *
 *  Remarks
 *  -------
 *   - pixel (x, y) is column x and row y, where (0, 0) is upper left
 *
 *   - see also GrayPicture.java for a grayscale version
 *
 *   - should we add int getRGB(int x, int y) and settRGB(int x, int y, int argb)
 *     for performance (to avoid creating of Color objects when important)?
 *
 ******************************************************************************/
import java.awt.*;
import java.awt.Color;
import java.awt.FileDialog;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.KeyStroke;
import java.awt.Graphics2D;
import java.io.ByteArrayOutputStream;
import java.util.Arrays;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.ArrayList;
import java.io.FileWriter;
import java.io.IOException;

/**
 *  This class provides methods for manipulating individual pixels of
 *  an image. The original image can be read from a {@code .jpg}, {@code .gif},
 *  or {@code .png} file or the user can create a blank image of a given size.
 *  This class includes methods for displaying the image in a window on
 *  the screen or saving it to a file.
 *  <p>
 *  Pixel (<em>col</em>, <em>row</em>) is column <em>col</em> and row <em>row</em>.
 *  By default, the origin (0, 0) is the pixel in the top-left corner,
 *  which is a common convention in image processing.
 *  The method {@code setOriginLowerLeft()} change the origin to the lower left.
 *  <p>
 *  For additional documentation, see
 *  <a href="http://introcs.cs.princeton.edu/31datatype">Section 3.1</a> of
 *  <i>Computer Science: An Interdisciplinary Approach</i>
 *  by Robert Sedgewick and Kevin Wayne.
 *
 *  @author Robert Sedgewick
 *  @author Kevin Wayne
 */
public final class Picture implements ActionListener {
    private BufferedImage image;               // the rasterized image
    private JFrame frame;                      // on-screen view
    private String filename;                   // name of file
    private boolean isOriginUpperLeft = true;  // location of origin
    private final int width, height;
    private String hostname;
    private int port;
    private Socket connection;
    private PrintWriter out;// width and height
    int [][] bitArray;

    private String coordinates;
    private int i;
    ArrayList<String> messageArray = new ArrayList<String>();

    /**
     * Initializes a blank {@code width}-by-{@code height} picture, with {@code width} columns
     * and {@code height} rows, where each pixel is black.
     *
     * @param width the width of the picture
     * @param height the height of the picture
     * @throws IllegalArgumentException if {@code width} is negative
     * @throws IllegalArgumentException if {@code height} is negative
     */
    public Picture(int width, int height) {
        if (width  < 0) throw new IllegalArgumentException("width must be nonnegative");
        if (height < 0) throw new IllegalArgumentException("height must be nonnegative");
        this.width  = width;
        this.height = height;
        image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        // set to TYPE_INT_ARGB to support transparency
    }

    /**
     * Initializes a new picture that is a deep copy of the argument picture.
     *
     * @param  picture the picture to copy
     * @throws IllegalArgumentException if {@code picture} is {@code null}
     */
    public Picture(Picture picture) {
        if (picture == null) throw new IllegalArgumentException("constructor argument is null");

        width  = picture.width();
        height = picture.height();
        image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        filename = picture.filename;
        for (int col = 0; col < width(); col++)
            for (int row = 0; row < height(); row++)
                image.setRGB(col, row, picture.get(col, row).getRGB());
    }

    /**
     * Initializes a picture by reading from a file or URL.
     *
     * @param  filename the name of the file (.png, .gif, or .jpg) or URL.
     * @throws IllegalArgumentException if cannot read image
     * @throws IllegalArgumentException if {@code filename} is {@code null}
     */
    public Picture(String filename) {
        i = 0;
        coordinates = "";

        if (filename == null) throw new IllegalArgumentException("constructor argument is null");

        this.filename = filename;
        try {
            // try to read from file in working directory
            File file = new File(filename);
            if (file.isFile()) {
                image = ImageIO.read(file);
            }

            // now try to read from file in same directory as this .class file
            else {
                URL url = getClass().getResource(filename);
                if (url == null) {
                    url = new URL(filename);
                }
                image = ImageIO.read(url);
            }

            if (image == null) {
                throw new IllegalArgumentException("could not read image file: " + filename);
            }

            width  = image.getWidth(null);
            height = image.getHeight(null);
        }
        catch (IOException ioe) {
            throw new IllegalArgumentException("could not open image file: " + filename, ioe);
        }
    }

    /**
     * Initializes a picture by reading in a .png, .gif, or .jpg from a file.
     *
     * @param file the file
     * @throws IllegalArgumentException if cannot read image
     * @throws IllegalArgumentException if {@code file} is {@code null}
     */
    public Picture(File file) {
        if (file == null) throw new IllegalArgumentException("constructor argument is null");

        try {
            image = ImageIO.read(file);
        }
        catch (IOException ioe) {
            throw new IllegalArgumentException("could not open file: " + file, ioe);
        }
        if (image == null) {
            throw new IllegalArgumentException("could not read file: " + file);
        }
        width  = image.getWidth(null);
        height = image.getHeight(null);
        filename = file.getName();
    }

    /**
     * Returns a JLabel containing this picture, for embedding in a JPanel,
     * JFrame or other GUI widget.
     *
     * @return the {@code JLabel}
     */
    public JLabel getJLabel() {
        if (image == null) return null;         // no image available
        ImageIcon icon = new ImageIcon(image);
        return new JLabel(icon);
    }

    /**
     * Sets the origin to be the upper left pixel. This is the default.
     */
    public void setOriginUpperLeft() {
        isOriginUpperLeft = true;
    }

    /**
     * Sets the origin to be the lower left pixel.
     */
    public void setOriginLowerLeft() {
        isOriginUpperLeft = false;
    }

    /**
     * Displays the picture in a window on the screen.
     */
    public void show() {

        // create the GUI for viewing the image if needed
        if (frame == null) {
            frame = new JFrame();

            JMenuBar menuBar = new JMenuBar();
            JMenu menu = new JMenu("File");
            menuBar.add(menu);
            JMenuItem menuItem1 = new JMenuItem(" Save...   ");
            menuItem1.addActionListener(this);
            menuItem1.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_S,
                    Toolkit.getDefaultToolkit().getMenuShortcutKeyMask()));
            menu.add(menuItem1);
            frame.setJMenuBar(menuBar);

            frame.setContentPane(getJLabel());
            // f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
            if (filename == null) frame.setTitle(width + "-by-" + height);
            else                  frame.setTitle(filename);
            frame.setResizable(false);
            frame.pack();
            frame.setVisible(true);
        }

        // draw
        frame.repaint();
    }

    /**
     * Returns the height of the picture.
     *
     * @return the height of the picture (in pixels)
     */
    public int height() {
        return height;
    }

    /**
     * Returns the width of the picture.
     *
     * @return the width of the picture (in pixels)
     */
    public int width() {
        return width;
    }

    private void validateRowIndex(int row) {
        if (row < 0 || row >= height())
            throw new IllegalArgumentException("row index must be between 0 and " + (height() - 1) + ": " + row);
    }

    private void validateColumnIndex(int col) {
        if (col < 0 || col >= width())
            throw new IllegalArgumentException("column index must be between 0 and " + (width() - 1) + ": " + col);
    }

    /**
     * Returns the color of pixel ({@code col}, {@code row}) as a {@link java.awt.Color}.
     *
     * @param col the column index
     * @param row the row index
     * @return the color of pixel ({@code col}, {@code row})
     * @throws IllegalArgumentException unless both {@code 0 <= col < width} and {@code 0 <= row < height}
     */
    public Color get(int col, int row) {
        validateColumnIndex(col);
        validateRowIndex(row);
        int rgb = getRGB(col, row);
        return new Color(rgb);
    }

    /**
     * Returns the color of pixel ({@code col}, {@code row}) as an {@code int}.
     * Using this method can be more efficient than {@link #get()} because it does not
     * create a {@code Color} object.
     *
     * @param col the column index
     * @param row the row index
     * @return the integer representation of the color of pixel ({@code col}, {@code row})
     * @throws IllegalArgumentException unless both {@code 0 <= col < width} and {@code 0 <= row < height}
     */
    public int getRGB(int col, int row) {
        validateColumnIndex(col);
        validateRowIndex(row);
        if (isOriginUpperLeft) return image.getRGB(col, row);
        else                   return image.getRGB(col, height - row - 1);
    }

    /**
     * Sets the color of pixel ({@code col}, {@code row}) to given color.
     *
     * @param col the column index
     * @param row the row index
     * @param color the color
     * @throws IllegalArgumentException unless both {@code 0 <= col < width} and {@code 0 <= row < height}
     * @throws IllegalArgumentException if {@code color} is {@code null}
     */
    public void set(int col, int row, Color color) {
        validateColumnIndex(col);
        validateRowIndex(row);
        if (color == null) throw new IllegalArgumentException("color argument is null");
        int rgb = color.getRGB();
        setRGB(col, row, rgb);
    }

    /**
     * Sets the color of pixel ({@code col}, {@code row}) to given color.
     *
     * @param col the column index
     * @param row the row index
     * @param rgb the integer representation of the color
     * @throws IllegalArgumentException unless both {@code 0 <= col < width} and {@code 0 <= row < height}
     */
    public void setRGB(int col, int row, int rgb) {
        validateColumnIndex(col);
        validateRowIndex(row);
        if (isOriginUpperLeft) image.setRGB(col, row, rgb);
        else                   image.setRGB(col, height - row - 1, rgb);
    }

    /**
     * Returns true if this picture is equal to the argument picture.
     *
     * @param other the other picture
     * @return {@code true} if this picture is the same dimension as {@code other}
     *         and if all pixels have the same color; {@code false} otherwise
     */
    public boolean equals(Object other) {
        if (other == this) return true;
        if (other == null) return false;
        if (other.getClass() != this.getClass()) return false;
        Picture that = (Picture) other;
        if (this.width()  != that.width())  return false;
        if (this.height() != that.height()) return false;
        for (int col = 0; col < width(); col++)
            for (int row = 0; row < height(); row++)
                if (!this.get(col, row).equals(that.get(col, row))) return false;
        return true;
    }

    /**
     * This operation is not supported because pictures are mutable.
     *
     * @return does not return a value
     * @throws UnsupportedOperationException if called
     */
    public int hashCode() {
        throw new UnsupportedOperationException("hashCode() is not supported because pictures are mutable");
    }

    /**
     * Saves the picture to a file in a standard image format.
     * The filetype must be .png or .jpg.
     *
     * @param filename the name of the file
     * @throws IllegalArgumentException if {@code name} is {@code null}
     */
    public void save(String filename) {
        if (filename == null) throw new IllegalArgumentException("argument to save() is null");
        save(new File(filename));
    }

    /**
     * Saves the picture to a file in a PNG or JPEG image format.
     *
     * @param  file the file
     * @throws IllegalArgumentException if {@code file} is {@code null}
     */
    public void save(File file) {
        if (file == null) throw new IllegalArgumentException("argument to save() is null");
        filename = file.getName();
        if (frame != null) frame.setTitle(filename);
        String suffix = filename.substring(filename.lastIndexOf('.') + 1);
        if ("jpg".equalsIgnoreCase(suffix) || "png".equalsIgnoreCase(suffix)) {
            try {
                ImageIO.write(image, suffix, file);
            }
            catch (IOException e) {
                e.printStackTrace();
            }
        }
        else {
            System.out.println("Error: filename must end in .jpg or .png");
        }
    }

    /**
     * Opens a save dialog box when the user selects "Save As" from the menu.
     */
    @Override
    public void actionPerformed(ActionEvent e) {
        FileDialog chooser = new FileDialog(frame,
                "Use a .png or .jpg extension", FileDialog.SAVE);
        chooser.setVisible(true);
        if (chooser.getFile() != null) {
            save(chooser.getDirectory() + File.separator + chooser.getFile());
        }
    }

    public BufferedImage getImage()
    {
        return image;
    }

    public void setBlackAndWhiteAndCreateMessageArray()
    {
        for (int col = 0; col < width(); col++) {
            for ( int row = 0; row < height(); row++)
            {
                if (image.getRGB(col, row) <= -9000000) 
                // row < 10          
                {   if (col < 10 && row < 10){
                        coordinates = "000" + col + "," + "000" + row + ";";}
                    else if (col > 9 && col < 100  && row < 10){
                        coordinates = "00" + col + "," + "000" + row + ";";}
                    else if (col > 99 && col < 1000  && row < 10){
                        coordinates = "0" + col + "," + "000" + row + ";";}
                    else if (col > 999 && col < 10000  && row < 10){
                        coordinates = col + "," + "000" + row + ";";}
                    //  9 < row < 100 
                    else if (col < 10 && row < 100 && row > 9){
                        coordinates = "000" + col + "," + "00" + row + ";";}
                    else if (col > 9 && col < 100  && row < 100 && row > 9){
                        coordinates = "00" + col + "," + "00" + row + ";";}
                    else if (col > 99 && col < 1000  && row < 100 && row > 9){
                        coordinates = "0" + col + "," + "00" + row + ";";}
                    else if (col > 999 && col < 10000  && row < 100 && row > 9){
                        coordinates = col + "," + "00" + row + ";";}
                    // 99 < row < 1000 
                    else if (col < 10 && row < 1000 && row > 99){
                        coordinates = "000" + col + "," + "0" + row + ";";}
                    else if (col > 9 && col < 100  && row < 1000 && row > 99){
                        coordinates = "00" + col + "," + "0" + row + ";";}
                    else if (col > 99 && col < 1000  && row < 1000 && row > 99){
                        coordinates = "0" + col + "," + "0" + row + ";";}
                    else if (col > 999 && col < 10000  && row < 1000 && row > 99){
                        coordinates = col + "," + "0" + row + ";";}
                    // 999 < row < 10000
                    else if (col < 10 && row < 10000 && row > 999){
                        coordinates = "000" + col + "," + row + ";";}
                    else if (col > 9 && col < 100  && row < 10000 && row > 999){
                        coordinates = "00" + col + "," + row + ";";}
                    else if (col > 99 && col < 1000  && row < 10000 && row > 999){
                        coordinates = "0" + col + "," + row + ";";}
                    else if (col > 999 && col < 10000  && row < 10000 && row > 999){
                        coordinates = col + "," + row + ";";}
                    messageArray.add(coordinates);
                }
            }
        }   

    }

    public String readMessageArray(int h)
    {
        return messageArray.get(h);
    }

    public double faaRGB(int col, int row)
    {
        return image.getRGB(col, row);
    }

    public int getAntalSortePixels()
    {
        int j = 0;
        for (int col = 0; col < width(); col++) {
            for (int row = 0; row < height(); row++)
            {
                if (image.getRGB(col, row) <= -9000000)
                {
                    j++;
                }
            }
        }
        return j;
    }

    public void setBlackAndWhite()
    {
        for (int col = 0; col < width(); col++) {
            for (int row = 0; row < height(); row++)
            {
                if (image.getRGB(col, row) <= -9000000)
                {
                    image.setRGB(col, row, -14211289);
                }
                else{
                    image.setRGB(col, row, -1);
                }
            }
        }
    }

    public int getArrayStoerrelse()
    {
        return messageArray.size();
    }

    public static void main(String[] args) 
    throws InterruptedException {
        String message = "";
        int h = 0;
        int l = 0;
        //pikachu
        //Picture myPicture = new Picture("https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/c6d0dc42-b2fb-4bd8-80f3-d01694656992/d5772bp-46b2533e-ad76-4c1a-b510-3a62b722c9af.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOiIsImlzcyI6InVybjphcHA6Iiwib2JqIjpbW3sicGF0aCI6IlwvZlwvYzZkMGRjNDItYjJmYi00YmQ4LTgwZjMtZDAxNjk0NjU2OTkyXC9kNTc3MmJwLTQ2YjI1MzNlLWFkNzYtNGMxYS1iNTEwLTNhNjJiNzIyYzlhZi5wbmcifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6ZmlsZS5kb3dubG9hZCJdfQ.M4W0b06G47P0lXA5ZQU1nbPr-2n1blhjOxyzwMXtB-g");
        
        //biohazard symbol
        Picture myPicture = new Picture("https://images-na.ssl-images-amazon.com/images/I/51jz6UaDgrL._AC_.jpg");
        
        
        myPicture.setOriginUpperLeft();
        myPicture.setBlackAndWhiteAndCreateMessageArray();

        RobotClient myClient = new RobotClient("192.168.0.20",9500);
        myClient.connect(); 
        myPicture.setBlackAndWhite();
        myPicture.show();
        Thread.sleep(5000);
        while (myPicture.readMessageArray(l) != null)
        {for(int k = h; k < h + 10; k++)
            {  message = message + myPicture.readMessageArray(k); 
                l = k + 1;
            }            
            myClient.write(message);
            message = "";
            h += 10;
            Thread.sleep(40);
        }

    }
}
