import cv2 as cv
def recCountour(coutours):
    rectCon = []
    for i in coutours:
        area = cv.contourArea(i)
        if area > 50:
            peri = cv.arcLength(i,True)
            approx = cv.approxPolyDP(i,0.02*peri,True)
            if len(approx) == 16:
                rectCon.append(i)
    rectCon = sorted(rectCon,key=cv.contourArea,reverse=True)
    return rectCon

def getCornerPoints(cont):
        peri = cv.arcLength(cont,True)
        approx = cv.approxPolyDP(cont,0.02*peri,True)
        return approx