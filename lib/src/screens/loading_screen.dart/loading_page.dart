import 'package:flutter/material.dart';

import 'package:login_bloc/src/widgets/loading_pop_up.dart';
import 'package:overlay_screen/overlay_screen.dart';

class LoadingPage {
  BuildContext context1;
  LoadingPage(BuildContext context) {
    context1 = context;
  }

  CustomOverlayScreen showLoadingScreenLogin(BuildContext context) {
    return CustomOverlayScreen(
      backgroundColor: Colors.transparent,
      content: LoadingPopUp(
        context1: context1,
      ),
    );
  }
}
