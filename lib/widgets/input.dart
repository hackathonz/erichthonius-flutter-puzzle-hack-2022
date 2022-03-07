import 'package:flutter/material.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kPaddingBetweenLabelAndForm = EdgeInsets.symmetric(
  vertical: 4.0,
);

final inputDecorationTheme = InputDecorationTheme(
  alignLabelWithHint: false,
  border: OutlineInputBorder(
    borderSide: inputDecorationBorderSide,
    borderRadius: BorderRadius.circular(
      kInputDecorationBorderRadius,
    ),
  ),
  fillColor: inputDecorationFillColor,
  focusColor: inputDecorationFillColor,
  hoverColor: inputDecorationFillColor,
  labelStyle: inputBorderLabelTextStyle,
  hintStyle: inputBorderHintTextStyle,
  errorBorder: OutlineInputBorder(
    borderSide: inputDecorationErrorBorderSide,
    borderRadius: BorderRadius.circular(
      kInputDecorationBorderRadius,
    ),
  ),
  errorStyle: inputBorderErrorTextStyle,
  floatingLabelBehavior: FloatingLabelBehavior.always,
  filled: true,
);

class SwapItTextFormInput extends StatelessWidget {
  final TextEditingController controller;

  final String label;

  final String? hint;

  final String? Function(String?)? validator;

  const SwapItTextFormInput({
    Key? key,
    required final this.controller,
    required final this.label,
    final this.hint,
    final this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: inputBorderLabelTextStyle,
        ),
        const Padding(
          padding: _kPaddingBetweenLabelAndForm,
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
          ),
          validator: validator,
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
