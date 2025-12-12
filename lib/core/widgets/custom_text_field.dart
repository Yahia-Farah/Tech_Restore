import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onPressed;
  final String? label;
  final String? hint;
  final String? suffixText;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool enabled;
  final bool readonly;
  final bool showUploadIcon;
  final String? initialText;
  final Widget? prefixIcon;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
    this.onPressed,
    this.label,
    this.hint,
    this.suffixText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.readonly = false,
    this.initialText,
    this.showUploadIcon = false,
    this.prefixIcon,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isTextObscured;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    isTextObscured = widget.obscureText;
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      enabled: widget.enabled,
      readOnly: widget.readonly,
      keyboardType: widget.keyboardType,
      onTap: widget.readonly ? (widget.onPressed) : null,
      validator: widget.validator,
      onChanged: widget.onChanged,
      obscureText: isTextObscured,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.grey, // Light background
        hintText: widget.hint ?? widget.label,
        hintStyle: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none, // Removes border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon:
            widget.obscureText
                ? IconButton(
                  icon: Icon(
                    isTextObscured ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey.shade600,
                  ),
                  onPressed: () {
                    setState(() {
                      isTextObscured = !isTextObscured;
                    });
                  },
                )
                : null,
      ),
    );
  }
}
