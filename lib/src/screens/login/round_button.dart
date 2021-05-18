import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/provider.dart';
import 'package:login_bloc/src/colors/constants.dart';


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
            return TextButton(
              style: TextButton.styleFrom(
               padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
               backgroundColor: color,
              ),
              onPressed: snapshot.hasData ? bloc.submit : null,
              child: Text(
                text,
                style: TextStyle(color: textColor),
              ),
            );
          }
        ),
      ),
    );
  }
}
