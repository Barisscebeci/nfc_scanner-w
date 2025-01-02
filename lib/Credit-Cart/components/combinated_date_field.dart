import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_app/Credit-Cart/components/input_formatters.dart';
import 'flutter_project_style.dart';

class CombinedDateField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final FormFieldValidator<String>? validate;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;

  const CombinedDateField({
    super.key,
    this.labelText,
    this.hintText,
    this.validate,
    this.onChanged,
    this.controller,
    this.inputFormatters,
  });

  @override
  _CombinedDateFieldState createState() => _CombinedDateFieldState();
}

class _CombinedDateFieldState extends State<CombinedDateField> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  String? errorText;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode.addListener(_onFocusChange);
    _controller.addListener(_onTextChanged);
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      setState(() {
        errorText = widget.validate?.call(_controller.text);
      });
    }
  }

  void _onTextChanged() {
    final text = _controller.text;
    if (text.length == 2 && !text.contains('/')) {
      _controller.value = TextEditingValue(
        text: '$text/',
        selection: TextSelection.collapsed(offset: text.length + 1),
      );
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: _controller,
      decoration: buildInputDecoration(
        labelText: widget.labelText ?? '',
        hintText: widget.hintText,
        errortext: errorText,
      ),
      maxLength: 5,
      style: ProjectStyle.projectTheme,
      keyboardType: TextInputType.number,
      inputFormatters: widget.inputFormatters ?? [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
        CardMonthInputFormatter(),
      ],
      onChanged: (value) {
        widget.onChanged?.call(value);
        setState(() {
          errorText = widget.validate?.call(value);
        });
      },
    );
  }
}
