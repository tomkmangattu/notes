import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  TitleText({@required this.size, @required this.con});
  final double size;
  final bool con;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          'KTU Help',
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontSize: size * 0.7,
            color: con ? Colors.black : Colors.white,
          ),
        ),
        Text(
          'Together we learn',
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontSize: size * 0.3,
            color: con ? Colors.black : Colors.white,
          ),
        ),
      ],
    );
  }
}
