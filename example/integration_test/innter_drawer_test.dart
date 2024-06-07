import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inner_drawer/inner_drawer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// An example app integration test when your app uses the swipe drawer widget in its UI. It might help you to programmatically navigate to other widgets you want to test.
// The drawer package has its own suite of tests to assert correct behaviour, so you do not have to test the drawer behavior.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const tWidgetSize = Size(720.0, 1280.0);

  group('Demo end-to-end test', () {
    testWidgets(
        'Should show left child when swiped from left to the middle of screen',
        (tester) async {
      final RenderView renderView = WidgetsBinding.instance.renderViews.single;
      renderView.configuration = TestViewConfiguration.fromView(
        size: tWidgetSize,
        view: tester.view,
      );

      runApp(
        const MaterialApp(
          home: InnerDrawer(
            scaffold: Scaffold(
              body: Text('Home'),
            ),
            leftChild: SizedBox(
              child: Text('Left Child'),
            ),
            rightChild: SizedBox(
              child: Text('Right Child'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.drag(
        find.byType(InnerDrawer),
        Offset(tWidgetSize.width / 2, 0),
      );
      await tester.pumpAndSettle();
      expect(find.text('Left Child').hitTestable(), findsOneWidget);
      expect(find.text('Right Child'), findsNothing);

      expect(find.text('Home').hitTestable(), findsNothing);
    });
  });
}
