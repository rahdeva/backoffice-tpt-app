import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showLoading({String? message}) async {
  if (Get.overlayContext != null && Get.isOverlaysClosed) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(32),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [CircularProgressIndicator()],
            ),
          ),
        ),
      ),
    );
  }
}

dismissLoading() {
  if (Get.overlayContext != null) {
    Navigator.of(Get.overlayContext!).pop();
  }
}

  // void pickImage() async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   s.FirebaseStorage storage = s.FirebaseStorage.instance;
  //   final ImagePicker picker = ImagePicker();
  //   String uid = auth.currentUser!.uid;
  //   // Pick an image
  //   image = await picker.pickImage(source: ImageSource.gallery);

  //   if (image != null) {
  //     Get.snackbar("Berhasil!", "Mohon tunggu sesaat untuk update foto profile");
      
  //     String ext = image!.name.split(".").last;
  //     await storage.ref(uid).child("profile.$ext").putFile(File(image!.path));

  //     String profileUrl = await storage.ref(uid).child("profile.$ext").getDownloadURL();

  //     await FirebaseFirestore.instance.collection("users").doc(uid).update({"profile": profileUrl});  
  //   }
  // }