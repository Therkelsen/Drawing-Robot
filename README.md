# Drawing Robot
<p align="center"> <img src="Java/Assets/SDU_BLACK_RGB.png" alt="SDU" title="SDU" width="80%" height="80%"/> </p>
<br>

# dRobTek Group 8 - Semester project 1
<br>

<img src="Java/Assets/timelapse.gif" alt="Drawing Robot GIF" width="800"/>
<br>

## Introduction
<div style="text-align: justify">The fourth industrial revolution, as many in our time choose to describe it, is a constant development, and it observes how several of the industry's as well as everyday processes are automated. One of the many benefits of automation is, of course, by eliminating the errors that man predicted the manual process. With this in mind, robots are now being designed and built for all sorts of different purposes. Even a task as simple as drawing a drawing can be automated to avoid the most important errors and thus create a precise reproduction of a given motif. This is exactly what the following report is about; As a part the robotics technology engineering bachelor education, the first semester project is about programming a 3-axis drawing robot that can scan any digital image, analyze each pixel, and reproduce the image in pencil on paper. In the first part of the report, first describe the physical elements of the robot, and in addition the 3 sub-elements of the software - the Java, socket and PLC programs - which are relevant to understand in connection with the robot's function. This is followed by a system test, where the drawing robot is tested, and finally a summary conclusion and discussion, which collects the report's most important points and results, advantages / disadvantages, and suggestions for how individual elements or problems could be optimized.
</div> 
<br>

## Abstract
<div style="text-align: justify">
First of all, [this report](https://www.youtube.com/watch?v=dQw4w9WgXcQ&ab_channel=RickAstleyVEVO) will introduce the theory behind creating and understanding a 3-axis drawing robot. Second of all it will additionally be shown how one might program a PLC to draw pictures processed and instructionalized from a Java program through a socket using TCP/IP. 
Furthermore, grayscaling will be introduced as the main way of taking an image and turn it into coordinates which the PLC can then convert into an asthoningly BREATHTAKING drawing, using a pencil and some paper.
  
In the Java part, Java as a language and the basic knowledge around it, is described, thereafter going into detail about the different needs and requirements the project has for Java during the course.
The TCP/IP part describes the communication between the different machines on an internet and how it was achieved. PLC as well as Structured Text will afterwards be introduced and explained, especially how they were a key part in the final solution of the project.

The report also contains a chapter on logical gates how they work, what they are, and how to utilize a statemachine to reach the final product.
At last it will be discussed how this solution to the problem could have been improved and the thoughts behind some of the choices made, with a conclusion of the project course, at the end of the report.
</div>

