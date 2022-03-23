import 'package:flutter/material.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:video_player/video_player.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'dart:async';
import 'dart:ui';

List data = [];
late VideoPlayerController _controller;
late Future<void> _initializeVideoPlayerFuture;
TextEditingController _controllerComment = TextEditingController();


String emojiPicked = "";

bool showChat = false;
bool showFAB = false;
bool isShowSticker = false;

class liveCommment extends StatefulWidget {
  @override
  _liveCommmentState createState() => _liveCommmentState();
}

class _liveCommmentState extends State<liveCommment> {

  @override
  void initState() {
    super.initState();


    isShowSticker = false;
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
    _controller.play();
  }

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

  @override
  void dispose() async {
    super.dispose();
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
  }


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



                          },
                          child:Container(
                            // padding: EdgeInsets.all(5),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Flexible(
                                      child: Icon(
                                        Icons.shuffle,
                                        size: 20,
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
                                              "assets/person_icon.png",
                                              height:
                                              25,
                                              width:
                                              25,
                                              color:
                                              Colors.black,
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
                                                "assets/person_icon.png",
                                                height:
                                                25,
                                                width:
                                                25,
                                                color:
                                                Colors.black,
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
                                                          "User Name",
                                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                        )),
                                                    Container(
                                                      //   padding: EdgeInsets.all(5),
                                                        child: Text(
                                                          data[index],
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
                                                //controller: _newMediaLinkAddressController,
                                              )),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                if(_controllerComment.text.toString()!=""){
                                                data.add(_controllerComment.text.toString());
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
                                            debugPrint("showChat:$showChat");
                                          } else {
                                            // If the video is paused, play it.
                                            showChat = true;
                                            debugPrint("showChat:$showChat");
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
                                              Container(
                                                // padding: EdgeInsets.all(5),
                                                  child: Align(
                                                      alignment: Alignment.center,
                                                      child: Flexible(
                                                          child: Icon(
                                                            Icons.shuffle,
                                                            size: 20,
                                                          )))),
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
                                                                      "assets/person_icon.png",
                                                                      height:
                                                                      25,
                                                                      width:
                                                                      25,
                                                                      color:
                                                                      Colors.black,
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
                                                                          "assets/person_icon.png",
                                                                          height:
                                                                          25,
                                                                          width:
                                                                          25,
                                                                          color:
                                                                          Colors.black,
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
                                                                                    "User Name",
                                                                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                                                  )),
                                                                              Container(
                                                                                //   padding: EdgeInsets.all(5),
                                                                                  child: Text(
                                                                                    data[index],
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
                                                                        //controller: _newMediaLinkAddressController,
                                                                      )),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                              InkWell(
                                                                onTap: () {

                                                                  if(_controllerComment.text.toString()!=""){
                                                                    data.add(_controllerComment.text.toString());
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

                                                          /*Expanded(
                                  flex: 0,
                                  child: GestureDetector(
                                      onTap: (){
                                        print("Emoji");
                                        buildSticker();

                                      },
                                      child:Container(
                                      padding: EdgeInsets.all(5),
                                      child:Image.asset("assets/smile.png",height: 20,)))),*/

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


Widget buildSticker() {
  return EmojiPicker(
    rows: 10,
    columns: 5,
    buttonMode: ButtonMode.MATERIAL,
    recommendKeywords: ["racing", "horse","Face","Ghost"],
    numRecommended: 10,
    onEmojiSelected: (emoji, category) {

      //var picker = emoji["Emoji"];

      print(emoji);
      debugPrint("the_picked_emojji:$emoji ");

      emojiPicked = emoji.toString();
      print(emojiPicked);
    },
  );
}


void _showToast(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text('Fill all field'),
      duration: const Duration(seconds: 5),
    ),
  );
}