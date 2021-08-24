import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/constants.dart';
import 'package:instagram_clone/core/utils/sizing.dart';
import 'package:instagram_clone/features/new_post/presentation/pages/new_live_page.dart';
import 'package:instagram_clone/features/new_post/presentation/pages/new_post_page.dart';
import 'package:instagram_clone/features/new_post/presentation/pages/new_reels_page.dart';
import 'package:instagram_clone/features/new_post/presentation/pages/new_story_page.dart';
import 'package:instagram_clone/features/new_post/presentation/widgets/capture_button.dart';
import 'package:instagram_clone/features/new_post/presentation/widgets/custom_bottom_navbar.dart';

import 'camera_settings.dart';
import 'captured_media_page.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key key, @required this.gotoHomePage}) : super(key: key);
  final VoidCallback gotoHomePage;

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  int selectedIndex = 1;
  CameraController _cameraController;
  Future<void> _initailizeCameraFuture;

  int _selected = 0;
  int _flashMode = 0;

  List<CameraDescription> cameras;
  void setIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  PageController _pageController =
      PageController(initialPage: 1, keepPage: true);
  AnimationController rotationController;

  ScrollController _bottomNavScrollController;
  bool pauseAutoScroll = false;

  @override
  void initState() {
    _bottomNavScrollController = ScrollController(initialScrollOffset: 100);
    _bottomNavScrollController.addListener(() {
      changePages();
    });
    _pageController = PageController(initialPage: 1, keepPage: true);
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    setupCamera();
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  //Navigating through pages as the offset of the CustomBottomNavBar changes
  void changePages() {
    setState(() {
      if (!pauseAutoScroll) {
        if (_bottomNavScrollController.offset <
            _bottomNavScrollController.position.maxScrollExtent / 3.2) {
          selectedIndex = 0;
          _pageController.jumpToPage(0);
        } else if (_bottomNavScrollController.offset >=
            _bottomNavScrollController.position.maxScrollExtent / 2.7) {
          if (_bottomNavScrollController.offset <=
              _bottomNavScrollController.position.maxScrollExtent / 2) {
            if (selectedIndex == 0) {
              _pageController.jumpToPage(1);
            }
            selectedIndex = 1;
          } else if (_bottomNavScrollController.offset <=
              _bottomNavScrollController.position.maxScrollExtent / 1.3) {
            if (selectedIndex == 0) {
              _pageController.jumpToPage(1);
            }
            selectedIndex = 2;
          } else if (_bottomNavScrollController.offset <=
              _bottomNavScrollController.position.maxScrollExtent / 0.8) {
            if (selectedIndex == 0) {
              _pageController.jumpToPage(1);
            }
            selectedIndex = 3;
          }
        }
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final CameraController controller = _cameraController;
    if (controller == null || !controller.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      controller.dispose();
    } else if (state == AppLifecycleState.resumed) {
      setupCamera(cameraDescription: controller.description);
    }
  }

  Future<void> setupCamera({CameraDescription cameraDescription}) async {
    cameras = await availableCameras();
    if (_cameraController != null) {
      await _cameraController.dispose();
    }
    var cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
    );
    _cameraController = cameraController;
    _initailizeCameraFuture = _cameraController.initialize();

    var controller = await selectCamera();
    setState(() {
      _cameraController = controller;
      _initailizeCameraFuture = _cameraController.initialize();
    });
  }

  Future<CameraController> selectCamera() async {
    var controller =
        CameraController(cameras[_selected], ResolutionPreset.high);
    await controller.initialize();
    return controller;
  }

  @override
  void dispose() {
    _cameraController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void capturePhoto() async {
    try {
      await _initailizeCameraFuture;

      final image = await _cameraController.takePicture();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return CapturedMediaPage(
              path: image.path,
              image: true,
            );
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  void onStopVideoRecord() async {
    try {
      final video = await _cameraController.stopVideoRecording();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return CapturedMediaPage(
              path: video.path,
              image: false,
            );
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  //Toggle side list Tile expansion only if collapseTile is true
  void toggleExpanseTile() {
    if (collapseTile) {
      setState(() {
        collapseTile = !collapseTile;
        if (collapseTile) {
          rotationController.forward();
        } else {
          rotationController.reverse();
        }
      });
    }
  }

  //Toggle side list Tile expansion
  void toggleifExpanseTile() {
    setState(() {
      collapseTile = !collapseTile;
      if (collapseTile) {
        rotationController.forward();
      } else {
        rotationController.reverse();
      }
    });
  }

  bool collapseTile = false; //if side tile is expanded
  bool leftPosition = true; //if side tile is in the left position

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            //PageView for 2 pages
            // 1: The NewPostPage ;if selectedIndex is 0 : NewPostPage is in view
            // 2: Stack Pages (NewStoryPage, NewReelsPage, NewLivePage)
            //selectedIndex is used to display current page in the PageView
            //Opacity and Visibility of (NewStoryPage, NewReelsPage, NewLivePage) changes based on selectedIndex
            PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              children: [
                NewPostPage(
                  close: widget.gotoHomePage,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: _size.height * 0.87,
                      width: _size.width,
                      child: FutureBuilder(
                        future: _initailizeCameraFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return AspectRatio(
                              aspectRatio: _cameraController.value.aspectRatio,
                              child: CameraPreview(_cameraController),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                    //This is the shadow behind the list tile it is visible only when the list tile in
                    //MewStoryPage and NewReelsPage are in view and expanded
                    Visibility(
                      visible: selectedIndex != 3,
                      child: AnimatedPositioned(
                        duration: Duration(milliseconds: 500),
                        right: leftPosition ? _size.width * 0.5 : 0.0,
                        child: AnimatedContainer(
                          alignment: Alignment.center,
                          duration: Duration(milliseconds: 300),
                          width: _size.width / 2,
                          height: _size.height,
                          padding: EdgeInsets.only(bottom: klargeIconSize),
                          decoration: BoxDecoration(
                            boxShadow: collapseTile
                                ? [
                                    BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: _size.width,
                                      offset: Offset(
                                          (leftPosition
                                                  ? -_size.width
                                                  : _size.width) /
                                              4,
                                          0),
                                      spreadRadius: 0,
                                    )
                                  ]
                                : [
                                    BoxShadow(
                                      color: Colors.transparent,
                                      offset: Offset(
                                          (leftPosition
                                                  ? -_size.width
                                                  : _size.width) /
                                              4,
                                          0),
                                      spreadRadius: 0,
                                    )
                                  ],
                          ),
                        ),
                      ),
                    ),
                    //If selectedIndex == 1 NewStoryPage is visible and snaps to positon in stack
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 500),
                      right: leftPosition
                          ? selectedIndex == 1
                              ? 0.0
                              : 20.0
                          : 0.0,
                      top: 0.0,
                      left: leftPosition
                          ? selectedIndex == 1
                              ? 0.0
                              : -20.0
                          : _size.width * 0.5,
                      curve: Curves.decelerate,
                      child: NewStoryPage(
                        selectedIndex: selectedIndex,
                        collapseTile: collapseTile,
                        leftPosition: leftPosition,
                        onExpand: toggleExpanseTile,
                        onIfExpand: toggleifExpanseTile,
                      ),
                    ),
                    //If selectedIndex == 2 NewReelsPage is visible and snaps to positon in stack
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 500),
                      right: leftPosition ? _size.width * 0.5 : 0.0,
                      top: 0.0,
                      left: leftPosition
                          ? selectedIndex == 2
                              ? 0.0
                              : selectedIndex == 3
                                  ? -20
                                  : 20.0
                          : selectedIndex == 2
                              ? -_size.width * 2
                              : 0.0,
                      curve: Curves.decelerate,
                      child: NewReelsPage(
                        selectedIndex: selectedIndex,
                        collapseTile: collapseTile,
                        leftPosition: leftPosition,
                        onExpand: toggleExpanseTile,
                        onIfExpand: toggleifExpanseTile,
                      ),
                    ),
                    //If selectedIndex == 3 NewLivePage is visible and snaps to positon in stack
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 500),
                      right: leftPosition ? _size.width * 0.5 : 0.0,
                      top: 0.0,
                      left: leftPosition
                          ? selectedIndex == 3
                              ? 0.0
                              : 20.0
                          : selectedIndex == 3
                              ? -_size.width * 2
                              : 0.0,
                      curve: Curves.decelerate,
                      child: NewLivePage(
                        selectedIndex: selectedIndex,
                        leftPosition: leftPosition,
                      ),
                    ),
                    // Camera Control button
                    Positioned(
                      bottom: Sizing.yMargin(context, 12),
                      child: CaptureButton(
                        cameraCaptureLongPress: () async {
                          try {
                            await _initailizeCameraFuture;
                            await _cameraController.startVideoRecording();
                          } catch (e) {
                            print(e);
                          }
                        },
                        cameraCaptureLongPressUp: () {
                          onStopVideoRecord();
                        },
                        cameraCaptureTap: () {
                          capturePhoto();
                        },
                      ),
                    ),
                    //Top camera button bar
                    //This is visible only in NewStoryPage, NewReelsPage, NewLivePage
                    AbsorbPointer(
                      absorbing: collapseTile || selectedIndex == 3,
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: collapseTile && selectedIndex != 3 ? 0.45 : 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => CameraSettingsPage(
                                        toolSide: leftPosition,
                                        onChangeCameraToolSide: () {},
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.settings,
                                  size: 30.0,
                                ),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 600),
                                width: selectedIndex == 2
                                    ? _size.width * 0.75
                                    : _size.width * 0.175,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (_flashMode == 0) {
                                            _cameraController
                                                .setFlashMode(FlashMode.always);
                                            _flashMode = 1;
                                          } else if (_flashMode == 1) {
                                            _cameraController
                                                .setFlashMode(FlashMode.auto);
                                            _flashMode = 2;
                                          } else {
                                            _cameraController
                                                .setFlashMode(FlashMode.off);
                                            _flashMode = 0;
                                          }
                                        });
                                      },
                                      child: Icon(
                                        _flashMode == 0
                                            ? Icons.flash_off
                                            : _flashMode == 1
                                                ? Icons.flash_on
                                                : Icons.flash_auto,
                                        size: 30.0,
                                      ),
                                    ),
                                    //Changes visibility to true when the NewReelsPage is in view ; selectedIndex is equals to 2
                                    Visibility(
                                      visible: selectedIndex == 2,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Icon(Icons.airplanemode_active),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: widget.gotoHomePage,
                                child: Icon(
                                  Icons.close,
                                  size: 30.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //Toggle button for changing the list tile position from left to right
                    //It is visible only when the tiles are expanded
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 300),
                      right: leftPosition ? _size.width - 36 : 12.0,
                      child: Container(
                        child: Visibility(
                          visible: collapseTile && selectedIndex != 3,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                leftPosition = !leftPosition;
                              });
                            },
                            child: Icon(
                              Icons.sync_alt_outlined,
                              size: klargeIconSize,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              onPageChanged: (index) {
                setState(() {
                  _selected = index;
                });
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: CustomBottomNavBar(
            selectedIndex: selectedIndex,
            controller: _bottomNavScrollController,
            onChanged: (index) {
              setState(() {
                selectedIndex = index;
                pauseAutoScroll = true;
                Future.delayed(Duration(milliseconds: 350), () {
                  pauseAutoScroll = false;
                });
              });
              if (index == 0) {
                _bottomNavScrollController.animateTo(0.0,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeIn);
              } else if (index == 1) {
                _bottomNavScrollController.animateTo(
                  _bottomNavScrollController.position.maxScrollExtent / 2,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              } else if (index == 2) {
                _bottomNavScrollController.animateTo(
                  _bottomNavScrollController.position.maxScrollExtent / 1.4,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              } else if (index == 3) {
                _bottomNavScrollController.animateTo(
                  _bottomNavScrollController.position.maxScrollExtent / 0.7,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              }
              if (index == 0 || index == 1) {
                _pageController.jumpToPage(index);
              }
            },
            rightSideWidget: InkWell(
              onTap: () async {
                setState(() {
                  if (_selected == 0) {
                    _selected = 1;
                  } else {
                    _selected = 0;
                  }
                });
                var controller = await selectCamera();
                setState(() {
                  _cameraController = controller;
                  _initailizeCameraFuture = _cameraController.initialize();
                });
              },
              child: Icon(
                Icons.flip_camera_ios_rounded,
                size: 40.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
