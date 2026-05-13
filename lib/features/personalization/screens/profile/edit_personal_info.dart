import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/popups/loaders.dart';
import '../../controllers/user_controller.dart';

enum ProfileEditableField { phoneNumber, gender, dateOfBirth }

class EditPersonalInfoScreen extends StatefulWidget {
  const EditPersonalInfoScreen({super.key, required this.field});

  final ProfileEditableField field;

  @override
  State<EditPersonalInfoScreen> createState() => _EditPersonalInfoScreenState();
}

class _EditPersonalInfoScreenState extends State<EditPersonalInfoScreen> {
  final controller = UserController.instance;
  late final TextEditingController textController;
  DateTime? selectedDate;

  bool get isDateField => widget.field == ProfileEditableField.dateOfBirth;

  String get fieldTitle {
    switch (widget.field) {
      case ProfileEditableField.phoneNumber:
        return 'Phone Number';
      case ProfileEditableField.gender:
        return 'Gender';
      case ProfileEditableField.dateOfBirth:
        return 'Date of Birth';
    }
  }

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(
      text: widget.field == ProfileEditableField.phoneNumber
          ? controller.user.value.phoneNumber
          : controller.user.value.gender,
    );
    selectedDate = controller.user.value.dateOfBirth;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() => selectedDate = pickedDate);
    }
  }

  Future<void> save() async {
    try {
      switch (widget.field) {
        case ProfileEditableField.phoneNumber:
          await controller.updatePhoneNumber(textController.text);
          break;
        case ProfileEditableField.gender:
          await controller.updateGender(textController.text);
          break;
        case ProfileEditableField.dateOfBirth:
          await controller.updateDateOfBirth(selectedDate);
          break;
      }

      TLoaders.successSnackBar(title: 'Updated', message: '$fieldTitle updated successfully.');
      Get.back();
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Edit $fieldTitle', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isDateField)
              ListTile(
                title: Text(controller.dateOfBirthText),
                trailing: const Icon(Icons.calendar_today_outlined),
                onTap: pickDate,
                contentPadding: EdgeInsets.zero,
              )
            else
              TextFormField(
                controller: textController,
                decoration: InputDecoration(labelText: fieldTitle),
              ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: save, child: const Text('Save'))),
          ],
        ),
      ),
    );
  }
}
