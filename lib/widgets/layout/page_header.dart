import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';

/// Reusable branded header used across the operation screens.
///
/// Mirrors the header block from the existing screens: a rounded container
/// with a background SVG, an optional Back button, a [title] and an optional
/// vessel [name] / [code] pair.
class PageHeader extends StatelessWidget {
  final String title;
  final String? name;
  final String? code;
  final bool showBack;
  final FontWeight titleFontWeight;
  final Color titleColor;
  final double topHeight;
  final bool showSearch;

  const PageHeader({
    super.key,
    required this.title,
    this.name,
    this.code,
    this.showBack = true,
    this.titleFontWeight = FontWeight.w600,
    this.titleColor = AppColors.primaryColor,
    this.topHeight = 62,
    this.showSearch = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(336),
      height: getProportionateHeight(134),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getProportionateHeight(32)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset('assets/images/background2.svg', fit: BoxFit.cover),
          if (showBack)
            Positioned(
              left: getProportionateScreenWidth(16),
              top: getProportionateHeight(16),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.primaryColor,
                      size: getProportionateHeight(20),
                    ),
                    SizedBox(width: getProportionateScreenWidth(8)),
                    Text(
                      'Back',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: getProportionateHeight(16),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            left: getProportionateScreenWidth(16),
            right: showSearch ? 0 : getProportionateScreenWidth(16),
            top: getProportionateHeight(showBack ? 62 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: getProportionateHeight(20),
                    fontWeight: titleFontWeight,
                  ),
                ),
                if (showSearch) ...[
                  SizedBox(height: getProportionateHeight(8)),
                  Text(
                    'Filters',
                    style: TextStyle(
                      color: AppColors.greyColor,
                      fontSize: getProportionateHeight(13),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: getProportionateHeight(4)),
                  Row(
                    children: [
                      const _HeaderSearchBox(),
                      SizedBox(width: getProportionateScreenWidth(8)),
                      Container(
                        width: getProportionateScreenWidth(40),
                        height: getProportionateHeight(40),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(
                            getProportionateHeight(12),
                          ),
                        ),
                        child: Icon(
                          Icons.calendar_today_outlined,
                          color: AppColors.white,
                          size: getProportionateHeight(18),
                        ),
                      ),
                    ],
                  ),
                ],
                if (name != null) ...[
                  SizedBox(height: getProportionateHeight(4)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: getProportionateHeight(23),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (code != null)
                        Text(
                          code!,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: getProportionateHeight(16),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderSearchBox extends StatelessWidget {
  const _HeaderSearchBox();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateHeight(40),
      width: getProportionateScreenWidth(260),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(
            color: AppColors.greyColor,
            fontSize: getProportionateHeight(14),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(12),
          ),
          filled: true,
          fillColor: AppColors.white,
          suffixIcon: Icon(
            Icons.search,
            color: AppColors.primaryColor,
            size: getProportionateHeight(20),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(getProportionateHeight(12)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
