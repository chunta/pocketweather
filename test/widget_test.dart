import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_weather/view/thai_famous_city_widget.dart';
import 'thai_view_model_mock.dart';

void main() {
  testWidgets('ThaiFamousCityBodyWidget test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      final ThaiViewModelMock mock = ThaiViewModelMock();
      mock.title = "mock title";
      mock.numberOfForecastDay = 6; 
      await tester.pumpWidget(MaterialApp(
        home: ThaiParentWidget(viewModel: mock),
      ));

      final body = find.byType(ThaiFamousCityBodyWidget);
      expect(body, findsOneWidget);

      final center = find.descendant(of: body, matching: find.byType(Center));
      expect(center, findsOneWidget);

      await Future.delayed(const Duration(seconds: 2));
      await tester.pump();

      final listViewFinder = find.byKey(const Key("TheListViewICare"));
      expect(listViewFinder, findsOneWidget);
      expect(find.text(mock.title), findsOneWidget);

      final listView = tester.widget<ListView>(listViewFinder);
      expect(listView.childrenDelegate.estimatedChildCount, mock.numberOfForecastDay);
    });
  });
}