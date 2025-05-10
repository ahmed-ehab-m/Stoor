// import 'dart:io';

// import 'package:bookly_app/Features/settings/data/repos/settings_repo.dart';
// import 'package:bookly_app/core/errors/failures.dart';
// import 'package:dartz/dartz.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SettingsRepoImpl implements SettingsRepo {
//   final ImagePicker _picker;
//   final SharedPreferences prefs;

//   SettingsRepoImpl(this._picker, this.prefs);

//   @override
//   Future<Either<Failure, String>> pickProfileImage() async {
//     File? imageFile;
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.gallery);
//     imageFile = File(pickedFile!.path);
//     prefs.setString(kProfileImage, imageFile!.path);
//   }

//   @override
//   Future<Either<Failure, String>> getProfileImagePath() {
//     // TODO: implement getProfileImagePath
//     throw UnimplementedError();
//   }
// }
