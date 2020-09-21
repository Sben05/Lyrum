# Lyrum

## Intro
*Discover music. Share music.* Lyrum is a platform for discovering new music and sharing new music. Click the photo below for a promo video :).

[![Demo Video](https://img.youtube.com/vi/wG-q0WTAf34/0.jpg)](https://www.youtube.com/watch?v=wG-q0WTAf34)

## The Developers and Contact
**Feel free to email any of the developers or the contact email below for questions, comments, or just to share something! Also email the official lyrum contact email to recieve updates about our app :)**

Lyrum email for updates: *contact.lyrum@gmail.com*

Shreeniket Bendre - High School 10th grader -- Aspiring Computer Science(*shreeniketbendre@outlook.com*)

Josh Arnold - UC Davis -- Computer Science (*jarnold@ucdavis.edu*)

Rahul Parthasarathy - Singapore University of Technology and Design -- Computer Science (*rahul_parthasarathy@mymail.sutd.edu.sg*)

Justin Conklin - University of Vermont -- Computer Science (*justin.conk12@gmail.com*)

## Cloning Instructions 
*XCode 11 and CocoaPods are required to clone project*
1) Press green "code" button on main github screen
2) Copy web address
3) Open XCode
4) Press "Clone an existing project"
5) Paste from clipboard
6) Hit Clone
7) Open terminal
8) CD into workspace
9) Run following commands:

   $ pod install
   
   $ open lyrum.xcworkspace
10) You are ready!
11) *Note, depending on you swift verion, you may need to alter the AppDelegate.swift file to include @UIApplicationMain at the top
   
## The Project
Sharing and finding new music can be hard, so 14 year old Shreeniket Bendre, and College Students Josh Arnold, Rahul Parthasarathy, and Justin Conklin created a new social media platform to solve this problem with a single click. Lyrum is a next-generation music platform that helps you discover and share music. With Lyrum, you can keep tabs on all the music your friends are listening to, coupled with the ability to comment about various songs and artists.

## What It Does
We have integrated the Spotify API to seamlessly visualize your Spotify, as well as play songs in-app. Our backend is secure with only server-side authorization so you will never have to worry about your precious data. A rich and appealing user interface, combined with the smoothness of the iOS platform ensures that Lyrum becomes the go-to place to connect with others about the music you love. 

**Features:** 
1) View your complete Spotify profile, visualized immaculately 
2) Search and favorite new tracks 
3) Play Music on the Lyrum app 
4) Comment and have discussions about music posts (like a feed) 
5) Secure authentication and authorization 
6) Ability to browse posts with "hot" and "new" search columns

## How We Built It
For the front end side, we used Cocoapods (Apple framework) to install SDK's for UI Elements. We also extensively used Alamofire, which is a tool to simplify HTTP Push, Pull, Get, and Put requests to servers/api's.


On the backend side of things, we had 3 different sources. 

First, we used **Spotify Web API** to get songs, user profiles, authentication, preferences, followers, and search functions. We used a custom made JSON parsing technique (NSArray converted to NSDictionary) to retrive the data. We essentially made our own SDK, as we found that current techniques were not effective.

Second we used an AWS server to actually play the songs and make user posts, as well as carry out user song reccomendations. The server was built using the Node.js framework.

Finally we used Parse, an open source Swift backend to control the comment and likes features of the app.

## Challenges We Ran Into
The biggest challenge was creating our own technique to parse JSON data from spotify. The poor documentation for the mobile SDK drove us to use the Web API, and using a specialized technique to retrive the data.

## Accomplishments That We're Proud Of
We're proud of creating a platform to connect people better, as well as accomplish our goal of spreading the love of music. We were also proud of making an app which had all the functionality we had hoped for.

## What We Learned
We learned how Parse JSON data using a new techniquqe, how to authenticate users, how to play songs in app, how to make comments and posts, and much more!

## What's Next For Lyrum
We hope to release on the app store very soon, as well as implement more features for posting. We also want to add a way to follow more easily in our app.
