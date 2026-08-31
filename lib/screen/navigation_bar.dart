import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/screen/homescreen.dart';
import 'package:vessel_pipeline_discharge_app/provider/navigation_provider.dart';
import 'package:vessel_pipeline_discharge_app/screen/alerts.dart';
import 'package:vessel_pipeline_discharge_app/screen/history.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vessel_pipeline_discharge_app/widgets/navigation_item.dart';

class CustomNavigationBar extends StatelessWidget {
  CustomNavigationBar({super.key});

  final List<Widget> _pages = [HomeScreen(), History(), AlertsPage()];

  final List<NavItem> _navItems = const [
    NavItem('assets/icons/home.svg', 'Home'),
    NavItem('assets/icons/Bell_duotone_line.svg', 'History'),
    NavItem('assets/icons/Checklist history icon.svg', 'Alerts'),
  ];

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: _pages[navigationProvider.currentIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: getProportionateScreenWidth(24),
          right: getProportionateScreenWidth(24),
          bottom: getProportionateHeight(30),
        ),
        child: Row(
          children: [
            Container(
              width: getProportionateScreenWidth(248),
              height: getProportionateHeight(76),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(getProportionateHeight(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(getProportionateHeight(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(_navItems.length, (index) {
                      final isSelected =
                          navigationProvider.currentIndex == index;
                      return GestureDetector(
                        onTap: () => navigationProvider.setIndex(index),
                        child: Container(
                          width: getProportionateScreenWidth(65),
                          height: getProportionateHeight(54),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryColor.withOpacity(0.12)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              getProportionateHeight(12),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                _navItems[index].assetPath,
                                width: getProportionateHeight(24),
                                height: getProportionateHeight(24),
                                colorFilter: ColorFilter.mode(
                                  isSelected
                                      ? AppColors.primaryColor
                                      : AppColors.greyColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(height: getProportionateHeight(5)),
                              Text(
                                _navItems[index].label,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? AppColors.primaryColor
                                      : AppColors.greyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(5)),
            Container(
              width: getProportionateScreenWidth(72),
              height: getProportionateHeight(76),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(getProportionateHeight(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(getProportionateHeight(16)),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/Meatballs_menu.svg',
                      width: getProportionateScreenWidth(24),
                      height: getProportionateHeight(24),
                    ),
                    SizedBox(height: getProportionateHeight(5)),
                    Text(
                      'More',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,

                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
