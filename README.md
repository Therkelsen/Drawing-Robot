# Drawing Robot
<p align="center"> <img src="Java/Assets/SDU_BLACK_RGB.png" alt="SDU" title="SDU" width="80%" height="80%"/> </p>
<br>

# dRobTek Group 8 - Semester project 1
<br>

<img src="Java/Assets/timelapse.gif" alt="Drawing Robot GIF" width="800"/>
<br>

## Introduction
<div style="text-align: justify">The fourth industrial revolution, as many in our time choose to describe it, is a constant development, and it observes how several of the industry's as well as everyday processes are automated. One of the many benefits of automation is obviously to eliminating the errors that happens in the manual process with an ordinary human worker. With this in mind, robots are now being designed and built for all sorts of different purposes. Even a task as simple as drawing can be automated to avoid the biggest errors and thus create a precise physical recreation of a given digital image. This is exactly what the following report is about; As a part of the robotics technology engineering bachelor education, the first semester project is about programming a 3-axis drawing robot that can scan any digital image, analyze each pixel, and reproduce the image with a pencil on paper. In the first part of the report, the physical elements of the robot are described, in addition the 3 sub-elements of the software - the Java, socket and PLC programs - which are relevant to understand as well as the functions of the robot. This is followed by a system test, where the drawing robot is tested, and finally a summarizing conclusion and discussion: which collects the report's most important points and results, advantages / disadvantages, and suggestions for how individual elements or problems could be optimized.
</div> 
<br>

## Abstract
<div style="text-align: justify">
First of all, <a href="https://www.youtube.com/watch?v=dQw4w9WgXcQ&ab_channel=RickAstleyVEVO">this report</a> will introduce the theory behind creating and understanding a 3-axis drawing robot. Additionally, it will be shown how one might program a PLC to draw pictures processed and instructionalized from a Java program through a socket using TCP/IP. Furthermore, grayscaling will be introduced as the main way of taking an image and turning it into coordinate instructions, which the PLC can then convert into an astonishing and BREATHTAKING drawing, using a pencil and some paper. In the Java part, Java as a language and the basic knowledge around it, is described, thereafter goes into detail about the different needs and requirements the project has for Java during the course. The TCP/IP part describes the communication between the different machines on an internet, and how it was achieved. PLC, as well as Structured Text will afterwards be introduced and explained, especially how they were a key part in the final solution of the project. The report also contains a chapter on logical gates, how they work, what they are, and how to utilize a statemachine to reach the final product. At last it will be discussed how this solution to the problem could have been improved and the thoughts behind some of the choices made, with a conclusion of the project course, at the end of the report.
</div>
<br>

## Conclusion
<div style="text-align: justify">
The socket and TCP/IP communication has proven to be crucial for the function of the robot, as this element is vital for the robot's ability to draw the physical copy of the digital image. The PLC part and the Java part are also extremely essential, but these were found to be more optimization-friendly in the sense that improvements or changes could be implemented, from which, the Java pixel analysis and the quality of the drawing, for example, could be achieved. Despite various challenges, such as the choice of the method of drawing, obstacles such as limitation of the PLC's memory and communication between Java and PLC, the drawing robot has been successfully brought to life through programming. Using Java, it became possible to upload and load information from a digital image and with image processing using pixel analysis and grayscale. Then, x, y, z coordinate sets are further utilized by the drawing robot to draw the final physical image. Finally, it can finally be concluded that with this project, a method that is - while unoptimal - then at least functional and usable, has been successfully developed for processing and converting a digital image into a physical drawing based on programming a 3-axis CNC-type robot.
</div>

