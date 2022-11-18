import cv2

image_path = r'C:\Users\user\Pictures\400Z.jpg'

#Read
image2 = cv2.imread(image_path,1)


#directory2 = r'C:\Users\Fatihi\Pictures'
#filename = 'SavedImage.png'
directory = r'C:\Users\Fatihi\Pictures\saved.png'

#Save Image
cv2.imwrite(directory,image2)
print('Saved')

#Resolution/Channels
print(image2.shape)

#Show
cv2.imshow('Original', image2)
cv2.waitKey(0)
cv2.destroyAllWindows()


#Grey Color
gray = cv2.cvtColor(image2, cv2.COLOR_BGR2GRAY)
#cv2.cvtColor(image2, cv2.COLOR_GRAY2RGB)
cv2.imshow('Gray Image', gray)
cv2.waitKey(0)

#Resize
resize = cv2.resize(image2,(777,777))
cv2.imshow('Resized', resize)
cv2.waitKey(0)

#Text
text = "50,50"
coordinates=(50,50)
font = cv2.FONT_HERSHEY_SIMPLEX
fontScale=1
color=(0,255,9)
thickness=2
image3=cv2.putText(image2, text, coordinates, font, fontScale, color, thickness)
cv2.imshow('text', image3)
cv2.waitKey(0)

#Line
start_point=(0,0)
end_point=(55,55)
image4=cv2.line(image3,start_point,end_point,color,thickness)
cv2.imshow('line',image4)
cv2.waitKey(0)

#Circle
center_coordinates = (166,200)
radius = 30
image5 = cv2.circle(image4, center_coordinates, radius, color, thickness)
cv2.imshow('Circle', image5)
cv2.waitKey(0)

#Rectangle
# cv2.rectangle(image,(1,1),(1,1),(0,0,1),4)
start_p_rectangle = (200,300)
end_p_rectangle = (500,800)
image6 = cv2.rectangle(image5, start_p_rectangle, end_p_rectangle, color, thickness)
cv2.imshow('RECTANGLE', image6)
cv2.waitKey(0)

#Ellipse
center_coordinates_Ellipse = (300,699)
axeslength=(100,50)
angle = 40
start_angle = 0
end_angle = 360
color_ellipse = (23,43,173)
image7 = cv2.ellipse(image2,center_coordinates_Ellipse,axeslength,angle, start_angle,end_angle,color_ellipse,thickness)
cv2.imshow('Ellipse', image7)
cv2.waitKey(0)


###################VIDEO CAPTURE####################
abc = cv2.VideoCapture(0)
while (True):
	ret, frame = abc.read()
	cv2.imshow("abc", frame)
	if cv2.waitKey(1) & 0xFF == ord('a'):
		break
		abc.release()
cv2.destroyAllWindows()

############

cap = cv2.VideoCapture(0)

if(cap.isOpened() == False):
    print("Camera could not open")
    
frame_width = int(cap.get(3))
frame_height = int(cap.get(4))

#Video coded ... encoders and decoders

video_cod = cv2.VideoWriter_fourcc(*'XVID')
video_output= cv2.VideoWriter('Captured_video.MP4', video_cod, 30, (frame_width, frame_height))

while (True):
    ret, frame = cap.read()
    
    if ret == True:
        video_output.write(frame)
        cv2.imshow('frame', frame)
        if cv2.waitKey(1) & 0xFF == ord('a'):
            break
    else:
        break

cap.release()
video_output.release()
cv2.destroyAllWindows()
print("The video was saved successfully")

#######################

cap = cv2.VideoCapture("Captured_video.MP4")

while (True):
    ret, frame = cap.read()
    cv2.imshow('frame', frame)
    if cv2.waitKey(1) & 0xFF == ord('a'):
        break
cap.release()
cv2.destroyAllWindows()


