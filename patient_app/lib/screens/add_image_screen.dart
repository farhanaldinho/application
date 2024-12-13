import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patient_app/utils/app_colors.dart';
import 'package:patient_app/utils/app_strings.dart';
import 'package:patient_app/widgets/error_snackBar.dart';
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

  void onSubmit() {
    if (validateImages()) {
      print('done');
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
}
