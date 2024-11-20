import 'package:flutter/material.dart';

class ProgressAPI extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Animation<Color>? valueColor;

  ProgressAPI({
    Key? key,
    required this.child,
    required this.inAsyncCall,
    this.opacity = 0.6,
    this.color = Colors.grey,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          child, // Nội dung chính
          if (inAsyncCall)
            Stack(
              children: [
                Opacity(
                  opacity: opacity,
                  child: ModalBarrier(dismissible: false, color: color),
                ),
                Center(
                  child: CircularProgressIndicator(
                    valueColor: valueColor,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
