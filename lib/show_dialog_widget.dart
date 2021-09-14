
import 'package:flutter/material.dart';

class ShowDialogWidget extends StatelessWidget {

  final String titleText;
  final String subText;
  final Color borderColor;

  ShowDialogWidget({this.titleText,this.subText,this.borderColor});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius:
          new BorderRadius
              .circular(18.0),
          side: BorderSide(
            color: borderColor,
          )),
      title: Text(titleText),
      content: Text(subText),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "OK",
            style: TextStyle(
                color:
                borderColor),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}