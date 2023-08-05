import 'package:bnaa/utils/ui_helper.dart';
import 'package:bnaa/utils/validate.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputTextField extends StatefulWidget {
  String hintText;
  String? initValue;
  Function? valueStater;
  bool? isPhone;
  TextInputType? keyboardType;
  int? maxLines;
  Widget? prefix;
  Widget? suffix;
  bool? obscureText = false;

  InputTextField(
      {required this.hintText,
      this.initValue,
      this.valueStater,
      this.isPhone = false,
      this.keyboardType,
      this.prefix,
      this.suffix,
      this.obscureText = false,
      this.maxLines = 1});

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  TextEditingController? textController;

  @override
  void initState() {
    super.initState();
    if (widget.initValue != null) {
      textController = TextEditingController(text: widget.initValue);
    }
  }

  @override
  void dispose() {
    if (textController != null) textController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText ?? false,
      style: TextStyle(fontSize: 14.sp),
      validator: (value) {
        if (value != null &&
            widget.isPhone == true &&
            !phoneNumberValidator(value)) {
          return "Vous devez entrer un numéro de téléphone valide";
        }
        if (widget.valueStater != null) {
          if (Validate.requiredField(value!, 'Champ obligatoire') == null) {
            widget.valueStater!(value.trim());
          }
        }
        return Validate.requiredField(value!, 'Champ obligatoire');
      },
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefix: widget.prefix,
        suffix: widget.suffix,
        hintStyle: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    );
  }
}
