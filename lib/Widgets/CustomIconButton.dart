import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget {
  final IconData icon;
  final Color fillColor;
  final double iconSize;
  final Function onPress;

  const CustomIconButton(
      {Key key,
      this.icon,
      this.fillColor,
      this.iconSize,
      @required this.onPress})
      : super(key: key);
  @override
  _CustomIconButtonState createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.icon ?? Icons.close,
        color: pressed ? widget.fillColor ?? Colors.blue : Colors.cyan[200],
      ),
      iconSize: widget.iconSize ?? 15,
      onPressed: () async {
        setState(() => {
              if (pressed != true) {pressed = true}
            });
        // call the callback that was passed in from the parent widget
        widget.onPress();
      },
    );
  }
}
