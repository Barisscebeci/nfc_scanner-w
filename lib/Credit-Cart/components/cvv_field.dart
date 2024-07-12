



import 'package:flutter/material.dart';
import 'package:my_flutter_app/Credit-Cart/components/flutter_project_style.dart';

class CvvField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final FormFieldValidator<String>? validate;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const CvvField({
    super.key,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.validate,
    this.controller, 
    
  });

  @override
  _CvvFieldState createState() => _CvvFieldState();
}

class _CvvFieldState extends State<CvvField> {
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _controller;
  String? errorText;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      setState(() {
        errorText = widget.validate?.call(_controller.text);
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: _controller,
      decoration: buildCvvDecoration(
        labelText: widget.labelText ?? '',
        hintText: widget.hintText,
        icon: Icons.credit_card,
        errortext: errorText,
      ),
      style: ProjectStyle.projectTheme,
      keyboardType: TextInputType.number,
      validator: widget.validate,
      onChanged: widget.onChanged,
      maxLength: 3,
    );
  }
}
