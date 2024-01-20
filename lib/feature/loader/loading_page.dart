import 'package:flutter/material.dart';
import '/resources/resources.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.blue,
        ),
      ),
    );
  }
}


// import 'package:emc_mobile_flutter/feature/loader/loader_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:emc_mobile_flutter/resources/resources.dart';
// import 'package:get/get.dart';

// class LoadingPage extends StatelessWidget {
//   const LoadingPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GetBuilder<LoaderController>(builder: (logic) {
//         return Container(
//           child: Center(
//             child: CircularProgressIndicator(
//               color: AppColors.primaryLight,
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
