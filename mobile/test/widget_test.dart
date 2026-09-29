import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/main.dart';

void main() {
  testWidgets('App smoke test initializes correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: RentWiseApp(),
      ),
    );

    // Verify RentWiseApp mounts successfully
    expect(find.byType(RentWiseApp), findsOneWidget);
  });
}
