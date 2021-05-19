import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:login_bloc/src/blocs/provider.dart';
import 'package:login_bloc/src/models/login_model.dart';
import 'package:overlay_screen/overlay_screen.dart';

class LoadingPage {

  BuildContext context1;
  LoadingPage(BuildContext context){
    context1 = context;
  }

  CustomOverlayScreen abc(BuildContext context) {
    return CustomOverlayScreen(
      backgroundColor: Colors.transparent,
      content: Dialog(
        child: SizedBox(
          height: 180.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'No internet connection!!',
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
                  builder:
                      (context, AsyncSnapshot<LoginResponseModel> snapshot) {
                    if (!snapshot.hasData)
                      return CircularProgressIndicator();
                    else if (snapshot.data.error.isEmpty) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushNamed(context, '/home');
                      });
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
      ),
    );
  }
}
