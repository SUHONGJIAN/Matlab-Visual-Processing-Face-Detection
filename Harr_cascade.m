cd '...'
% Create a cascade detector object.
faceDetector = vision.CascadeObjectDetector();
%Read an movie
mov = VideoReader('talking.avi');

for k=1 : 1 : mov.NumberOfFrames
    I = read(mov,k);
    I=im2double(I);
    bbox = step(faceDetector, I);
    % Draw the returned bounding box around the detected face.
    boxInserter = vision.ShapeInserter('BorderColor','Custom', 'CustomBorderColor',[255 255 0]);
    J = step(boxInserter, I,bbox);
    figure(1), 
    imshow(J), title('Detected face');
end