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
    this.textinputType,
    this.isPrefix = false,
    this.sufickcallback,
    this.superfixicon,
  });

  final TextEditingController? titleController;
  final String title;
  final String hintText;
  final dynamic validators;
  final TextInputType? textinputType;
  final bool isPrefix;
  final VoidCallback? sufickcallback;
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
                      onPressed: sufickcallback,
                      icon: Icon(
                        superfixicon,
                        color: kprimarycolor,
                      ))
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

class CustomeInputWithdrop extends StatelessWidget {
  const CustomeInputWithdrop({
    super.key,
    this.titleController,
    required this.title,
    required this.hintText,
    required this.suffix,
  });

  final TextEditingController? titleController;
  final String title;
  final String hintText;

  final Widget suffix;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        style: kQuestrialRegular.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: SizeConfig.blockSizeHorizantal! * 6),
      ),
      SizedBox(
        height: SizeConfig.blockSizeVertical! * 1,
      ),
      Container(
        height: 65,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), border: Border.all()),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              hintText,
              style: kQuestrialRegular.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.blockSizeHorizantal! * 4.5),
            ),
            suffix
          ]),
        ),
      )
    ]);
  }
}
