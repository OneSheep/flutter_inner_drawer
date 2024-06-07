import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inner_drawer/inner_drawer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tWidgetSize = Size(720.0, 1280.0);
  group('InnerDrawer', () {
    testWidgets(
      'Should throw assertion error if both left and right child is null',
      (
        WidgetTester tester,
      ) async {
        final RenderView renderView =
            WidgetsBinding.instance.renderViews.single;
        renderView.configuration = TestViewConfiguration.fromView(
          size: tWidgetSize,
          view: tester.view,
        );

        expect(() {
          InnerDrawer(
            scaffold: const Scaffold(),
          );
        }, throwsAssertionError);
      },
    );

    testWidgets(
      "A single child should be hidden behind the Scaffold",
      (
        WidgetTester tester,
      ) async {
        final RenderView renderView =
            WidgetsBinding.instance.renderViews.single;
        renderView.configuration = TestViewConfiguration.fromView(
          size: tWidgetSize,
          view: tester.view,
        );

        await tester.pumpWidget(
          const MaterialApp(
            home: InnerDrawer(
              scaffold: Scaffold(
                body: Text('Home'),
              ),
              leftChild: SizedBox(
                child: Text('Left Child'),
              ),
            ),
          ),
        );

        expect(find.text('Left Child'), findsOneWidget);
        expect(find.text('Left Child').hitTestable(), findsNothing);

        expect(find.text('Home'), findsOneWidget);
        expect(find.text('Home').hitTestable(), findsOneWidget);
      },
    );

    testWidgets(
      "Only one child is rendered at a time.",
      (
        WidgetTester tester,
      ) async {
        final RenderView renderView =
            WidgetsBinding.instance.renderViews.single;
        renderView.configuration = TestViewConfiguration.fromView(
          size: tWidgetSize,
          view: tester.view,
        );

        await tester.pumpWidget(
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

        expect(find.text('Left Child'), findsOneWidget);
        expect(find.text('Right Child'), findsNothing);
      },
    );

    testWidgets(
      "Scaffold should move to side and show focused Left Child when swiped "
      "from Left to the middle of the screen",
      (
        WidgetTester tester,
      ) async {
        final RenderView renderView =
            WidgetsBinding.instance.renderViews.single;
        renderView.configuration = TestViewConfiguration.fromView(
          size: tWidgetSize,
          view: tester.view,
        );

        await tester.pumpWidget(
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
        await tester.drag(
          find.byType(InnerDrawer),
          Offset(tWidgetSize.width / 2, 0),
        );
        await tester.pumpAndSettle();
        expect(find.text('Left Child').hitTestable(), findsOneWidget);

        expect(find.text('Home').hitTestable(), findsNothing);
      },
    );

    testWidgets(
      "Scaffold should move back to center and overlay left child if the "
      "drag (left to right) is not perform until the middle of screen",
      (
        WidgetTester tester,
      ) async {
        final RenderView renderView =
            WidgetsBinding.instance.renderViews.single;
        renderView.configuration = TestViewConfiguration.fromView(
          size: tWidgetSize,
          view: tester.view,
        );

        await tester.pumpWidget(
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
        await tester.drag(
          find.byType(InnerDrawer),
          Offset(tWidgetSize.width / 3, 0),
        );
        await tester.pumpAndSettle();
        expect(find.text('Left Child'), findsOneWidget);
        expect(find.text('Left Child').hitTestable(), findsNothing);

        expect(find.text('Home').hitTestable(), findsOneWidget);
      },
    );

    testWidgets(
      "Scaffold should move to side and show focused Right Child when swiped "
      "from Right to the middle of the screen",
      (
        WidgetTester tester,
      ) async {
        final RenderView renderView =
            WidgetsBinding.instance.renderViews.single;
        renderView.configuration = TestViewConfiguration.fromView(
          size: tWidgetSize,
          view: tester.view,
        );

        await tester.pumpWidget(
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
        await tester.drag(
          find.byType(InnerDrawer),
          Offset(-(tWidgetSize.width / 2), 0),
        );
        await tester.pumpAndSettle();
        expect(find.text('Right Child').hitTestable(), findsOneWidget);

        expect(find.text('Home').hitTestable(), findsNothing);
      },
    );

    testWidgets(
      "Scaffold should move back to center and overlay right child if the "
      "drag (right to left) is not perform until the middle of screen",
      (
        WidgetTester tester,
      ) async {
        final RenderView renderView =
            WidgetsBinding.instance.renderViews.single;
        renderView.configuration = TestViewConfiguration.fromView(
          size: tWidgetSize,
          view: tester.view,
        );

        await tester.pumpWidget(
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
        await tester.drag(
          find.byType(InnerDrawer),
          Offset(-(tWidgetSize.width / 3), 0),
        );
        await tester.pumpAndSettle();
        expect(find.text('Right Child'), findsOneWidget);
        expect(find.text('Right Child').hitTestable(), findsNothing);

        expect(find.text('Home').hitTestable(), findsOneWidget);
      },
    );
  });
}
