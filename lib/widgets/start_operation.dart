import 'package:flutter/material.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';
import 'package:vessel_pipeline_discharge_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:vessel_pipeline_discharge_app/provider/operation_provider.dart';

class StartOperation extends StatelessWidget {
  const StartOperation({super.key});

  @override
  Widget build(BuildContext context) {
    final operationProvider = Provider.of<OperationProvider>(context);
    return Padding(
      padding: EdgeInsets.only(
        top: getProportionateHeight(104),
        left: getProportionateScreenWidth(8),
        right: getProportionateScreenWidth(8),
      ),
      child: Container(
        height: getProportionateHeight(298),
        width: getProportionateScreenWidth(320),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getProportionateHeight(24)),
          color: AppColors.white,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: getProportionateHeight(8),
            left: getProportionateScreenWidth(8),
            right: getProportionateScreenWidth(8),
          ),
          child: Column(
            children: [
              Container(
                height: getProportionateHeight(42),
                width: getProportionateScreenWidth(304),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    getProportionateHeight(8),
                  ),
                  color: AppColors.tabColor,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'CURRENT OPERATIONS',
                        style: TextStyle(
                          fontSize: getProportionateHeight(12),
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: getProportionateHeight(30)),
              CustomButton(
                color: AppColors.primaryColor,
                text: 'START OPERATION',
                onPressed: () {
                  operationProvider.setSelectedOperationIndex(1);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
