import 'package:chatable/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chatable/src/rust/frb_generated.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async => await RustLib.init());
  testWidgets('Can call rust function', (WidgetTester tester) async {
    await tester.pumpWidget(ChatableApp());
    expect(find.textContaining('Result: `Hello, Tom!`'), findsOneWidget);
  });
}
