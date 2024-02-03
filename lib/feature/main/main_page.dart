import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:backoffice_tpt_app/feature/main/widgets/side_menu.dart';
import 'package:backoffice_tpt_app/utills/helper/responsive.dart';

import 'main_controller.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Scaffold(
          key: controller.scaffoldKey,
          drawer: SideMenu(controller: controller),
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Responsive.isDesktop(context))
                  Expanded(
                    child: GetBuilder(
                      id: 'side-menu',
                      init: controller,
                      builder: (_) {
                        return SideMenu(
                          controller: controller,
                        );
                      }
                    ),
                  ),
                Expanded(
                  flex: 7,
                  child: GetBuilder(
                    id: 'content',
                    init: controller,
                    builder: (_) {
                      return controller.pageView[controller.tabIndex];
                    }
                  ),
                ),
              ],
            ),
          )
        );
      },
    );
  }
}