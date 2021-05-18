import 'package:flutter/material.dart';

import 'package:login_bloc/src/screens/login/login_screen.dart';
import 'blocs/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Log me in',
        home: LoginScreen1(),
      ),
    );
  }
}
