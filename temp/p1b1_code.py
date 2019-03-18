import numpy as np
import cv2
import os
from os import path, getcwd, chdir
import glob
import matplotlib.pyplot as plt
import scipy.io

cap = cv2.VideoCapture('L2_clip2_16s.mp4')

script_dir = os.path.dirname(__file__)

Lcol = np.array([30,30,225])
Ucol = np.array([0,0,255])
fourcc = cv2.VideoWriter_fourcc(*'X264')

# #print(cap.get(5))
out = cv2.VideoWriter('1b2_output.mp4',fourcc, 60.0, (int(cap.get(3)),int(cap.get(4))),isColor=1)
p =0
while(cap.isOpened()):
    ret, frame = cap.read()
    height1, width1 = frame.shape[:2]
    # cv2.imshow("Yeah new frame",frame)
    p+=1
    frame_data = np.asarray(frame)

    # for i in range(265,286,1):
    #     for j in range(35,800,1):
    #         print(frame_data[i][j])
    # for k in range(width1):
    #     frame[350,k] = 255
    #     frame[530,k] = 255
    # for t in range(height1):
    #     frame[t,267] = 255
    #     frame[t,334] = 255

    # for k in range(width1):
    #     frame[350,k] = 255
    #     frame[530,k] = 255
    # for t in range(height1):
    #     frame[t,120] = 255
    #     frame[t,145] = 255

    # for i in range(350,530,1):
    #     for j in range(120,145,1):
    #         print(frame_data[i][j])

    for i in range(350,530,1):
        for j in range(267,334,1):
            if frame_data[i][j][2]>190:
                frame[i,j,1]=136
                frame[i,j,2]=255
                frame[i,j,0] = 60


    # for k in range(width1):
    #     frame[380,k] = 255
    #     frame[230,k] = 255
    # for t in range(height1):
    #     frame[t,35] = 255
    #     frame[t,800] = 255
    # for q in range(230,380,1):
    #     for s in range(35,800,1):
    #         if frame[q,s,0] >= 0 and frame[q,s,0] <=200 and frame[q,s,1] >= 0 and frame[q,s,1] <= 200 and frame[q,s,2] >= 150 and frame[q,s,2] >= 255:
    #             frame[q,s,0] = 0
    #             frame[q,s,1] = 0
    #             frame[q,s,1] = 0

    # if p == 100:
    #     cv2.imwrite("Frame_print_2.jpg", frame)
    cv2.imshow("Do U see line",frame)
    out.write(frame)
    if cv2.waitKey(10) & 0xFF == ord('q'):
        break



cap.release()
out.release()
cv2.destroyAllWindows()