import 'package:chatme/ui/widgets/onboarding/logo.dart';
import 'package:flutter/material.dart';

import '../widgets/onboarding/profile_upload.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({ Key? key }) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        backgroundColor:Colors.transparent
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _logo(),
            Spacer(),
            ProfileUpload()
          ],

          )
        ),
      ),
    );
  }

  _logo() {

  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text('Laba',
    style: Theme.of(context).textTheme.
    headline4!.copyWith(fontWeight: FontWeight.bold),),

    SizedBox(width:8.0),

    Logo(),
    
    SizedBox(width:8.0),
        Text('Laba',
    style: Theme.of(context).textTheme.
    headline4!.copyWith(fontWeight: FontWeight.bold),),

    ],
  );

  }


}