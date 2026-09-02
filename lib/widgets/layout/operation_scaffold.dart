import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/widgets/layout/page_header.dart';

/// Shared layout for a flow screen, removing the repeated scaffold.
///
/// Centralizes: [Scaffold] background, the top/left/right padding, the header
/// (a [PageHeader] by default, or a custom [header]), the scrollable/centered
/// body and the bottom action.
///
/// - [centered] centres the body vertically (child is expected to be a
///   centred [Column]).
/// - [bottomBar] renders [bottom] without extra bottom padding (used with
///   [BottomActionBar]); otherwise [bottom] gets a 20px bottom padding.
/// - [safeArea] and [contentPadding] support the summary screen.
class OperationScaffold extends StatelessWidget {
  const OperationScaffold({
    super.key,
    required this.title,
    required this.child,
    this.name,
    this.code,
    this.header,
    this.bottom,
    this.centered = false,
    this.bottomBar = false,
    this.safeArea = false,
    this.contentPadding = EdgeInsets.zero,
  });

  final String title;
  final String? name;
  final String? code;
  final Widget? header;
  final Widget child;
  final Widget? bottom;
  final bool centered;
  final bool bottomBar;
  final bool safeArea;
  final EdgeInsets contentPadding;

  @override
  Widget build(BuildContext context) {
    Widget inner = Padding(
      padding: EdgeInsets.only(
        top: getProportionateHeight(54),
        left: getProportionateScreenWidth(20),
        right: getProportionateScreenWidth(20),
      ),
      child: Column(
        children: [
          header ?? PageHeader(title: title, name: name, code: code),
          SizedBox(height: getProportionateHeight(24)),
          Expanded(
            child: centered
                ? child
                : SingleChildScrollView(
                    padding: contentPadding,
                    child: child,
                  ),
          ),
          if (bottom != null)
            bottomBar
                ? bottom!
                : Padding(
                    padding: EdgeInsets.only(bottom: getProportionateHeight(20)),
                    child: bottom!,
                  ),
        ],
      ),
    );

    if (safeArea) inner = SafeArea(child: inner);
    return Scaffold(backgroundColor: AppColors.backgroundColor, body: inner);
  }
}
