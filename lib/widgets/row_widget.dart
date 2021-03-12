import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      constrained: false,
      child: Card(
        elevation: 5.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'confessor name',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              'status',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              'last date',
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
