import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patient_app/utils/app_colors.dart';
import 'package:patient_app/utils/app_strings.dart';
import 'package:patient_app/widgets/vertical_spacing.dart';

class AddImageScreen extends StatefulWidget {
  const AddImageScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddImageScreen();
  }
}

class _AddImageScreen extends State {
  final List<File?> images = [null, null, null, null];
  final ImagePicker imagePicker = ImagePicker();

  Future<void> getImage(int index) async {
    final imageFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (imageFile != null) {
      setState(() {
        images[index] = File(imageFile.path);
      });
    }
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
        child: Column(
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
            SizedBox(
              height: 300,
              child: GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: images.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return images[index] == null
                      ? renderSelectImage(index)
                      : renderImage();
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
              ),
            ),
            const VerticalSpacing(),
            //submit button
            renderSubmitButton()
          ],
        ),
      ),
    );
  }

  Widget renderSelectImage(int index) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1)),
      margin: EdgeInsets.only(left: 8, bottom: 8),
      child: OutlinedButton(
        onPressed: () {},
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

  Widget renderImage() {
    return Text('data');
  }

  ElevatedButton renderSubmitButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(120, 48),
          backgroundColor: AppColors.primaryButton,
          foregroundColor: AppColors.white,
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        onPressed: () async {
          await getImage(0);
        },
        child: Text(AppStrings.submitButtonText));
  }
}
