import 'package:flutter/material.dart';
import 'package:patient_app/utils/app_colors.dart';
import 'package:patient_app/utils/app_strings.dart';
import 'package:patient_app/widgets/vertical_spacing.dart';

class RegisterPatient extends StatefulWidget {
  const RegisterPatient({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterPatient();
  }
}

class _RegisterPatient extends State {
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
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 24),
              children: [
                renderFieldTitle(AppStrings.firstName),
                renderTextField(),
                const VerticalSpacing(),
                renderFieldTitle(AppStrings.lastName),
                renderTextField(),
                const VerticalSpacing(),
                renderFieldTitle(AppStrings.dateOfBirth),
                const VerticalSpacing(),
                renderFieldTitle(AppStrings.weight),
                renderTextField(),
                const VerticalSpacing(),
                renderFieldTitle(AppStrings.shoeSize)
              ],
            ),
          ),
        ));
  }

  Text renderFieldTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20),
    );
  }

  TextField renderTextField() {
    return const TextField(style: TextStyle(fontSize: 20));
  }
}
