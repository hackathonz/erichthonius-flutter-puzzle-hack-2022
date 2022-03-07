import 'package:flutter/material.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kPaddingBetweenLabelAndForm = EdgeInsets.symmetric(
  vertical: 4.0,
);

const _kPaddingBetweenFormAndErrorText = EdgeInsets.only(
  top: 8.0,
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

  final String? errorText;

  final bool showTrailingIcon;

  final void Function(String)? onChanged;

  final void Function()? onTrailingIconPressed;

  const SwapItTextFormInput({
    Key? key,
    required final this.controller,
    required final this.label,
    final this.hint,
    final this.errorText,
    final this.onChanged,
    final this.onTrailingIconPressed,
    final this.showTrailingIcon = false,
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
            fillColor: errorText != null ? inputDecorationErrorFillColor : null,
            suffixIcon: showTrailingIcon
                ? Center(
                    child: IconBase(
                      key: const Key('text_form_input_close_icon'),
                      child: const Icon(
                        SwapItIcons.close,
                        size: kIconInputTrailingIconSize,
                      ),
                      onPressed: onTrailingIconPressed!,
                      diameter: kIconBaseInputTrailingIconDiameter,
                    ),
                  )
                : null,
            suffixIconConstraints: BoxConstraints.tight(
              const Size.square(
                kIconBaseInputTrailingIconDiameter * 2,
              ),
            ),
          ),
          onChanged: onChanged,
          style: inputBorderTextStyle,
        ),
        if (errorText != null)
          Padding(
            padding: _kPaddingBetweenFormAndErrorText,
            child: Text(
              errorText!,
              style: inputBorderErrorTextStyle,
            ),
          ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
