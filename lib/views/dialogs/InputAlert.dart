import 'dart:developer';

import 'package:bnaa/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputAlert extends StatefulWidget {
  String title;
  String? hint;
  TextInputType? inputType;
  var initValue;
  void Function(String) onSubmit;
  InputAlert(this.title,
      {Key? key,
      required this.onSubmit,
      this.hint = "Write",
      this.initValue,
      this.inputType = TextInputType.number})
      : super(key: key);

  @override
  State<InputAlert> createState() => _InputAlertState();
}

class _InputAlertState extends State<InputAlert> {
  String valInput = "";
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    controller.text =
        (widget.initValue != null ? getQty(qty: widget.initValue.toString()) : "")
            .toString();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          headElert(),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: controller,
            keyboardType: widget.inputType,
            style: const TextStyle(fontSize: 14),
            onChanged: (value) {
              log(value);
              valInput = value;
            },
            decoration: const InputDecoration(
              hintStyle: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          btnWidget(context),
        ],
      ),
    );
  }

  Row btnWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButtomApp(
            'Save'.tr,
            onTap: () {
              widget.onSubmit(valInput);
              Navigator.pop(context);
            },
          ),
          flex: 1,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: CustomButtomApp(
            'Close'.tr,
            linearGradientPrimary: false,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          flex: 1,
        ),
      ],
    );
  }

  Widget CustomButtomApp(val,
      {bool? linearGradientPrimary = true, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: linearGradientPrimary == true
                ? Color.fromARGB(255, 30, 70, 90)
                : Color.fromARGB(255, 92, 123, 139).withOpacity(.1)),
        child: Text(
          '$val',
          style: TextStyle(
              color:
                  linearGradientPrimary != true ? Colors.black : Colors.white),
        ),
      ),
    );
  }

  Row headElert() {
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        Text(
          widget.title,
          style: TextStyle(color: Color.fromRGBO(52, 103, 128, 1)),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}
