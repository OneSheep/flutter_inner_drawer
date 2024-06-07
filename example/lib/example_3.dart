import 'package:flutter/material.dart';
import 'package:inner_drawer/inner_drawer.dart';

class ExampleThree extends StatefulWidget {
  const ExampleThree({Key? key}) : super(key: key);

  @override
  ExampleThreeState createState() => ExampleThreeState();
}

class ExampleThreeState extends State<ExampleThree> {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  final double _borderRadius = 50;

  @override
  void initState() {
    myFocusNode = FocusNode();
    myFocusNode2 = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode?.dispose();
    myFocusNode2?.dispose();
    super.dispose();
  }

  Color currentColor = Colors.black54;

  FocusNode? myFocusNode;
  FocusNode? myFocusNode2;

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: _innerDrawerKey,
      onTapClose: true,
      //tapScaffoldEnabled: true,
      borderRadius: _borderRadius,
      swipeChild: true,
      leftAnimationType: InnerDrawerAnimation.quadratic,
      leftChild: Material(
          color: Theme.of(context).colorScheme.surface,
          child: Center(
            child: SizedBox(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Left Child",
                  style: TextStyle(fontSize: 18),
                ),
                TextField(
                  focusNode: myFocusNode2,
                ),
                /*ListView.builder(
                  itemCount: 5,
                  itemBuilder:(BuildContext context, int index){
                    return ListTile(title: Text('test $index'),);
                  },
                )*/
              ],
            )),
          )),
      scaffold: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            //stops: [0.1, 0.5,0.5, 0.7, 0.9],
            colors: [
              Colors.green.shade200,
              Colors.green.shade500,
            ],
          ),
        ),
        child: SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Container(
                height: double.infinity,
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    TextField(
                      focusNode: myFocusNode,
                    ),
                    const TextField(
                        //  focusNode: myFocusNode,
                        ),
                  ],
                )),
          ),
        ),
      ),
      innerDrawerCallback: (a) {
        print(a);
        if (a) {
          myFocusNode2?.requestFocus();
        } else {
          myFocusNode?.requestFocus();
        }
      },
    );
  }
}
