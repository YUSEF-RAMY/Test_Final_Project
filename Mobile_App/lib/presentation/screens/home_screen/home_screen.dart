import 'dart:developer';
import 'dart:io';

import 'package:eye_app/main.dart';
import 'package:eye_app/presentation/resources/color_manager.dart';
import 'package:eye_app/presentation/resources/text_style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/request/upload_image_request.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late File _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background_color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  color: ColorManager.gray,
                  size: 135,
                ),
                SizedBox(height: 4.h),
                Text('Choose a picture', style: TextStyleManager.White16Medium),
              ],
            ),
            Text(
              'Please choose a picture to your eyes',
              style: TextStyleManager.White16Medium,
            ),
            GestureDetector(
              onTap: () async {
                await pickImage(ImageSource.camera);
                log(EyeApp.token);
                log(_image.path);
                await UploadImageRequest(imageFile: _image);
              },
              child: Container(
                width: 195.w,
                height: 56.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorManager.primary,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.photo_size_select_actual_outlined,
                      color: ColorManager.white,
                    ),
                    SizedBox(width: 8.w),
                    Text('Upload photo', style: TextStyleManager.White16Bold),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
