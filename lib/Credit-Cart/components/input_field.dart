import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter_app/Credit-Cart/components/flutter_project_style.dart';

class InputField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final int? maxLength;
  final FormFieldValidator<String>? validate;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;

  const InputField({
    super.key,
    this.labelText,
    this.hintText,
    this.maxLength,
    this.validate,
    this.onChanged,
    this.keyboardType,
    this.controller,
    this.inputFormatters,
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final FocusNode _focusNode = FocusNode();
  String? errorText;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      setState(() {
        errorText = widget.validate?.call(widget.controller?.text ?? '');
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller,
      decoration: buildInputDecoration(
        labelText: widget.labelText ?? '',
        hintText: widget.hintText,
        errortext: errorText,
      ),
      style: ProjectStyle.projectTheme,
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
    );
  }
}
