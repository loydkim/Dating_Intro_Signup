import 'dart:io';

import 'package:flutter/material.dart';

class DatingMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async { exit(0);},
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Dating App Main!'),
        ),
        body: Center(child: Text('Dating app Main'))
      ),
    );
  }
}
