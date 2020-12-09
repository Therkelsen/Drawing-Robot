# Drawing Robot
<p align="center"> <img src="Java/Assets/SDU_BLACK_RGB.png" alt="SDU" title="SDU" width="80%" height="80%"/> </p>
<br>

# dRobTek Group 8 - Semester project 1
<br>

<img src="Java/Assets/drawingrobot.gif" alt="Drawing Robot GIF" width="800"/>
<br>

## Introduction
<div style="text-align: justify">
The fourth industrial revolution, as many in our time choose to call it, is constant development, and it is observed how several of the industry's as well as everyday processes are automated. One of the many advantages of automation is of course that the mistakes that humans make by the manual process, is eliminated. With this in mind, nurobots are designed and built for all sorts of different purposes. Even a task as simple as drawing a drawing can be automated to avoid the most important errors and thus create an accurate reproduction of a given motive.
  
This is exactly what the following report deals with: Programming a 3-axis drawing robot , which can scan any digital image, analyze each pixel, and reproduce the image in pencil on paper. The first part of the report describes first and foremost the physical elements of the robot, and in addition the software's 3 sub-elements - the java, socket and PLC programs - which are relevant to understand in connection with the robot's function. and finally a summary conclusion and discussion, which summarizes the report's most important points and results, advantages / disadvantages, and suggestions for how individual elements or problems could be optimized.
</div> 
<br>

## Resources
<div style="text-align: justify">
The resources available from the beginning is a pre-built 3-axis CNC style robot, equipped with 3 NEMA step-motors, as well as a soft-leaded pencil and an electronic pencil sharpener, all controlled using a X20CP1382 Programmable Logic Controller, connected to three ST330-V3 driver boards to establish a connection between the PLC and the step-motors. 
Other than that, four pre-programmed Java classes are made available to every group, three of which are used for image- and pixel manipulation, and the last is used for communicating through a socket connection.
</div>

