# vaudience

Video Livestream

ABOUT THIS PROJECT:
This project is a frontend development of a video stream with instant chat posting on the UI. This project is development with Flutter and developed for portriat and landscape.
Below is the screenshot of the final look of this project:

![20220323_120747](https://user-images.githubusercontent.com/39952685/159652638-18cc5ad2-d64a-4e94-87b2-bb9f3d7ab70e.gif)


![Screenshot_20220323-113000](https://user-images.githubusercontent.com/39952685/159647224-ba779cf1-710f-471f-8b34-dd44634d4002.jpg)
![Screenshot_20220323-113013](https://user-images.githubusercontent.com/39952685/159647227-1a6ba8f3-305b-44aa-b174-fc816b117eff.jpg)
![Screenshot_20220323-112904](https://user-images.githubusercontent.com/39952685/159647233-910dd3d5-3899-4ba5-9413-65fac24d1f4a.jpg)
![Screenshot_20220323-113052](https://user-images.githubusercontent.com/39952685/159647236-11427048-078e-4616-b481-6a104cea5dbd.jpg)
![Screenshot_20220323-113037](https://user-images.githubusercontent.com/39952685/159647238-512a3906-7a4e-485d-a330-337197febc94.jpg)


Inside liveStream.dart I have video called at the initial state of launching the app, appbar with logo of the application. In the app body is an if statement that check the orientation of device which is portrait and landscape format. When the app is in portrait format it display the autoplay video with play and pause button to control the video. Below this video is the title of the video, list of comment, shuffle button and add comment form.

User can scroll through the list of comment, also user can add comments onclick of the text input the textfield focus showing the the keypad and add comment on top of the keypad with send button and Emoji icon. On input of value into textfield and click on send button it automatically add thhe value to the list of comment and if the textfield is empty and thhe send button is click a message to fill all field pop-up.

All feature is developed to response to device orientation for both landscape and portrait.
