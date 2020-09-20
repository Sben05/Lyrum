# Lyrum

[![Demo Video]](https://youtu.be/wG-q0WTAf34 "Demo Project")

## Cloning Instructions 
*XCode 11 is required to clone project*
1) Press green "code" button on main github screen
2) Copy web address
3) Open XCode
4) Press "Clone an existing project"
5) Paste from clipboard
6) Hit Clone
7) *Note: GPS Capibilites require another device to transmit location to iPhone, this can be done using a variety of ways*

## Demo
https://www.youtube.com/watch?v=wG-q0WTAf34&feature=youtu.be

## Inspiration
Distracted driving is the biggest contributor to car accidents, a problem that affects over 60 million people annually. By addressing distracted driving, we will save billions of dollars, countless hours of time, and thousands of lives.

## About The Developers
Both Shreeniket and Agnik are 14 year old high school students with a passion for CS.

## What It Does
Our app, DriveSafe, alerts drivers if they are practicing bad driving habits, like reaching backseat, drinking, operating the radio, etc. For best use, the phone should be attached to the car's ventilator using a car vent phone holder. Whenever a driver is doing something unsafe, the app alarts them through a text-to-speech. Our app also has a quiz feature that drivers can take before getting in the car to make sure they're fully sober and not distracted.

## How We Built It
We used PyTorch and [this dataset from Kaggle](https://www.kaggle.com/c/state-farm-distracted-driver-detection]) in order to train a neural network to accurately predict over 10 cases of unsafe driving. Our model achived a 92% valiation over 22,000 images using a pretrained ResNet50 model. We then created an iOS app using Swift and XCode and deployed the model so that it detects these behaviors, which is then articulated by a virtual assistant. This was achieved in real-time by passing every frame of a live video as an image into our neural network. We created the quiz and AR features of the app using Swift and XCode as well. We used echoAR to build the AR portion of our app, in order to aid users 

## Challenges We Ran Into
Importing the PyTorch model into the format XCode requires was the most difficult and time-consuming part of the project, due to the poor documentation and lack of online resources.

## Accomplishments That We're Proud Of
We're proud of finishing such a complex project in such a short amount of time and hopefully making an impact on the millions of people affected by automobile accidents.

## What We Learned
We learned how to export Tensorflow models to XCode and implement VR tools in iOS apps.

## What's Next For DriveSafe
Hopefully larger distracted driving datasets will be created, so we can retrain our model and classify a wider variety of bad driving habits. We also plan on improving the user interface to make it more aesthetically pleasing for our users.

## Note
The repository was created 1 week ago, however the project itself was made starting Saturday. 
