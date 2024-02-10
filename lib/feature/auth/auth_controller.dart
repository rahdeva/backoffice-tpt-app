// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable

import 'package:get/get.dart';
import '/data/local/storage/storage_constants.dart';
import '/data/local/storage/storage_manager.dart';
import '/model/user.dart';
import '/routes/page_names.dart';
import '/data/local/secure/secure_storage_manager.dart';

import 'auth_state.dart';

class AuthController extends GetxController {
  static AuthController find = Get.find();
  Rxn<AuthState> authState = Rxn<AuthState>();

  Stream<AuthState?> get stream => authState.stream;

  AuthState? get state => authState.value;

  var storage = StorageManager();
  var secureStorage = SecureStorageManager();

  UserData? get user {
    if (storage.has(StorageName.USERS)) {
      return UserData.fromJson(storage.get(StorageName.USERS));
    } else {
      return null;
    }
  }

  @override
  void onInit() {
    authState.value = AuthState(appStatus: AppType.INITIAL);
    super.onInit();
  }

  @override
  void onReady() async {
    ever(authState, authChanged);
    authChanged(state);
    super.onReady();
  }

  authChanged(AuthState? state) async {
    if (state?.appStatus == AppType.INITIAL) {
      await setup();
      await checkToken();
    } else if (state?.appStatus == AppType.UNAUTHENTICATED) {
      await clearData();
      Get.offAllNamed(PageName.LOGIN);
    } else if (state?.appStatus == AppType.AUTHENTICATED) {
      Get.offAllNamed(PageName.MAIN);
    } else {
      Get.toNamed(PageName.LOADER);
    }
    update();
  }

  Future<void> checkToken() async {
    if (storage.has(StorageName.USERS)) {
      setAuth();
    } else {
      signOut();
    }
  }

  Future<void> clearData() async {
    storage.clearAll();
    await secureStorage.setToken(value: '');
  }

  Future<void> saveAuthData({required UserData user, required String token}) async {
    await storage.write(StorageName.USERS, user.toJson());
    await secureStorage.setToken(value: token);
  }

  Future<void> changeUserData({required UserData user}) async {
    await storage.write(StorageName.USERS, user.toJson());
  }

  Future<void> signOut() async {
    await secureStorage.setToken(value: '');
    await storage.clearAll();
    authState.value = AuthState(appStatus: AppType.UNAUTHENTICATED);
  }

  void setAuth() async {
    authState.value = AuthState(appStatus: AppType.AUTHENTICATED);
  }

  setup() async {
    final firstInstall = storage.get(StorageName.FIRST_INSTALL) ?? false;
    if (firstInstall) {
      await secureStorage.setToken(value: '');
      storage.write(StorageName.FIRST_INSTALL, false);
    }
  }
}
