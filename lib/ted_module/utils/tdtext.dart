import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TDText extends StatelessWidget {
  const TDText({
    Key? key,
    required this.message,
    this.textAlignment = Alignment.centerLeft,
    this.textColor = Colors.white,
    this.textWeight = FontWeight.w300,
    required this.textSize,
    this.textPadding = EdgeInsets.zero,
    this.maxLines = 1,
    this.textAlign = TextAlign.left,
    this.minSize = 14,
    this.textOverflow = TextOverflow.visible,
    this.textWrap = true,
    this.lineHeight = 1.2,
  }) : super(key: key);

  final String message;
  final Alignment textAlignment;
  final Color textColor;
  final FontWeight textWeight;
  final double textSize;
  final EdgeInsets textPadding; //EdgeInsets.fromLTRB(18, 0, 0, 0)
  final int maxLines;
  final TextAlign textAlign;
  final double minSize;
  final TextOverflow textOverflow;
  final bool textWrap;
  final double lineHeight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: textPadding,
      child: Align(
        alignment: textAlignment,
        child: AutoSizeText(
          message,
          textAlign: this.textAlign,
          maxLines: this.maxLines,
          minFontSize: minSize,
          overflow: textOverflow,
          softWrap: textWrap,
          style: TextStyle(
              color: textColor,
              fontWeight: textWeight,
              fontSize: textSize,
              decoration: TextDecoration.none,
              height: lineHeight),
        ),
      ),
    );
  }
}
