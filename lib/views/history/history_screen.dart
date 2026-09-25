import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/widgets/buttons/gradient_button.dart';
import 'package:vessel_pipeline_discharge_app/widgets/layout/page_header.dart';

/// Placeholder content shown when the History tab is selected.
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getProportionateHeight(188)),
        child: Padding(
          padding: EdgeInsets.only(
            top: getProportionateHeight(54),
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(20),
          ),
          child: PageHeader(
            title: 'Your Checklist History',
            titleFontWeight: FontWeight.w600,
            titleColor: AppColors.primaryColor,
            showBack: false,
            topHeight: getProportionateHeight(66),
            showSearch: true,
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: 2,
        separatorBuilder: (context, index) =>
            SizedBox(height: getProportionateHeight(1)),
        itemBuilder: (context, index) => SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            getProportionateScreenWidth(20),
            getProportionateHeight(9),
            getProportionateScreenWidth(20),
            getProportionateHeight(32),
          ),
          child: const _HistoryCard(),
        ),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(getProportionateScreenWidth(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(getProportionateHeight(20)),
        border: Border.all(color: AppColors.greyTab),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MT African Spirit',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: getProportionateHeight(20),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: getProportionateHeight(4)),
                    Text(
                      'VES 101203',
                      style: TextStyle(
                        color: AppColors.greyColor,
                        fontSize: getProportionateHeight(13),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    width: getProportionateHeight(8),
                    height: getProportionateHeight(8),
                    decoration: const BoxDecoration(
                      color: AppColors.successGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: getProportionateScreenWidth(6)),
                  Text(
                    'Completed',
                    style: TextStyle(
                      color: AppColors.successGreenText,
                      fontSize: getProportionateHeight(13),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: getProportionateHeight(16)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(getProportionateScreenWidth(12)),
            decoration: BoxDecoration(
              color: AppColors.tabColor,
              borderRadius: BorderRadius.circular(getProportionateHeight(14)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _HistoryDateItem(
                  label: 'Operation date',
                  value: '30 July 2026',
                ),
                _HistoryDateItem(label: 'Started', value: '12:00 PM'),
                _HistoryDateItem(label: 'Completed', value: '8:00 PM'),
              ],
            ),
          ),
          SizedBox(height: getProportionateHeight(16)),
          GradientButton(
            label: 'View Checklist Report',
            width: double.infinity,
            height: getProportionateHeight(48),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _HistoryDateItem extends StatelessWidget {
  final String label;
  final String value;

  const _HistoryDateItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.greyColor,
            fontSize: getProportionateHeight(11),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: getProportionateHeight(4)),
        Text(
          value,
          style: TextStyle(
            color: AppColors.secondaryColor,
            fontSize: getProportionateHeight(12),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
