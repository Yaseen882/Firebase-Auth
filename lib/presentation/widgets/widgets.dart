import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configuration.dart';

// All Reusable widget

// Reusable Form Field
class InputFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Icon? icon;
  final bool? obscureText;
  final Widget? suffixWidget;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autoFocus;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final bool readOnly;
  const InputFormField(
      {Key? key,
      this.labelText,
      this.hintText,
      this.readOnly = false,
      this.icon,
      this.autoFocus = false,
      this.obscureText = false,
      this.validator,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.suffixWidget,
      this.textInputAction = TextInputAction.next,
      this.inputFormatters,
      this.onTap,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0, bottom: 8.0),
      child: TextFormField(
        readOnly: readOnly,
        focusNode: focusNode,
        onTap: onTap,
        inputFormatters: inputFormatters,
        autofocus: autoFocus,
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        textCapitalization: TextCapitalization.words,
        obscureText: obscureText!,
        enableSuggestions: true,
        decoration: InputDecoration(
          suffix: suffixWidget,

          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorSchema.blue),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          fillColor: ColorSchema.inputFieldFillColor,
          // filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintText: hintText,
          prefixIcon: icon,
        ),
      ),
    );
  }
}

// Reusable Button

Widget formButton(
    {double? width,
    double? height,
    required Widget child,
    required VoidCallback onPress,
    VoidCallback? onLongPress}) {
  return ElevatedButton(onPressed: onPress, child: child);
}

/// Auth page Container
class BezierContainer extends StatelessWidget {
  const BezierContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 3.5,
      child: ClipPath(
        clipper: _ClipPainter(),
        child: Container(
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff635570), Color(0xff1795C2)])),
        ),
      ),
    );
  }
}

class _ClipPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;
    var path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, height);
    path.lineTo(size.width, 0);

    /// [Top Left corner]
    var secondControlPoint = const Offset(0, 0);
    var secondEndPoint = Offset(width * .2, height * .3);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    /// [Left Middle]
    var fifthControlPoint = Offset(width * .3, height * .5);
    var fifthEndPoint = Offset(width * .23, height * .6);
    path.quadraticBezierTo(fifthControlPoint.dx, fifthControlPoint.dy,
        fifthEndPoint.dx, fifthEndPoint.dy);

    /// [Bottom Left corner]
    var thirdControlPoint = Offset(0, height);
    var thirdEndPoint = Offset(width, height);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant oldClipper) => true;
}

Widget backButton() {
  return InkWell(
    onTap: () {
      //Navigator.pop(context);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
            child: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
          ),
          const Text('Back',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
        ],
      ),
    ),
  );
}

Widget tabButton({
  double? height,
  double? width,
  required String? label,
}) {
  return Container(
    height: height,
    width: width,
    padding: const EdgeInsets.symmetric(vertical: 10),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2)
        ],
        gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff635570), Color(0xff1795C2)])),
    child: Text(
      label!,
      style: GoogleFonts.poppins(fontSize: 15, color: Colors.white),
    ),
  );
}

Future<void> showDeleteWarningDialog(
    {required BuildContext context, VoidCallback? onTap}) async {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Warning'),
            scrollable: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Container(
              alignment: Alignment.center,
              child: const Text('Are you sure'),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: onTap,
                child: const Text('Delete'),
              ),
            ],
          ));
}
