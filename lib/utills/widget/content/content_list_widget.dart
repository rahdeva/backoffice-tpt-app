import 'package:flutter/material.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';

class ContentListWidget extends StatelessWidget {
  const ContentListWidget({
    super.key,
    required this.title1,
    required this.title2,
  });

  final String title1;
  final String title2;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title1,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w300
          ),
        ),
        const SizedBox(height: 2),
        Text(
          title2,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w500
          ),
        ),
      ],
    );
  }
}
