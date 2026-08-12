import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';

/// A labeled dropdown field matching the text field styling.
class CustomDropdownField extends StatelessWidget {
  final String title;
  final String hintText;
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;

  const CustomDropdownField({
    super.key,
    required this.title,
    required this.hintText,
    required this.items,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(335),
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
            height: getProportionateHeight(56),
            child: DropdownButtonFormField<String>(
              initialValue: value,
              isExpanded: true,
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
              dropdownColor: AppColors.white,
              style: TextStyle(
                fontSize: getProportionateHeight(14),
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.w400,
              ),
              items: items
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}