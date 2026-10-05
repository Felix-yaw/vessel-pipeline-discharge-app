import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';

/// Static alerts feed shown when the Alerts tab is selected (demo data).
class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  static const List<_AlertItem> _alerts = [
    _AlertItem(
      icon: Icons.play_circle_outline,
      color: AppColors.primaryColor,
      tint: AppColors.tabColor,
      title: 'Discharge started',
      body: 'Discharge has begun at the Jetty for MT African Spirit.',
      time: '2m ago',
    ),
    _AlertItem(
      icon: Icons.fact_check_outlined,
      color: AppColors.successGreen,
      tint: AppColors.readyGreenBackground,
      title: 'All stations ready',
      body: 'Jetty, Booster and Tank have confirmed readiness.',
      time: '18m ago',
    ),
    _AlertItem(
      icon: Icons.notifications_none_rounded,
      color: AppColors.primaryColor,
      tint: AppColors.tabColor,
      title: 'Readiness requested',
      body: 'Jetty is requesting readiness confirmation for VES 101203.',
      time: '25m ago',
    ),
    _AlertItem(
      icon: Icons.schedule_rounded,
      color: AppColors.primaryColor,
      tint: AppColors.tabColor,
      title: 'Hourly reading due',
      body: 'Please record the hourly reading for this operation.',
      time: '1h ago',
    ),
    _AlertItem(
      icon: Icons.pause_circle_outline,
      color: AppColors.haltText,
      tint: AppColors.haltBackground,
      title: 'Discharge halted',
      body: 'The discharge was halted due to a reported issue.',
      time: '3h ago',
    ),
    _AlertItem(
      icon: Icons.check_circle_outline,
      color: AppColors.successGreen,
      tint: AppColors.readyGreenBackground,
      title: 'Discharge completed',
      body: 'The discharge operation for MT African Spirit has ended.',
      time: 'Yesterday',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: getProportionateHeight(24),
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(20),
              ),
              child: Text(
                'Alerts',
                style: TextStyle(
                  fontSize: getProportionateHeight(28),
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: getProportionateHeight(16)),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(
                  getProportionateScreenWidth(20),
                  0,
                  getProportionateScreenWidth(20),
                  getProportionateHeight(32),
                ),
                itemCount: _alerts.length,
                separatorBuilder: (_, _) =>
                    SizedBox(height: getProportionateHeight(12)),
                itemBuilder: (context, index) => _AlertCard(_alerts[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AlertItem {
  final IconData icon;
  final Color color;
  final Color tint;
  final String title;
  final String body;
  final String time;

  const _AlertItem({
    required this.icon,
    required this.color,
    required this.tint,
    required this.title,
    required this.body,
    required this.time,
  });
}

class _AlertCard extends StatelessWidget {
  final _AlertItem alert;

  const _AlertCard(this.alert);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenWidth(14)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(getProportionateHeight(16)),
        border: Border.all(color: AppColors.greyTab),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: getProportionateHeight(40),
            height: getProportionateHeight(40),
            decoration: BoxDecoration(
              color: alert.tint,
              shape: BoxShape.circle,
            ),
            child: Icon(
              alert.icon,
              color: alert.color,
              size: getProportionateHeight(20),
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert.title,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: getProportionateHeight(15),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: getProportionateHeight(4)),
                Text(
                  alert.body,
                  style: TextStyle(
                    color: AppColors.greyColor,
                    fontSize: getProportionateHeight(13),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(8)),
          Text(
            alert.time,
            style: TextStyle(
              color: AppColors.greyColor,
              fontSize: getProportionateHeight(12),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}