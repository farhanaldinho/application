import 'package:flutter/material.dart';
import 'package:patient_app/screens/register_patient.dart';
import 'package:patient_app/utils/app_colors.dart';
import 'package:patient_app/utils/app_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void onRegisterButtonPress() {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return const RegisterPatient();
      }));
    }

    return Scaffold(
      body: Center(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.white,
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                fixedSize: const Size(200, 70),
                backgroundColor: AppColors.primaryButton),
            onPressed: onRegisterButtonPress,
            child: Text(AppStrings.registerPatientButtonText)),
      ),
    );
  }
}
