import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/colors/app_colors.dart';

import '../bloc/app_bloc/app_bloc.dart';
import '../bloc/app_bloc/app_event.dart';
import '../bloc/app_bloc/app_state.dart';

class InputField extends StatefulWidget {
  bool isAbscure;
  final Color bColor;
  final Widget? label;
  final Widget? hint;
  final bool isSuffix;
  Widget suffIcon;
  final bool isPrefix;
  final Widget preIcon;
  final String? Function(String?)? val;
  final TextEditingController con;

  InputField({super.key, required this.bColor, required this.hint, required this.label, required this.isAbscure, required this.isPrefix, required this.isSuffix, required this.preIcon, required this.suffIcon, required this.val, required this.con});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool isAbscure1;
  late Widget suffixIcon1;

  @override
  void initState() {
    super.initState();
    isAbscure1 = widget.isAbscure;
    suffixIcon1 = widget.suffIcon;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) => TextFormField(
        obscureText: isAbscure1,
        cursorColor: grey,
        controller: widget.con,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.val,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(19.76.w, 15.81.w, 19.76.w, 15.81.w),
          fillColor: widget.bColor,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(35.r),
              borderSide: BorderSide.none),
          label: widget.label,
          hint: widget.hint,
          suffixIcon: widget.isSuffix ? IconButton(onPressed: (){
            setState(() {
              isAbscure1 = !isAbscure1;
              suffixIcon1 = isAbscure1
                  ? const Icon(Icons.visibility_off_outlined)
                  : const Icon(Icons.visibility_outlined);
            });

            context.read<AppBloc>().add(ChangeVisibility(
              suffixIcon: suffixIcon1,
              isAbscure: isAbscure1,
            ));
          },
              icon: suffixIcon1) : SizedBox(),
          prefixIcon: widget.isPrefix ? widget.preIcon : SizedBox(),
        ),
      ),
    );
  }
}