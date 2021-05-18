import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/provider.dart';
import 'package:login_bloc/src/colors/constants.dart';
import 'package:login_bloc/src/widgets/text_field_container.dart';

class RoundedEmailField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  const RoundedEmailField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return TextFieldContainer(
      child: StreamBuilder<Object>(
        stream: bloc.email,
        builder: (context, snapshot) {
          return TextField(
            cursorColor: kPrimaryColor,
            onChanged: bloc.changeEmail,
            decoration: InputDecoration(
              icon: Icon(
                icon,
                color: kPrimaryColor,
              ),
              hintText: hintText,
              border: InputBorder.none,
              errorText: snapshot.error,
            ),
          );
        }
      ),
    );
  }
}
