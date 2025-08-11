import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resq_map/core/constants/text_styles.dart';
import 'package:resq_map/core/services/file_picker.dart';

import 'package:resq_map/features/profile/cubit/profile_cubit.dart';

class ImagePicker extends StatefulWidget {
  const ImagePicker({super.key, required this.image});
  final String image;

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  String? fileName;
  File? file;

  Future<void> _pickImage() async {
    var status = await Permission.storage.request();
    if(!status.isGranted){
      return;
    }
    
    print("Picking Image");
    try {
      FilePickerResult? result =
                                    await FilePickerHelper.pickImage();

      if (result != null) {
        setState(() {
          file = File(result.files.first.path!);
          fileName = result.files.first.name;
        });
        BlocProvider.of<ProfileCubit>(context).updateProfilePhoto(
          fileName: fileName!,
          photo: file!
        );
        print(fileName);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Profile picture".toUpperCase(),
                style: TextStyle(
                  letterSpacing: 1,
                  fontWeight: FontWeight.w300,
                ),
              ),
              TextButton(
                onPressed: _pickImage,

                child: Text(
                  "Edit",
                  style: TextStyles.textStyle16,
                ),
              ),
            ],
          ),
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image:
                    file != null
                        ? FileImage(file!)
                        : NetworkImage(widget.image),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
