import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_bloc/src/blocs/login_bloc.dart';
import 'package:login_bloc/src/blocs/provider.dart';
import 'package:login_bloc/src/colors/constants.dart';
import 'package:login_bloc/src/models/login_model.dart';
import 'package:login_bloc/src/screens/login/round_button.dart';
import 'package:login_bloc/src/screens/login/round_email_field.dart';
import 'package:login_bloc/src/screens/login/round_password_field.dart';

import '../../widgets/background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedEmailField(
              hintText: 'Email',
            ),
            RoundedPasswordField(
              hintText: 'Password',
            ),
            RoundedButton(
              text: 'LOGIN',
            ),
            sampleContainer(Provider.of(context))
          ],
        ),
      ),
    );
  }
   Widget sampleContainer(LoginBloc bloc) {
    return StreamBuilder<LoginResponseModel>(
      builder: (context, AsyncSnapshot<LoginResponseModel> snapshot) {
        if (snapshot.hasData) {
          return Text('${snapshot.data.token} and ${snapshot.data.error}');
        } else
          return Text('no data ');
      },
      stream: bloc.authValidation,
    );
  }
}
