# Brick-Breaker-OpenCV
openCV operations on the classic 1986 – Arkanoid Series brick breaker game, to track the ball and perform few interesting operations.

## Code Requirements
* Numpy - 1.13.3
* OpenCV - 3.2.0

## Converting color input to Black and White
<p float="left">
  <img src="/images/2waqvd.gif" width="400" />
  <img src="/images/2warmd.gif" width="400" />
</p>

## Let us convert all the red color bricks to orange
<p float="left">
  <img src="/images/2watfb.gif" width="400" />
  <img src="/images/2watgj.gif" width="400" />
</p>


## Now lets do something cool ! changes the color of the ball to red, and also continuously draws the trajectory of the ball
1. Long story short, First i tried to solve this problem in MATLAB!
<img src="https://media.giphy.com/media/Pn1gZzAY38kbm/giphy.gif">
Yes, I have realized how bad the idea of video processing in MATLAB was but i had spent a lot of time and then found the centroid location of the ball and then saved it into a .mat file; then decided i will from now work on python.
2. Imported the centroid data to python using "scipy.io.loadmat()" and then to change the color of the ball to red i have drawn red circle at the centroid location using "cv2.circle()" and then for trajectory i was using the previous centroid locations, then formed like a diminishing history line plotting.

* I have placed the centroid data in "centroid_data"

### Batch 1
<p float="left">
  <img src="/images/2watyg.gif" width="400" />
  <img src="/images/2watza.gif" width="400" />
</p>

### Batch 2
<p float="left">
  <img src="/images/2wav75.gif" width="400" />
  <img src="/images/2wav83.gif" width="400" />
</p>
