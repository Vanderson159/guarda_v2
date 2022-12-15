import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  final String message;


  Progress({this.message = 'Loading'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            CircularProgressIndicator(),
            SizedBox(height: 10,),
            Text(message)
          ],
        ),
      ),
    );
  }
}
