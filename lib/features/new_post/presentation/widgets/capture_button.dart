import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:instagram_clone/core/utils/constants.dart';

import 'custom_ring.dart';

class CaptureButton extends StatefulWidget {
  const CaptureButton({
    this.selectedIndex,
    this.child,
    this.cameraCaptureTap,
    this.cameraCaptureLongPress,
    this.cameraCaptureLongPressUp,
  });
  final int selectedIndex;
  final Widget child;
  final VoidCallback cameraCaptureTap;
  final VoidCallback cameraCaptureLongPress;
  final VoidCallback cameraCaptureLongPressUp;

  @override
  _CaptureButtonState createState() => _CaptureButtonState();
}

class _CaptureButtonState extends State<CaptureButton> {
  ScrollController buttonScrollController;
  double selectedButton = 0.0;
  bool isScrolled = true;

  @override
  void initState() {
    buttonScrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      width: _size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: _size.width / 6,
            width: _size.width,
            child: ListView.separated(
              shrinkWrap: true,
              cacheExtent: 0,
              controller: buttonScrollController
                ..addListener(() {
                  if (isScrolled) {
                    if (buttonScrollController.position.userScrollDirection ==
                        ScrollDirection.forward) {
                      buttonScrollController.position.animateTo(
                          (_size.width / 6 + kmediumSpace) * selectedButton,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.decelerate);
                      setState(() {
                        if (selectedButton != 0) {
                          selectedButton -= 1.0;
                          isScrolled = false;
                        }
                      });
                    } else if (buttonScrollController
                            .position.userScrollDirection ==
                        ScrollDirection.reverse) {
                      buttonScrollController.position.animateTo(
                          (_size.width / 6 + kmediumSpace) *
                              (selectedButton + 1),
                          duration: Duration(milliseconds: 300),
                          curve: Curves.decelerate);
                      setState(() {
                        if (!(selectedButton > 10)) {
                          selectedButton += 1.0;
                          isScrolled = false;
                        }
                      });
                    }
                  } else {
                    Future.delayed(Duration(seconds: 10), () {
                      setState(() {
                        isScrolled = true;
                      });
                    });
                  }
                }),
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              separatorBuilder: (ctx, index) => SizedBox(
                width: kmediumSpace,
              ),
              itemBuilder: (ctx, index) {
                return index == 0
                    ? SizedBox(
                        width: 5 * (_size.width / 12) - kmediumSpace,
                      )
                    : index == 11
                        ? SizedBox(
                            width: 5 * (_size.width / 12) - kmediumSpace,
                          )
                        : ClipOval(
                            child: AnimatedPadding(
                              duration: Duration(milliseconds: 300),
                              padding: EdgeInsets.all(0),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                height: _size.width / 6,
                                width: _size.width / 6,
                                decoration: BoxDecoration(
                                  color:
                                      index == 3 ? Colors.purple : Colors.blue,
                                  borderRadius:
                                      BorderRadius.circular(_size.width / 6),
                                ),
                              ),
                            ),
                          );
              },
              itemCount: 10 + 2,
            ),
          ),
          ClipPath(
            clipper: CustomRing(
                w: _size.width * 0.012,
                x: _size.width * 0.2,
                y: _size.width * 0.2),
            child: GestureDetector(
              onTap: widget.cameraCaptureTap,
              onLongPress: widget.cameraCaptureLongPress,
              onLongPressUp: widget.cameraCaptureLongPressUp,
              child: Container(
                height: _size.width * 0.2,
                width: _size.width * 0.2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
