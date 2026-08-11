import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';

/// A station status card with a title above and an inner status card.
class StationStatusCard extends StatelessWidget {
  final String title;
  final String status;

  const StationStatusCard({
    super.key,
    required this.title,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final bool isReady = status == 'Ready';
    final Color innerBg = isReady ? const Color(0xFFD1FADF) : AppColors.tabColor;
    final Color statusColor =
        isReady ? const Color(0xFF12B76A) : AppColors.greyColor;

    return Container(
      width: getProportionateScreenWidth(101),
      height: getProportionateHeight(133),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(getProportionateHeight(16)),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: getProportionateHeight(12)),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: getProportionateHeight(14),
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: getProportionateHeight(12)),
            Container(
              width: getProportionateScreenWidth(85),
              height: getProportionateHeight(85),
              decoration: BoxDecoration(
                color: innerBg,
                borderRadius: BorderRadius.circular(getProportionateHeight(16)),
              ),
              child: Center(
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: getProportionateHeight(12),
                    color: statusColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
