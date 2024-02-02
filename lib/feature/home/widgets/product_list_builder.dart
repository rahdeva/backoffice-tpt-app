import 'package:flutter/material.dart';
import 'package:backoffice_tpt_app/feature/home/home_controller.dart';
import 'package:backoffice_tpt_app/feature/home/widgets/product_items.dart';

class ListProductBuilder extends StatelessWidget {
  const ListProductBuilder({
    Key? key, 
    required this.controller, 
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: controller.dataList.length,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 12);
      },
      padding: const EdgeInsets.only(bottom: 24),
      itemBuilder: (context, index) {
        return ProductListItem(
          index: index,
          controller: controller,
          mData: controller.dataList[index],
        );
      },
    );
  }
}
