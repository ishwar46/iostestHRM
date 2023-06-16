import 'package:flutter/material.dart';
import 'package:hrm/core/Styles/app_color.dart';

import '../Styles/dimension.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextInputType? textInputType;
  final double bottomPadding;
  final bool obscureText;
  final bool readOnly;
  final String suffixImage;
  final String prefixImage;
  void Function() ontap;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

   CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.bottomPadding = 16,
    this.obscureText = false,
    this.textInputType,
    required this.ontap,
    this.readOnly = false,
     required this.suffixImage,
   required this.prefixImage,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      margin: EdgeInsets.only(bottom: bottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label.isNotEmpty)
            Text(
              label,
              style: textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w600,
                //fontSize: 14,
              ),
            ),
          if (label.isNotEmpty) const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: TextFormField(
              style: textTheme.labelLarge!
                  .copyWith(color: AppColor.subtitleText, fontSize: 15),
              controller: controller,
              showCursor: false,
              maxLines: 1,
              keyboardType: TextInputType.text,
              obscureText: obscureText,
              readOnly: readOnly,
              validator: validator,
              decoration: InputDecoration(
                
                border:
                
                
                  OutlineInputBorder(
                   borderRadius: BorderRadius.circular(4),
               borderSide: BorderSide(color: AppColor.textfield.withOpacity(0.2)),
                 ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                   borderSide: BorderSide(color: AppColor.lighttextfield.withOpacity(0.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                borderSide:  BorderSide(color: AppColor.lighttextfield.withOpacity(0.2)),
                 ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                   borderSide: BorderSide(color: AppColor.lighttextfield.withOpacity(0.2)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                   borderSide: BorderSide(color: AppColor.lighttextfield.withOpacity(0.2)),
                ),
                fillColor: AppColor.lighttextfield.withOpacity(0.2),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 12,
                ),
                counterText: "",
                hintText: hintText,
                hintStyle: textTheme.titleLarge!.copyWith(
                  color: AppColor.textfield.withOpacity(0.2),
                  fontSize: 14,
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(Dimension.h8 ),
                  child: SizedBox(
                      height: Dimension.h2 * 11,
                      width: Dimension.h2 * 11,
                      child: Image.asset(
                         prefixImage)),
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: Dimension.h2 * 11,
                  minHeight: Dimension.h2 * 11,
                ),
                isDense: true,
                suffixIcon:
                 InkWell(
                  onTap: ontap,
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Image.asset(
                       
                        suffixImage,height: Dimension.h2 * 11,width: Dimension.h2 * 11,),
                   )
                 ),
                suffixIconConstraints: BoxConstraints(
                  minWidth: Dimension.h2 * 11,
                  minHeight: Dimension.h2 * 11,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
