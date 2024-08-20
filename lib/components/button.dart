import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasksm_app/utils/custom_colors.dart';

enum ButtonType { primary, danger }

class Button extends StatelessWidget {
  final String _text;
  final ButtonType? _type;
  final void Function() _onPressed;

  const Button(
      {required String text,
      ButtonType? type,
      required void Function() onPressed,
      super.key})
      : _text = text,
        _type = type,
        _onPressed = onPressed;

  Color getButtonColor() {
    switch (_type) {
      case ButtonType.primary:
        return CustomColors.blueBaseButton;
      case ButtonType.danger:
        return CustomColors.redBaseButton;
      default:
        return CustomColors.blueBaseButton;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(getButtonColor()),
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        onPressed: _onPressed,
        child: Text(
          _text,
          style: GoogleFonts.roboto(
              fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
        ));
  }
}
