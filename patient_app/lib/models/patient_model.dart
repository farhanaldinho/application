import 'dart:io';

class Patient {
  Patient(this.firstName, this.lastName, this.dateOfBirth, this.weight,
      this.shoeSize, this.images);
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String weight;
  final String shoeSize;
  final List<File?> images;

  factory Patient.fromJson(Map<String, dynamic> json) {
    //not used in the app just to show how we would read a json and map it onto our Patient obj
    return Patient(json['firstName'], json['lastName'], json['dateOfBirth'],
        json['weight'], json['shoeSize'], json['images']);
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'weight': weight,
      'shoeSize': shoeSize,
      'footPhotos': images,
    };
  }
}
