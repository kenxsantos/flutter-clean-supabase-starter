import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    required this.text,
    this.isPassword = false,
    this.icon,
    required this.controller,
    this.validator,
    super.key,
  });

  final String text;
  final IconData? icon;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      child: TextFormField(
        validator: widget.validator,
        obscureText: _obscureText,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: _toggleVisibility,
                )
              : widget.icon != null
              ? Icon(widget.icon)
              : null,
          labelText: widget.text,
          labelStyle: const TextStyle(fontSize: 12, color: Colors.grey),
          filled: true,
          fillColor: const Color(0xFFE7E7E7),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 25.0,
            horizontal: 20.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none, // remove default border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 114, 114, 114),
              width: 1,
            ),
          ),
        ),
        style: const TextStyle(fontSize: 16), // adjusts text size
      ),
    );
  }
}
