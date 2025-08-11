import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resq_map/core/constants/constants.dart';
import 'package:resq_map/core/services/file_picker.dart';
import 'package:resq_map/core/constants/text_styles.dart';
import 'package:resq_map/features/profile/cubit/profile_cubit.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({
    super.key,
    required this.url,
    required this.firstName,
    required this.lastName,
    required this.username,
  });
  final String firstName;
  final String lastName;
  final String username;
  final String url;

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  String? fileName;
  File? file;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.symmetric(horizontal: 16),

      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder:
                    (context) => SizedBox(
                      height: 130,
                      child: Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.add_a_photo_outlined),
                              title: Text("Change Profile Photo"),
                              onTap: () async {
                                FilePickerResult? result =
                                    await FilePickerHelper.pickImage();
                                if (result != null) {
                                  setState(() {
                                    file = File(result.files.first.path!);
                                    fileName = result.files.first.name;
                                  });
                                  BlocProvider.of<ProfileCubit>(
                                    context,
                                  ).updateProfilePhoto(
                                    fileName: fileName!,
                                    photo: file!,
                                  );
                                }
                              }
                            ),
                            ListTile(
                              leading: Icon(Icons.remove_circle_outline),
                              title: Text("Remove Profile Photo"),
                              onTap: () {
                                BlocProvider.of<ProfileCubit>(
                                  context,
                                ).deleteProfilePhoto();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
              );
            },

            child: Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.url),
                ),
              ),
            ),
          ),

          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${widget.firstName} ${widget.lastName}',
                style: TextStyles.textStyle18.copyWith(
                  fontWeight: FontWeight.w300,
                  color: softWhite,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '@${widget.username}',
                style: TextStyles.textStyle16.copyWith(
                  fontWeight: FontWeight.w100,
                  color: softWhite,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
