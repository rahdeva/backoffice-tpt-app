import 'dart:io';

import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({
    Key? key, 
    required this.onTap, 
    this.image,
  }) : super(key: key);

  final Function() onTap;
  final File? image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.grey.withOpacity(0.5)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image == null 
            ? const FaIcon(
                FontAwesomeIcons.camera,
                size: 24,
              )
            : Center(
              child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(
                        image!
                      ),
                    )
                  ),
                ),
            ), 
          ],
        ),
      ),
    );
  }
}
