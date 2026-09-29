import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/provider/operation_provider.dart';
import 'package:vessel_pipeline_discharge_app/widgets/buttons/gradient_button.dart';

/// Request Readiness page.
///
/// Shown once the initial readings have been recorded. The jetty is already
/// ready, so a readiness request is sent to the Booster Station and the Tank
/// Farm, which stay pending until they confirm.
class ConfirmOperationScreen extends StatelessWidget {
  const ConfirmOperationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OperationController controller = context.read<OperationController>();
    final String vesselName = controller.operation.vesselName.isEmpty
        ? 'MT African Spirit'
        : controller.operation.vesselName;
    final String vesselCode = controller.operation.vesselCode;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(
          top: getProportionateHeight(54),
          left: getProportionateScreenWidth(20),
          right: getProportionateScreenWidth(20),
        ),
        child: Column(
          children: [
            _ReadinessHeader(vesselName: vesselName, vesselCode: vesselCode),
            SizedBox(height: getProportionateHeight(24)),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _SectionLabel('Your Status'),
                    SizedBox(height: getProportionateHeight(12)),
                    const _StationTile(title: 'Jetty', status: 'Ready'),
                    SizedBox(height: getProportionateHeight(24)),
                    const _SectionLabel('Stations Awaiting Confirmation'),
                    SizedBox(height: getProportionateHeight(12)),
                    const _StationTile(title: 'Booster', status: 'Pending'),
                    SizedBox(height: getProportionateHeight(12)),
                    const _StationTile(title: 'Tank', status: 'Pending'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: getProportionateHeight(20)),
              child: GradientButton(
                label: 'Send Request',
                width: getProportionateScreenWidth(336),
                height: getProportionateHeight(56),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Large grey-blue grid header (336 x 288). The background asset already
/// contains the "is your safety check complete?" prompt box; only the vessel
/// identity is overlaid at the top.
class _ReadinessHeader extends StatelessWidget {
  final String vesselName;
  final String vesselCode;

  const _ReadinessHeader({
    required this.vesselName,
    required this.vesselCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(336),
      height: getProportionateHeight(288),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getProportionateHeight(32)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            'assets/images/background3_grid.svg',
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.all(getProportionateHeight(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
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
                SizedBox(height: getProportionateHeight(12)),
                Text(
                  'Request Readiness',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: getProportionateHeight(16),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: getProportionateHeight(4)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        vesselName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: getProportionateHeight(23),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      vesselCode,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: getProportionateHeight(14),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: getProportionateScreenWidth(8),
            right: getProportionateScreenWidth(8),
            bottom: getProportionateHeight(8),
            height: getProportionateHeight(144),
            child: const _ReadinessInfoBox(),
          ),
        ],
      ),
    );
  }
}

/// The "is your safety check complete?" prompt card inside the header.
class _ReadinessInfoBox extends StatelessWidget {
  const _ReadinessInfoBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16),
        vertical: getProportionateHeight(16),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FC),
        borderRadius: BorderRadius.circular(getProportionateHeight(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Is your safety check complete?',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: getProportionateHeight(14),
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Send a readiness request to the Booster Station and Tank Farm.',
            style: TextStyle(
              color: AppColors.greyColor,
              fontSize: getProportionateHeight(13),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;

  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.greyColor,
        fontSize: getProportionateHeight(14),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _StationTile extends StatelessWidget {
  final String title;
  final String status;

  const _StationTile({required this.title, required this.status});

  @override
  Widget build(BuildContext context) {
    final bool isReady = status == 'Ready';
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16),
        vertical: getProportionateHeight(16),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(getProportionateHeight(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: getProportionateHeight(16),
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(12),
              vertical: getProportionateHeight(6),
            ),
            decoration: BoxDecoration(
              color: isReady
                  ? AppColors.readyGreenBackground
                  : AppColors.tabColor,
              borderRadius: BorderRadius.circular(getProportionateHeight(16)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: getProportionateHeight(8),
                  height: getProportionateHeight(8),
                  decoration: BoxDecoration(
                    color: isReady
                        ? AppColors.successGreen
                        : AppColors.greyColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(6)),
                Text(
                  status,
                  style: TextStyle(
                    color: isReady
                        ? AppColors.successGreenText
                        : AppColors.greyColor,
                    fontSize: getProportionateHeight(12),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
