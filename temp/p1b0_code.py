import numpy as np
import cv2
import os
from os import path, getcwd, chdir
import glob
import matplotlib.pyplot as plt
import scipy.io

cap = cv2.VideoCapture('L1_clip1_12s.mp4')

script_dir = os.path.dirname(__file__)

Lcol = np.array([30,30,225])
Ucol = np.array([0,0,255])

fourcc = cv2.VideoWriter_fourcc(*'X264')

out = cv2.VideoWriter('1b1_output.mp4',fourcc, 60.0, (int(cap.get(3)),int(cap.get(4))),isColor=1)
p =0
while(cap.isOpened()):
    ret, frame = cap.read()
    height1, width1 = frame.shape[:2]
    p+=1
    frame_data = np.asarray(frame)
    # Below are the coordinates in which i am searching for red block
    # This feels like i am fixing, i am just doing this here to reduce my unnecesary computation
    # Please, feel free to traverse entire image you get the same result
    # (note: make sure that your working are doesnt cover the top area saying "HIGH SCORE" as it is in red it also gets converted to orange)
    for i in range(263,292,1):
        for j in range(35,800,1):
            if frame_data[i][j][2]>190:
                frame[i,j,1]=156
                frame[i,j,2]=241
                frame[i,j,0] = 6
    cv2.imshow("Do U see line",frame)
    out.write(frame)
    if cv2.waitKey(10) & 0xFF == ord('q'):
        break



cap.release()
out.release()
cv2.destroyAllWindows()