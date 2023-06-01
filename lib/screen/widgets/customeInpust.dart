import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';
import '../../utils/sizeconfig.dart';

class CustomeInput extends StatelessWidget {
  const CustomeInput({
    super.key,
    this.titleController,
    required this.title,
    required this.hintText,
    this.validators,
    required this.textinputType,
    this.isPrefix = false,
    this.sufickclassbacl,
    this.superfixicon,
  });

  final TextEditingController? titleController;
  final String title;
  final String hintText;
  final dynamic validators;
  final TextInputType textinputType;
  final bool isPrefix;
  final VoidCallback? sufickclassbacl;
  final IconData? superfixicon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: kQuestrialRegular.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: SizeConfig.blockSizeHorizantal! * 6),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical! * 1,
        ),
        TextFormField(
          validator: validators,
          controller: titleController,
          decoration: InputDecoration(
              // isPrefix?Prefix
              suffixIcon: isPrefix
                  ? IconButton(
                      onPressed: sufickclassbacl, icon: Icon(superfixicon))
                  : null,
              hintText: hintText,
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        )
      ]),
    );
  }
}
