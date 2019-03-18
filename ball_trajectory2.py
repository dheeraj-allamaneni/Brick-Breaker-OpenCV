import numpy as np
import cv2
import os
from os import path, getcwd, chdir
import glob
import matplotlib.pyplot as plt
import scipy.io

cap = cv2.VideoCapture('L5_clip1_15s.mp4')

script_dir = os.path.dirname(__file__)
mat = scipy.io.loadmat('centr.mat')
new_data = mat['whiteBlob_matrix']
fourcc = cv2.VideoWriter_fourcc(*'X264')
out = cv2.VideoWriter('1c_output.mp4',fourcc, 60.0, (int(cap.get(3)),int(cap.get(4))),isColor=1)
p = 0
f=0
while(cap.isOpened()):
    ret, frame = cap.read()
    for g in range(0,20,1):
        if(p > 50 and p<=85):
            cv2.line(frame,(int(new_data[p-g-25,0]),int(new_data[p-g-25,1])),(int(new_data[p-g,0]),int(new_data[p-g,1])),(255,255,255),3)
            cv2.line(frame,(int(new_data[p-g-48,0]),int(new_data[p-g-48,1])),(int(new_data[p-g-25,0]),int(new_data[p-g-25,1])),(255,255,255),3)
        if(p > 85):
            cv2.line(frame,(int(new_data[p-g-25,0]),int(new_data[p-g-25,1])),(int(new_data[p-g,0]),int(new_data[p-g,1])),(255,255,255),3)
            cv2.line(frame,(int(new_data[p-g-40,0]),int(new_data[p-g-40,1])),(int(new_data[p-g-25,0]),int(new_data[p-g-25,1])),(255,255,255),3)
            cv2.line(frame,(int(new_data[p-g-83,0]),int(new_data[p-g-83,1])),(int(new_data[p-g-39,0]),int(new_data[p-g-39,1])),(255,255,255),3)
    cv2.circle(frame,(int(new_data[p,0]),int(new_data[p,1])), 9, (0,0,255), -1)
    p+=1
    cv2.imshow("Do U see line",frame)
    out.write(frame)
    if cv2.waitKey(10) & 0xFF == ord('q'):
        break



cap.release()
out.release()
cv2.destroyAllWindows()