import cv2 as cv
def recCountour(coutours):
    rectCon = []
    for i in coutours:
        area = cv.contourArea(i)
        print(area)
        #if area > 100:
        peri = cv.arcLength(i,True)
        approx = cv.approxPolyDP(i,0.1*peri,True)
        print(len(approx))
        rectCon.append(i)
    rectCon = sorted(rectCon,key=cv.contourArea,reverse=True)
    return rectCon

def getCornerPoints(cont):
        peri = cv.arcLength(cont,True)
        approx = cv.approxPolyDP(cont,0.1*peri,True)
        return approx