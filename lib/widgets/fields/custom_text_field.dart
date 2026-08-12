import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';

/// A labeled text field with a title above and hint text inside.
class CustomTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController? controller;
  final double? width;
  final double? height;

  const CustomTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? getProportionateScreenWidth(335),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: getProportionateHeight(14),
              color: AppColors.greyColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: getProportionateHeight(8)),
          SizedBox(
            height: height ?? getProportionateHeight(56),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: getProportionateHeight(14),
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.w400,
                ),
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16),
                  vertical: getProportionateHeight(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    getProportionateHeight(16),
                  ),
                  borderSide: const BorderSide(color: AppColors.greyColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    getProportionateHeight(16),
                  ),
                  borderSide: const BorderSide(color: AppColors.primaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}