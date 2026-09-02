import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/widgets/navigation/nav_item.dart';

/// Custom bottom navigation bar with two grouped grey containers.
class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16),
      ),
      height: getProportionateHeight(76),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(getProportionateHeight(24)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withValues(alpha: 0.06),
            blurRadius: getProportionateHeight(8),
            offset: Offset(0, getProportionateHeight(-2)),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: getProportionateScreenWidth(248),
              height: getProportionateHeight(76),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(getProportionateHeight(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NavItem(
                    label: 'Home',
                    assetPath: 'assets/images/home.svg',
                    selected: selectedIndex == 0,
                    onTap: () => onTap(0),
                  ),
                  SizedBox(width: getProportionateScreenWidth(8)),
                  NavItem(
                    label: 'History',
                    assetPath: 'assets/images/Checklist history icon.svg',
                    selected: selectedIndex == 1,
                    onTap: () => onTap(1),
                  ),
                  SizedBox(width: getProportionateScreenWidth(8)),
                  NavItem(
                    label: 'Alerts',
                    assetPath: 'assets/images/Bell_duotone_line.svg',
                    selected: selectedIndex == 2,
                    onTap: () => onTap(2),
                    badgeCount: 12,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: getProportionateScreenWidth(264),
            top: (getProportionateHeight(76) - getProportionateHeight(72)) / 2,
            child: Container(
              width: getProportionateScreenWidth(76),
              height: getProportionateHeight(72),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(getProportionateHeight(20)),
              ),
              child: Center(
                child: NavItem(
                  label: 'More',
                  icon: Icons.more_horiz,
                  selected: selectedIndex == 3,
                  onTap: () => onTap(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}