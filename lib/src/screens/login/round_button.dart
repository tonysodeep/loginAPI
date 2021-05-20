import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/provider.dart';
import 'package:login_bloc/src/colors/constants.dart';
import 'package:login_bloc/src/screens/loading_screen.dart/loading_page.dart';
import 'package:overlay_screen/overlay_screen.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: StreamBuilder<Object>(
          stream: bloc.submitValid,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  backgroundColor: color,
                ),
                onPressed: null,
                child: Text(
                  text,
                  style: TextStyle(color: textColor),
                ),
              );
            } else {
              return TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  backgroundColor: color,
                ),
                onPressed: () {
                  bloc.submit();
                  var loadingPage = LoadingPage(context);
                  OverlayScreen().saveScreens({
                    'loading': loadingPage.showLoadingScreenLogin(context),
                  });
                  OverlayScreen().show(context, identifier: 'loading');
                },
                child: Text(
                  text,
                  style: TextStyle(color: textColor),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
