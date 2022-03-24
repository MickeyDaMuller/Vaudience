# vaudience

Video Livestream

ABOUT THIS PROJECT:
This project is a frontend development of a video stream with instant chat posting on the UI. This project is development with Flutter and developed for portriat and landscape.
Below is the screenshot of the final look of this project:

![20220324_141818](https://user-images.githubusercontent.com/39952685/159895174-f51c73a8-265e-4b94-ae90-20f042afec78.gif)

![ezgif com-gif-maker](https://user-images.githubusercontent.com/39952685/159899435-cdbd1c37-fcaf-40ab-8b37-3511c4df4f4b.gif)


![Screenshot_20220324-142758](https://user-images.githubusercontent.com/39952685/159897371-38810f5e-84ec-4d5d-ba35-6e35e7a15dd2.jpg)
![Screenshot_20220324-142807](https://user-images.githubusercontent.com/39952685/159897389-44cf5536-d4d5-4f57-ae5a-64483292a43e.jpg)
![Screenshot_20220324-142814](https://user-images.githubusercontent.com/39952685/159897391-8669722d-b4e0-4296-93b9-37bace13517a.jpg)
![Screenshot_20220324-142822](https://user-images.githubusercontent.com/39952685/159897400-09718fe8-26d2-4893-b9ca-cc67016dd1c9.jpg)
![Screenshot_20220324-142843](https://user-images.githubusercontent.com/39952685/159897404-fbf30be1-b801-4170-a6b4-de2a3a987bb9.jpg)
![Screenshot_20220324-142851](https://user-images.githubusercontent.com/39952685/159897407-05402987-fb63-4755-ac18-3e6e86e491b8.jpg)

Inside liveStream.dart I have video called at the initial state of launching the app, appbar with logo of the application. In the app body is an if statement that check the orientation of device which is portrait and landscape format. When the app is in portrait format it display the autoplay video with play and pause button to control the video. Below this video is the title of the video, list of comment, shuffle button and add comment form.

User can scroll through the list of comment, also user can add comments onclick of the text input the textfield focus showing the the keypad and add comment on top of the keypad with send button and Emoji icon. On input of value into textfield and click on send button it automatically add thhe value to the list of comment and if the textfield is empty and thhe send button is click a message to fill all field pop-up.

All feature is developed to response to device orientation for both landscape and portrait.


Below I declared data, videoplayer, texteditorcontroller, bool for showchat for landscape and emoji.

``` 
List data = [];
late VideoPlayerController _controller;
late Future<void> _initializeVideoPlayerFuture;
TextEditingController _controllerComment = TextEditingController();
bool showChat = false;
bool isShowSticker = false; 

```

Inside my class state I set the initial state

```
  @override
  void initState() {
    super.initState();
    
    //set emoji bool to false
    isShowSticker = false;
    
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
    
    // auto playing the video
    _controller.play();
  }

```

Created a future to handle when backbutton is click withh emoji displayed:

```

 Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }


```

Handling videoplayer controller when app is disposed:

```

@override
  void dispose() async {
    super.dispose();
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
  }

```

Below code handles the portrait and landscape feature of the app, top we have the appbar, follow by the app body, then the if statement to handle the app orientation:

```
 @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0), // here the desired height
          child: AppBar(
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.black,
              title: Image.asset(
                'assets/vaudience_logo.png',
                height: 30,
                fit: BoxFit.cover,
              )),
        ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return     Column(children: [

              Container(
                child: Stack(
                  children: [
                    Container(
                        child: FutureBuilder(
                          future: _initializeVideoPlayerFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              // If the VideoPlayerController has finished initialization, use
                              // the data it provides to limit the aspect ratio of the video.
                              return AspectRatio(
                                aspectRatio: 16 / 9,
                                child: VideoPlayer(_controller),
                              );
                            } else {
                              // If the VideoPlayerController is still initializing, show a
                              // loading spinner.
                              return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.red,
                                  ));
                            }
                          },
                        )),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            // If the video is playing, pause it.
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            } else {
                              // If the video is paused, play it.
                              _controller.play();
                            }
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.all(5),
                            child: CircleAvatar(
                                backgroundColor:
                                Colors.black.withOpacity(0.3),
                                radius: 18,
                                child: Icon(
                                  _controller.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 30,
                                )))),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.all(5),
                  child: Align(
                      alignment: Alignment.center,
                      child: Flexible(
                          child: Text(
                            "Butterfly on the flower rose and fly away",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )))),
              Divider(),

              Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Container(
                        //  padding: EdgeInsets.all(5),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Flexible(
                                  child: Text(
                                    "Comments:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight:
                                        FontWeight.bold),
                                  )))),

                      Spacer(),
                      InkWell(
                          onTap: (){

                            avatars.shuffle();
                            names.shuffle();

                          },
                          child:Container(
                            // padding: EdgeInsets.all(5),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Flexible(
                                      child: Icon(
                                        Icons.shuffle,
                                        size: 25,
                                      ))))),
                    ],
                  )),
              Card(
                  child:Flexible(
                      child: Container(
                          padding:
                          EdgeInsets.all(5),
                          child: Align(
                              alignment: Alignment
                                  .centerLeft,
                              child: Flexible(
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Flexible(
                                          flex: 0,
                                          child:
                                          Container(
                                            padding:
                                            EdgeInsets.all(3),
                                            child: Image
                                                .asset(
                                              "assets/avatar1.png",
                                              height:
                                              25,
                                              width:
                                              25,
                                            ),
                                          )),
                                      Flexible(
                                          child: Container(
                                              padding: EdgeInsets.all(3),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    // padding: EdgeInsets.all(5),
                                                      child: Text(
                                                        "Isijola Michael",
                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                      )),
                                                  Container(
                                                    //   padding: EdgeInsets.all(5),
                                                      child: Text(
                                                        "This is an amazing live stream",
                                                        style: TextStyle(color: Colors.grey),
                                                        textAlign: TextAlign.start,
                                                        textDirection: TextDirection.ltr,
                                                      )),
                                                ],
                                              )))
                                    ],
                                  )))))
              ),

              SizedBox(height: 15,),

              Expanded(child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.white,
                ),
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child:Flexible(
                        child: Container(
                            padding:
                            EdgeInsets.all(5),
                            child: Align(
                                alignment: Alignment
                                    .centerLeft,
                                child: Flexible(
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                      children: [
                                        Flexible(
                                            flex: 0,
                                            child:
                                            Container(
                                              padding:
                                              EdgeInsets.all(3),
                                              child: Image
                                                  .asset(
                                                data[index].avatar,
                                                height:
                                                25,
                                                width:
                                                25,
                                              ),
                                            )),
                                        Flexible(
                                            child: Container(
                                                padding: EdgeInsets.all(3),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      // padding: EdgeInsets.all(5),
                                                        child: Text(
                                                          data[index].username,
                                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                        )),
                                                    Container(
                                                      //   padding: EdgeInsets.all(5),
                                                        child: Text(
                                                          data[index].comment,
                                                          style: TextStyle(color: Colors.grey),
                                                          textAlign: TextAlign.start,
                                                          textDirection: TextDirection.ltr,
                                                        )),
                                                  ],
                                                )))
                                      ],
                                    )))))
                  );
                },
              )),

              GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0))),
                        backgroundColor: Colors.black,
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => Padding(
                          padding:
                          const EdgeInsets.symmetric(
                              horizontal: 18),
                          child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  SizedBox(
                                    height: 8.0,
                                  ),

                                  InkWell(
                                      onTap: (){
                                        avatars.shuffle();
                                        names.shuffle();

                                      },
                                      child: Container(
                                        // padding: EdgeInsets.all(5),
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Flexible(
                                                  child: Icon(
                                                    Icons.shuffle,
                                                    size: 25,
                                                    color: Colors.white,
                                                  ))))),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(
                                              context)
                                              .viewInsets
                                              .bottom),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: TextField(
                                                controller: _controllerComment,
                                                keyboardType:
                                                TextInputType
                                                    .multiline,
                                                maxLines: null,
                                                decoration:
                                                InputDecoration(
                                                  suffixIcon:
                                                  GestureDetector(
                                                      onTap:
                                                          () {
                                                        setState(() {
                                                          FocusScope.of(context).unfocus();
                                                          print("emojji press");
                                                          isShowSticker = !isShowSticker;
                                                        });
                                                      },
                                                      child:
                                                      Icon(
                                                        Icons.face,
                                                        color:
                                                        Colors.black,
                                                      )),
                                                  enabledBorder:
                                                  const OutlineInputBorder(),
                                                  focusedBorder:
                                                  OutlineInputBorder(
                                                    borderSide:
                                                    BorderSide(
                                                        color:
                                                        Colors.black),
                                                  ),
                                                  border:
                                                  OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        5.0),
                                                  ),
                                                  errorBorder:
                                                  InputBorder
                                                      .none,
                                                  disabledBorder:
                                                  InputBorder
                                                      .none,
                                                  hintText:
                                                  "Add a comment...",
                                                  fillColor:
                                                  Colors
                                                      .white,
                                                  filled: true,
                                                  labelStyle: new TextStyle(
                                                      color: Colors
                                                          .grey,
                                                      fontFamily:
                                                      'Montserrat',
                                                      fontSize:
                                                      12),
                                                  hintStyle: new TextStyle(
                                                      color: Colors
                                                          .grey,
                                                      fontFamily:
                                                      'Montserrat'),
                                                  errorStyle: TextStyle(
                                                      color: Colors
                                                          .red,
                                                      fontFamily:
                                                      'Montserrat'),
                                                ),
                                                autofocus: true,
                                              )),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                if(_controllerComment.text.toString()!=""){
                                                 data.add(UserWithComment( names[0].toString(),_controllerComment.text,avatars[1].toString()));

                                                  Navigator.pop(context);
                                                _controllerComment.clear();
                                                }else{
                                                  Navigator.pop(context);

                                                  _showToast(context);


                                                }

                                              },
                                              child:  Expanded(
                                                  child: Container(
                                                    padding:
                                                    EdgeInsets.all(
                                                        18),
                                                    decoration:
                                                    BoxDecoration(
                                                      border:
                                                      Border.all(
                                                        color: Colors
                                                            .black,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius
                                                          .all(
                                                        Radius.circular(
                                                            5),
                                                      ),
                                                      color:
                                                      Colors.white,
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                          "SEND",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                        )),
                                                  )))
                                        ],
                                      )),
                                  Container(
                                      child: (isShowSticker
                                          ? Container(
                                          child:
                                          buildSticker())
                                          : Container())),
                                  SizedBox(height: 10),
                                ],
                              )),
                        ));
                  },
                  child: Expanded(
                    child: Container(
                        color: Colors.black,
                        padding: EdgeInsets.all(2),
                        child: Align(
                          alignment:
                          FractionalOffset.bottomCenter,
                          child: SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                          decoration:
                                          BoxDecoration(
                                            borderRadius:
                                            BorderRadius
                                                .all(Radius
                                                .circular(
                                                5)),
                                            color: Colors.white,
                                          ),
                                          child: InputDecorator(
                                            decoration:
                                            InputDecoration(
                                              suffixIcon:
                                              GestureDetector(
                                                  onTap:
                                                      () {},
                                                  child:
                                                  Icon(
                                                    Icons
                                                        .face,
                                                    color: Colors
                                                        .black,
                                                  )),
                                              enabledBorder:
                                              const OutlineInputBorder(),
                                              border:
                                              OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    5.0),
                                              ),
                                              errorBorder:
                                              InputBorder
                                                  .none,
                                              disabledBorder:
                                              InputBorder
                                                  .none,
                                              hintText:
                                              "Add a comment...",
                                              fillColor:
                                              Colors.white,
                                              filled: true,
                                              labelStyle: new TextStyle(
                                                  color: Colors
                                                      .grey,
                                                  fontFamily:
                                                  'Montserrat',
                                                  fontSize: 12),
                                              hintStyle: new TextStyle(
                                                  color: Colors
                                                      .grey,
                                                  fontFamily:
                                                  'Montserrat'),
                                              errorStyle: TextStyle(
                                                  color: Colors
                                                      .red,
                                                  fontFamily:
                                                  'Montserrat'),
                                            ),
                                          ))),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(
                                                  5)),
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                            child: Text(
                                              "SEND",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            )),
                                      ))
                                ],
                              )),
                        )),
                  ))

            ],);
          } else {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                new Container(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Stack(
                                children: [
                                  Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: FutureBuilder(
                                        future: _initializeVideoPlayerFuture,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            // If the VideoPlayerController has finished initialization, use
                                            // the data it provides to limit the aspect ratio of the video.
                                            return AspectRatio(
                                              aspectRatio: 16 / 9,
                                              child: VideoPlayer(_controller),
                                            );
                                          } else {
                                            // If the VideoPlayerController is still initializing, show a
                                            // loading spinner.
                                            return Center(
                                                child: CircularProgressIndicator());
                                          }
                                        },
                                      )),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          // If the video is playing, pause it.
                                          if (_controller.value.isPlaying) {
                                            _controller.pause();
                                          } else {
                                            // If the video is paused, play it.
                                            _controller.play();
                                          }
                                        });
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: CircleAvatar(
                                              backgroundColor:
                                              Colors.black.withOpacity(0.3),
                                              radius: 18,
                                              child: Icon(
                                                _controller.value.isPlaying
                                                    ? Icons.pause
                                                    : Icons.play_arrow,
                                                color: Colors.white,
                                                size: 30,
                                              )))),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (showChat == true) {
                                            showChat = false;
                                          } else {
                                            // If the video is paused, play it.
                                            showChat = true;
                                          }
                                        });
                                      },
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 20, bottom: 20, left: 5),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10.0),
                                                bottomLeft: Radius.circular(10.0),
                                              ),
                                              color: Colors.black.withOpacity(0.3),
                                            ),
                                            child: Icon(
                                              showChat == true
                                                  ? Icons.arrow_forward_ios_outlined
                                                  : Icons.arrow_back_ios,
                                              color: Colors.white,
                                            ),
                                          )))
                                ],
                              ),
                            )),
                        Visibility(
                            visible: showChat,
                            child: Expanded(
                                child: Container(
                                  //padding: EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(5),
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Flexible(
                                                  child: Text(
                                                    "Butterfly on the flower rose and fly away",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16),
                                                  )))),
                                      Divider(),
                                      Container(
                                          padding: EdgeInsets.all(5),
                                          child: Row(
                                            children: [
                                              Container(
                                                //  padding: EdgeInsets.all(5),
                                                  child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Flexible(
                                                          child: Text(
                                                            "Comments:",
                                                            style: TextStyle(
                                                                color: Colors.black,
                                                                fontWeight:
                                                                FontWeight.bold),
                                                          )))),
                                              Spacer(),
                                             InkWell(
                                                 onTap: (){
                                                   avatars.shuffle();
                                                   names.shuffle();

                                                 },
                                                 child: Container(
                                                // padding: EdgeInsets.all(5),
                                                  child: Align(
                                                      alignment: Alignment.center,
                                                      child: Flexible(
                                                          child: Icon(
                                                            Icons.shuffle,
                                                            size: 25,
                                                          ))))),
                                            ],
                                          )),
                                      Card(
                                          child:Flexible(
                                              child: Container(
                                                  padding:
                                                  EdgeInsets.all(5),
                                                  child: Align(
                                                      alignment: Alignment
                                                          .centerLeft,
                                                      child: Flexible(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Flexible(
                                                                  flex: 0,
                                                                  child:
                                                                  Container(
                                                                    padding:
                                                                    EdgeInsets.all(3),
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/avatar1.png",
                                                                      height:
                                                                      25,
                                                                      width:
                                                                      25,
                                                                    ),
                                                                  )),
                                                              Flexible(
                                                                  child: Container(
                                                                      padding: EdgeInsets.all(3),
                                                                      child: Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Container(
                                                                            // padding: EdgeInsets.all(5),
                                                                              child: Text(
                                                                                "Isijola Michael",
                                                                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                                              )),
                                                                          Container(
                                                                            //   padding: EdgeInsets.all(5),
                                                                              child: Text(
                                                                                "This is an amazing live stream",
                                                                                style: TextStyle(color: Colors.grey),
                                                                                textAlign: TextAlign.start,
                                                                                textDirection: TextDirection.ltr,
                                                                              )),
                                                                        ],
                                                                      )))
                                                            ],
                                                          )))))
                                      ),
                                      Expanded(child: ListView.separated(
                                        separatorBuilder: (context, index) => Divider(
                                          color: Colors.white,
                                        ),
                                        itemCount: data == null ? 0 : data.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                              child:Flexible(
                                                  child: Container(
                                                      padding:
                                                      EdgeInsets.all(5),
                                                      child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Flexible(
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Flexible(
                                                                      flex: 0,
                                                                      child:
                                                                      Container(
                                                                        padding:
                                                                        EdgeInsets.all(3),
                                                                        child: Image
                                                                            .asset(
                                                                          data[index].avatar,
                                                                          height:
                                                                          25,
                                                                          width:
                                                                          25,
                                                                        ),
                                                                      )),
                                                                  Flexible(
                                                                      child: Container(
                                                                          padding: EdgeInsets.all(3),
                                                                          child: Column(
                                                                            crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Container(
                                                                                // padding: EdgeInsets.all(5),
                                                                                  child: Text(
                                                                                    data[index].username,
                                                                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                                                  )),
                                                                              Container(
                                                                                //   padding: EdgeInsets.all(5),
                                                                                  child: Text(
                                                                                    data[index].comment,
                                                                                    style: TextStyle(color: Colors.grey),
                                                                                    textAlign: TextAlign.start,
                                                                                    textDirection: TextDirection.ltr,
                                                                                  )),
                                                                            ],
                                                                          )))

                                                                ],
                                                              )))))
                                          );
                                        },
                                      )),
                                      GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.vertical(
                                                        top: Radius.circular(25.0))),
                                                backgroundColor: Colors.black,
                                                context: context,
                                                isScrollControlled: true,
                                                builder: (context) => Padding(
                                                  padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 18),
                                                  child: SingleChildScrollView(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: <Widget>[
                                                          SizedBox(
                                                            height: 8.0,
                                                          ),
                                                          InkWell(
                                                              onTap: (){
                                                                avatars.shuffle();
                                                                names.shuffle();

                                                              },
                                                              child: Container(
                                                                // padding: EdgeInsets.all(5),
                                                                  child: Align(
                                                                      alignment: Alignment.center,
                                                                      child: Flexible(
                                                                          child: Icon(
                                                                            Icons.shuffle,
                                                                            size: 25,
                                                                            color: Colors.white,
                                                                          ))))),
                                                          SizedBox(
                                                            height: 5.0,
                                                          ),
                                                          Padding(
                                                              padding: EdgeInsets.only(
                                                                  bottom: MediaQuery.of(
                                                                      context)
                                                                      .viewInsets
                                                                      .bottom),
                                                              child: Row(
                                                                children: [

                                                                  Expanded(
                                                                      flex: 3,
                                                                      child: TextField(

                                                                        controller: _controllerComment,
                                                                        keyboardType:
                                                                        TextInputType
                                                                            .multiline,
                                                                        maxLines: null,
                                                                        decoration:
                                                                        InputDecoration(
                                                                          suffixIcon:
                                                                          GestureDetector(
                                                                              onTap:
                                                                                  () {
                                                                                setState(() {
                                                                                  FocusScope.of(context).unfocus();
                                                                                  print("emojji press");
                                                                                  isShowSticker = !isShowSticker;
                                                                                });
                                                                              },
                                                                              child:
                                                                              Icon(
                                                                                Icons.face,
                                                                                color:
                                                                                Colors.black,
                                                                              )),
                                                                          enabledBorder:
                                                                          const OutlineInputBorder(),
                                                                          focusedBorder:
                                                                          OutlineInputBorder(
                                                                            borderSide:
                                                                            BorderSide(
                                                                                color:
                                                                                Colors.black),
                                                                          ),
                                                                          border:
                                                                          OutlineInputBorder(
                                                                            borderRadius:
                                                                            BorderRadius.circular(
                                                                                5.0),
                                                                          ),
                                                                          errorBorder:
                                                                          InputBorder
                                                                              .none,
                                                                          disabledBorder:
                                                                          InputBorder
                                                                              .none,
                                                                          hintText:
                                                                          "Add a comment...",
                                                                          fillColor:
                                                                          Colors
                                                                              .white,
                                                                          filled: true,
                                                                          labelStyle: new TextStyle(
                                                                              color: Colors
                                                                                  .grey,
                                                                              fontFamily:
                                                                              'Montserrat',
                                                                              fontSize:
                                                                              12),
                                                                          hintStyle: new TextStyle(
                                                                              color: Colors
                                                                                  .grey,
                                                                              fontFamily:
                                                                              'Montserrat'),
                                                                          errorStyle: TextStyle(
                                                                              color: Colors
                                                                                  .red,
                                                                              fontFamily:
                                                                              'Montserrat'),
                                                                        ),
                                                                        autofocus: true,
                                                                      )),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                              InkWell(
                                                                onTap: () {

                                                                  if(_controllerComment.text.toString()!=""){
                                                                    data.add(UserWithComment( names[0].toString(),_controllerComment.text,avatars[1].toString()));

                                                                    Navigator.pop(context);
                                                                    _controllerComment.clear();
                                                                  }else{
                                                                    Navigator.pop(context);

                                                                    _showToast(context);


                                                                  }

                                                                },
                                                                child:  Expanded(
                                                                      child: Container(
                                                                        padding:
                                                                        EdgeInsets.all(
                                                                            18),
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          border:
                                                                          Border.all(
                                                                            color: Colors
                                                                                .black,
                                                                          ),
                                                                          borderRadius:
                                                                          BorderRadius
                                                                              .all(
                                                                            Radius.circular(
                                                                                5),
                                                                          ),
                                                                          color:
                                                                          Colors.white,
                                                                        ),
                                                                        child: Center(
                                                                            child: Text(
                                                                              "SEND",
                                                                              style: TextStyle(
                                                                                  fontSize: 18,
                                                                                  fontWeight:
                                                                                  FontWeight
                                                                                      .bold),
                                                                            )),
                                                                      )))
                                                                ],
                                                              )),
                                                          Container(
                                                              child: (isShowSticker
                                                                  ? Container(
                                                                  child:
                                                                  buildSticker())
                                                                  : Container())),
                                                          SizedBox(height: 10),
                                                        ],
                                                      )),
                                                ));
                                          },
                                          child: Expanded(
                                            child: Container(
                                                color: Colors.black,
                                                padding: EdgeInsets.all(2),
                                                child: Align(
                                                  alignment:
                                                  FractionalOffset.bottomCenter,
                                                  child: SizedBox(
                                                      height: 50,
                                                      width: double.infinity,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              flex: 3,
                                                              child: Container(
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .all(Radius
                                                                        .circular(
                                                                        5)),
                                                                    color: Colors.white,
                                                                  ),
                                                                  child: InputDecorator(
                                                                    decoration:
                                                                    InputDecoration(
                                                                      suffixIcon:
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {},
                                                                          child:
                                                                          Icon(
                                                                            Icons
                                                                                .face,
                                                                            color: Colors
                                                                                .black,
                                                                          )),
                                                                      enabledBorder:
                                                                      const OutlineInputBorder(),
                                                                      border:
                                                                      OutlineInputBorder(
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            5.0),
                                                                      ),
                                                                      errorBorder:
                                                                      InputBorder
                                                                          .none,
                                                                      disabledBorder:
                                                                      InputBorder
                                                                          .none,
                                                                      hintText:
                                                                      "Add a comment...",
                                                                      fillColor:
                                                                      Colors.white,
                                                                      filled: true,
                                                                      labelStyle: new TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontFamily:
                                                                          'Montserrat',
                                                                          fontSize: 12),
                                                                      hintStyle: new TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontFamily:
                                                                          'Montserrat'),
                                                                      errorStyle: TextStyle(
                                                                          color: Colors
                                                                              .red,
                                                                          fontFamily:
                                                                          'Montserrat'),
                                                                    ),
                                                                  ))),
                                                          SizedBox(
                                                            width: 2,
                                                          ),


                                                          Expanded(
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          5)),
                                                                  color: Colors.white,
                                                                ),
                                                                child: Center(
                                                                    child: Text(
                                                                      "SEND",
                                                                      style: TextStyle(
                                                                          color: Colors.black,
                                                                          fontWeight:
                                                                          FontWeight.bold),
                                                                    )),
                                                              ))
                                                        ],
                                                      )),
                                                )),
                                          )),
                                    ],
                                  ),
                                )))
                      ],
                    )),
              ],
            );
          }
        },
      ),

    );
  }
}


```
Based on the above code, when user input value inside the ```TextField``` and click on send button there is ``` onTap: ``` that add every input value to the list of comment with ```  data.add(_controllerComment.text.toString()); ``` and display the new comment immediately on the list of comments.

Below handles the emoji picker and it is been used in the app body:

```

Widget buildSticker() {
  return EmojiPicker(
    rows: 10,
    columns: 5,
    buttonMode: ButtonMode.MATERIAL,
    recommendKeywords: ["racing", "horse","Face","Ghost"],
    numRecommended: 10,
    onEmojiSelected: (emoji, category) {
   print(emoji);
    },
  );
}

```

Below is a toast that pop-up when user click send with an empty field:

```


void _showToast(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text('Fill all field'),
      duration: const Duration(seconds: 5),
    ),
  );
}


```
