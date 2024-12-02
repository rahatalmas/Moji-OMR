import cv2 as cv
import util

height = 700
width = 500

img = cv.imread("omr.jpg")

img = cv.resize(img,(width,height))
imgContours = img.copy()
imgBigContours = img.copy()
imgGray = cv.cvtColor(img,cv.COLOR_BGR2GRAY)
imgBlur = cv.GaussianBlur(imgGray,(5,5),0.1)
imgCanny = cv.Canny(imgBlur,25,150)

contours, hierarchy = cv.findContours(imgCanny,cv.RETR_EXTERNAL,cv.CHAIN_APPROX_NONE)
cv.drawContours(imgContours,contours,-1,(0,255,0),1)
rectCons = util.recCountour(contours)
biggestcontor = util.getCornerPoints(rectCons[0])
print(biggestcontor)

cv.drawContours(imgBigContours,biggestcontor,-1,(0,255,0),2)

cv.imshow("original image: ",imgBigContours)
cv.waitKey(0)
cv.destroyAllWindows()
