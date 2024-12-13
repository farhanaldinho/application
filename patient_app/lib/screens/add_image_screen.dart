import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patient_app/models/patient_model.dart';
import 'package:patient_app/utils/app_colors.dart';
import 'package:patient_app/utils/app_strings.dart';
import 'package:patient_app/widgets/error_snackBar.dart';
import 'package:patient_app/widgets/vertical_spacing.dart';

class AddImageScreen extends StatefulWidget {
  const AddImageScreen(
      {required this.firstName,
      required this.lastName,
      required this.dateOfBirth,
      required this.weight,
      required this.shoeSize,
      super.key});

  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String weight;
  final String shoeSize;

  @override
  State<StatefulWidget> createState() {
    return _AddImageScreen();
  }
}

class _AddImageScreen extends State<AddImageScreen> {
  List<File?> images = [null, null, null, null];
  ImagePicker imagePicker = ImagePicker();
  bool loading = false;

  Future<void> getImage(int index) async {
    //add perms for android
    final imageFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (imageFile != null) {
      setState(() {
        images[index] = File(imageFile.path);
      });
    }
  }

  removeImage(int index) {
    setState(() {
      images[index] = null;
    });
  }

  Future<void> onSubmit() async {
    if (validateImages()) {
      final patient = Patient(widget.firstName, widget.lastName,
          widget.dateOfBirth, widget.weight, widget.shoeSize, images);
      print(patient.firstName);
      setState(() {
        loading = true;
      });
      final response = await Future.delayed(const Duration(seconds: 2), () {
        return true;
      });

      if (response) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: AppColors.appBar,
              content: Text(AppStrings.submissionSuccess)),
        );
        Navigator.of(context).pushReplacementNamed('/');
      } else {
        renderSnackBar(AppStrings.submissionError, context);
      }
    }
  }

  bool validateImages() {
    for (File? image in images) {
      if (image == null) {
        renderSnackBar(AppStrings.imageError, context);
        return false;
      }
    }
    return true;
  }

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
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: loading
            ? renderLoader()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      AppStrings.captureImagesText,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const VerticalSpacing(),
                  //image trigger
                  renderGridView(),
                  const VerticalSpacing(),
                  //submit button
                  renderSubmitButton()
                ],
              ),
      ),
    );
  }

  SizedBox renderGridView() {
    return SizedBox(
      height: 300,
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: images.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return images[index] == null
              ? renderSelectImage(index)
              : renderImage(index);
        },
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      ),
    );
  }

  Widget renderSelectImage(int index) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1)),
      margin: const EdgeInsets.only(left: 8, bottom: 8),
      child: OutlinedButton(
        onPressed: () {
          getImage(index);
        },
        style: OutlinedButton.styleFrom(
          shape: const LinearBorder(),
          backgroundColor: AppColors.white,
        ),
        child: Text(
            textAlign: TextAlign.center,
            "${AppStrings.selectImageText} ${index + 1}"),
      ),
    );
  }

  Widget renderImage(int index) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1)),
      margin: const EdgeInsets.only(left: 8, bottom: 8),
      child: Stack(
        children: [
          Image.file(
            images[index] as File,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
              child: IconButton(
                  onPressed: () {
                    removeImage(index);
                  },
                  icon: Icon(
                    Icons.close, // or Icons.cancel
                    size: 24, // Set the size of the icon
                    color: AppColors.black, // Set the color of the icon
                  ))),
        ],
      ),
    );
  }

  ElevatedButton renderSubmitButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(120, 48),
          backgroundColor: AppColors.primaryButton,
          foregroundColor: AppColors.white,
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        onPressed: onSubmit,
        child: Text(AppStrings.submitButtonText));
  }

  Widget renderLoader() {
    return const Center(child: CircularProgressIndicator());
  }
}
