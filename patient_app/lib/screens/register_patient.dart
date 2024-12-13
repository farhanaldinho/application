import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patient_app/screens/add_image_screen.dart';
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
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _weightController = TextEditingController();
  final _shoeSizeController = TextEditingController();

  String firstName = '';
  String lastName = '';
  String dateOfBirth = '';
  String weight = '';
  String shoeSize = '';

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _weightController.dispose();
    _shoeSizeController.dispose();
    super.dispose();
  }

  void setFirstName(String value) {
    setState(() {
      firstName = value;
    });
  }

  void setLastName(String value) {
    setState(() {
      lastName = value;
    });
  }

  void setWeight(String value) {
    setState(() {
      weight = value;
    });
  }

  void setShoeSize(String value) {
    setState(() {
      shoeSize = value;
    });
  }

  void _submitForm() {
    if (validateForm() &&
        validateDate() &&
        validateWeight() &&
        validateShoeSize()) {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return const AddImageScreen();
      }));
    }
  }

  bool validateForm() {
    List<TextEditingController> controllerList = [
      _firstNameController,
      _lastNameController,
      _dobController,
      _weightController,
      _shoeSizeController
    ];
    for (TextEditingController controller in controllerList) {
      if (controller.text.isEmpty) {
        renderSnackBar(AppStrings.generalError);
        return false;
      }
    }
    return true;
  }

  bool validateDate() {
    DateFormat dateFormat = DateFormat('MM/dd/yyyy');
    DateTime dob = dateFormat.parse(_dobController.text);
    DateTime currentDate = DateTime.now();

    int age = currentDate.year - dob.year;

    if (age < 18) {
      renderSnackBar(AppStrings.ageError);
      return false;
    }
    return true;
  }

  bool validateShoeSize() {
    if (double.parse(_shoeSizeController.text.toString()) <= 0) {
      renderSnackBar(AppStrings.shoeSizeError);
      return false;
    }
    return true;
  }

  bool validateWeight() {
    if (double.parse(_weightController.text.toString()) <= 30) {
      renderSnackBar(AppStrings.weightError);
      return false;
    }
    return true;
  }

  void renderSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(value)),
    );
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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 24),
            children: [
              renderFieldTitle(AppStrings.firstName),
              renderTextField(_firstNameController, setFirstName),
              const VerticalSpacing(),
              renderFieldTitle(
                AppStrings.lastName,
              ),
              renderTextField(_lastNameController, setLastName),
              const VerticalSpacing(),
              renderFieldTitle(AppStrings.dateOfBirth),
              renderDobPicker(context, _dobController),
              const VerticalSpacing(),
              renderFieldTitle(AppStrings.weight),
              renderTextField(_weightController, setWeight,
                  type: TextInputType.number),
              const VerticalSpacing(),
              renderFieldTitle(AppStrings.shoeSize),
              renderTextField(_shoeSizeController, setShoeSize,
                  type: TextInputType.number),
              const VerticalSpacing(
                height: 32,
              ),
              renderNextButton(),
            ],
          ),
        ));
  }

  Text renderFieldTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20),
    );
  }

  TextField renderTextField(
      TextEditingController controller, void Function(String value) setField,
      {TextInputType type = TextInputType.text}) {
    return TextField(
      keyboardType: type,
      onChanged: setField,
      style: const TextStyle(fontSize: 20),
      controller: controller,
    );
  }

  Widget renderDobPicker(
      BuildContext context, TextEditingController controller) {
    return TextField(
      style: const TextStyle(fontSize: 20),
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(helperText: AppStrings.selectDate),
      onTap: () async {
        final selectedDate = await showDatePicker(
            initialDate: DateTime.now(),
            context: context,
            firstDate: DateTime(1900),
            lastDate: DateTime.now());
        setState(() {
          if (selectedDate != null) {
            dateOfBirth = DateFormat('MM/dd/yyyy').format(selectedDate);
            controller.text = dateOfBirth;
          }
        });
      },
    );
  }

  Widget renderNextButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(100, 48),
              backgroundColor: AppColors.primaryButton,
              foregroundColor: AppColors.white,
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            onPressed: _submitForm,
            child: Text(AppStrings.nextButtonText)),
      ],
    );
  }
}
