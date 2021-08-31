import 'package:flutter/cupertino.dart';

class TitleLoginPage extends StatelessWidget {
  final String title;
  final double size;
  final Color color;
  const TitleLoginPage({
    Key? key,
    required this.title,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        style: TextStyle(
          fontSize: size,
          color: color,
          fontWeight: FontWeight.w900
        ),
      ),
    );
  }
}
