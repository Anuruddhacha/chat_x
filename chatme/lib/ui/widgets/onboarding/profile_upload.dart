import 'package:chatme/theme.dart';
import 'package:flutter/material.dart';

class ProfileUpload extends StatelessWidget {

  const ProfileUpload();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 126,
      width: 126,
      child: Material(
        color: isLightTheme(context) ?  Color(0xFF2F2F): Color(0xFF211E1E),
        borderRadius: BorderRadius.circular(126.0),
        child: InkWell(
          onTap: (){
            
          },
        ),
      ),
    );
  }
}