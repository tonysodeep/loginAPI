import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_bloc/src/screens/login/login_screen.dart';

void main() {
  testWidgets("add a email", (WidgetTester tester) async {
    final addEmailField = find.byKey(ValueKey('emailField'));

    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(),
    ));
    await tester.enterText(addEmailField, "Email Testing");
    await tester.pump();
    expect(find.text("Email Testing"), find);
  });
}
