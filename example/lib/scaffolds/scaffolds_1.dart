import 'package:example/notifier/drawer_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:inner_drawer/inner_drawer.dart';
import 'package:provider/provider.dart';

class ScaffoldDrawer extends StatelessWidget {
  final GlobalKey<InnerDrawerState> innerDrawerKey;

  const ScaffoldDrawer({Key? key, required this.innerDrawerKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("scaffold 1");

    final drawer = Provider.of<DrawerNotifier>(context, listen: true);
    var pickerColor = drawer.colorTransition;

    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              ColorTween(
                begin: Colors.blueAccent,
                end: Colors.blueGrey.shade400.withRed(100),
              ).lerp(drawer.swipeOffset)!,
              ColorTween(
                begin: Colors.green,
                end: Colors.blueGrey.shade800.withGreen(80),
              ).lerp(drawer.swipeOffset)!,
            ],
          ),
        ),
        child: SafeArea(
            child: Material(
          color: Colors.transparent,
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.grey[100]),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  const Text(
                    "Animation Type",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Row(
                          children: <Widget>[
                            const Text('Static'),
                            Checkbox(
                                activeColor: Colors.black,
                                value: drawer.animationType ==
                                    InnerDrawerAnimation.static,
                                onChanged: (a) {
                                  drawer.setAnimationType(
                                      InnerDrawerAnimation.static);
                                }),
                          ],
                        ),
                        onTap: () {
                          drawer.setAnimationType(InnerDrawerAnimation.static);
                        },
                      ),
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Checkbox(
                                activeColor: Colors.black,
                                value: drawer.animationType ==
                                    InnerDrawerAnimation.linear,
                                onChanged: (a) {
                                  drawer.setAnimationType(
                                      InnerDrawerAnimation.linear);
                                }),
                            const Text('Linear'),
                          ],
                        ),
                        onTap: () {
                          drawer.setAnimationType(InnerDrawerAnimation.linear);
                        },
                      ),
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Checkbox(
                                activeColor: Colors.black,
                                value: drawer.animationType ==
                                    InnerDrawerAnimation.quadratic,
                                onChanged: (a) {
                                  drawer.setAnimationType(
                                      InnerDrawerAnimation.quadratic);
                                }),
                            const Text('Quadratic'),
                          ],
                        ),
                        onTap: () {
                          drawer
                              .setAnimationType(InnerDrawerAnimation.quadratic);
                        },
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Checkbox(
                                activeColor: Colors.black,
                                value: drawer.swipe,
                                onChanged: (a) {
                                  drawer.setSwipe(!drawer.swipe);
                                }),
                            const Text('Swipe'),
                          ],
                        ),
                        onTap: () {
                          drawer.setSwipe(!drawer.swipe);
                        },
                      ),
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Checkbox(
                                activeColor: Colors.black,
                                value: drawer.tapScaffold,
                                onChanged: (a) {
                                  drawer.setTapScaffold(!drawer.tapScaffold);
                                }),
                            const Text('TapScaffoldEnabled'),
                          ],
                        ),
                        onTap: () {
                          drawer.setTapScaffold(!drawer.tapScaffold);
                        },
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Checkbox(
                            activeColor: Colors.black,
                            value: drawer.onTapToClose,
                            onChanged: (a) {
                              drawer.setOnTapToClose(!drawer.onTapToClose);
                            }),
                        const Text('OnTap To Close'),
                      ],
                    ),
                    onTap: () {
                      drawer.setOnTapToClose(!drawer.onTapToClose);
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Column(
                    children: <Widget>[
                      const Text('Offset'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SliderTheme(
                            data: Theme.of(context).sliderTheme.copyWith(
                                  valueIndicatorTextStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.white),
                                ),
                            child: Slider(
                              activeColor: Colors.black,
                              //inactiveColor: Colors.white,
                              value: drawer.offset,
                              min: 0.0,
                              max: 1,
                              divisions: 5,
                              semanticFormatterCallback: (double value) =>
                                  value.round().toString(),
                              label: '${drawer.offset}',
                              onChanged: (a) {
                                drawer.setOffset(a);
                              },
                              onChangeEnd: (a) {
                                //_getwidthContainer();
                              },
                            ),
                          ),
                          Text(drawer.offset.toString()),
                          //Text(_fontSize.toString()),
                        ],
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  TextButton(
                    child: Text(
                      "Set Color Transition",
                      style: TextStyle(
                          color: drawer.colorTransition,
                          fontWeight: FontWeight.w500),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Pick a color!'),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: drawer.colorTransition,
                                onColorChanged: (Color color) =>
                                    pickerColor = color,
                                //enableLabel: true,
                                pickerAreaHeightPercent: 0.8,
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Set'),
                                onPressed: () {
                                  drawer.setColorTransition(pickerColor);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(25)),
                  ElevatedButton(
                    child: const Text("open"),
                    onPressed: () {
                      // direction is optional
                      // if not set, the last direction will be used
                      innerDrawerKey.currentState?.toggle();
                    },
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
