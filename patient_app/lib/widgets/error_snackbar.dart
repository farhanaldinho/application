import 'package:flutter/material.dart';
import 'package:patient_app/utils/app_colors.dart';

void renderSnackBar(String value, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(backgroundColor: AppColors.errorRed, content: Text(value)),
  );
}
