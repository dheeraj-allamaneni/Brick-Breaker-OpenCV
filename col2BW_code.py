import numpy as np
import cv2

cap = cv2.VideoCapture('L1_clip1_12s.m4v')

fourcc = cv2.VideoWriter_fourcc(*'X264')
out = cv2.VideoWriter('colToBW_output1.mp4',fourcc, 60.0, (int(cap.get(3)),int(cap.get(4))),isColor=1)


while(cap.isOpened()):
    ret, frame = cap.read()
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    out.write(gray)
    # cv2.imshow('Original',frame)
    cv2.imshow('frame',gray)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break
 
cap.release()
out.release()
cv2.destroyAllWindows()