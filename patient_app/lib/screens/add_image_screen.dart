import 'package:flutter/material.dart';
import 'package:patient_app/utils/app_colors.dart';
import 'package:patient_app/utils/app_strings.dart';

class AddImageScreen extends StatefulWidget {
  const AddImageScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddImageScreen();
  }
}

class _AddImageScreen extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBar,
        leadingWidth: double.infinity,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
              style: TextStyle(fontSize: 24, color: AppColors.white),
              AppStrings.appBarText),
        ),
      ),
      body: const Center(
        child: Text('data'),
      ),
    );
  }
}
