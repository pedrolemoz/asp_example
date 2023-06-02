import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class InputText extends StatelessWidget {
  final bool hideText;
  final String initialValue;
  final Function(String) onChanged;
  final bool hasError;
  final String? errorText;
  final String? hintText;
  final bool showVisibilityToggle;
  final Function()? onVisibilityToggle;

  const InputText({
    super.key,
    this.hideText = false,
    this.showVisibilityToggle = false,
    required this.initialValue,
    required this.onChanged,
    required this.hasError,
    this.errorText,
    this.hintText,
    this.onVisibilityToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hideText,
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: showVisibilityToggle && onVisibilityToggle != null
            ? GestureDetector(
                onTap: onVisibilityToggle,
                child: Icon(
                  hideText ? UniconsLine.eye_slash : UniconsLine.eye,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              )
            : null,
        isDense: true,
        errorText: hasError ? errorText : null,
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(32),
          ),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
    );
  }
}
