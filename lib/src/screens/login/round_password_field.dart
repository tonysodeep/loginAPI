import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/login_bloc.dart';
import 'package:login_bloc/src/blocs/provider.dart';
import 'package:login_bloc/src/colors/constants.dart';
import 'package:login_bloc/src/models/password_icon_event.dart';
import 'package:login_bloc/src/widgets/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  const RoundedPasswordField({
    this.hintText,
    this.icon = Icons.lock,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return TextFieldContainer(
      child: StreamBuilder<bool>(
        stream: bloc.obscureState,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          print(' password snap ${snapshot.data}');
          if (!snapshot.hasData){
            return createPassInputFieldShow(
              bloc,
            );
          } else if (snapshot.data) {
            return createPassInputFieldShow(bloc);
          } else {
            return createPassInputFieldHide(bloc);
          }
        },
      ),
    );
  }

  Widget createPassInputFieldShow(LoginBloc bloc) {
    var txt = TextEditingController();
    txt.text = bloc.getPassword();
    return StreamBuilder<Object>(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          obscureText: true,
          cursorColor: kPrimaryColor,
          onChanged: bloc.changePassword,
          controller: txt,
          decoration: InputDecoration(
            hintText: hintText,
            errorText: snapshot.error,
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                bloc.obscureEvent.add(PasswordIconHideEvent());
                bloc.setPassword(txt.text);
              },
              child: Icon(
                Icons.visibility,
                color: kPrimaryColor,
              ),
            ),
            border: InputBorder.none,
          ),
        );
      },
    );
  }

  Widget createPassInputFieldHide(LoginBloc bloc) {
    var txt = TextEditingController();
    txt.text = bloc.getPassword();
    return StreamBuilder<Object>(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          obscureText: false,
          cursorColor: kPrimaryColor,
          onChanged: bloc.changePassword,
          controller: txt,
          decoration: InputDecoration(
            hintText: hintText,
            errorText: snapshot.error,
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                bloc.obscureEvent.add(PasswordIconShowEvent());
                bloc.setPassword(txt.text);
              },
              child: Icon(
                Icons.visibility_off,
                color: kPrimaryColor,
              ),
            ),
            border: InputBorder.none,
          ),
        );
      },
    );
  }
}
