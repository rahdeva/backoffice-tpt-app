import 'package:flutter/material.dart';
import '/resources/resources.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        heightFactor: 1,
        child: IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image(
                width: 180,
                fit: BoxFit.fill,
                image:  AppImages.imgEmpty.image().image,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                child: Text(
                  "Data not found",
                  style:  Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontStyle: FontStyle.normal,
                    color: AppColors.black
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
  }
}