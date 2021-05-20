import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:login_bloc/src/blocs/provider.dart';
import 'package:login_bloc/src/models/login_model.dart';
import 'package:overlay_screen/overlay_screen.dart';

class LoadingPopUp extends StatelessWidget {
  final BuildContext context1;
  LoadingPopUp({this.context1});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 180.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Logining up!!',
              style: TextStyle(
                fontSize: 25.0,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            Text(
              "waiting..",
              style: TextStyle(
                fontSize: 15.0,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            SizedBox(
              height: 20.0,
              width: 20.0,
              child: StreamBuilder<LoginResponseModel>(
                stream: Provider.of(context).authValidation,
                builder: (context, AsyncSnapshot<LoginResponseModel> snapshot) {
                  if (!snapshot.hasData)
                    return CircularProgressIndicator();
                  else if (snapshot.data.error.isEmpty) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushNamed(context, '/home');
                    });
                    OverlayScreen().pop();
                    return Container();
                  } else {
                    OverlayScreen().pop();
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) {
                        Scaffold.of(context1).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Error'),
                          ),
                        );
                      },
                    );
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
