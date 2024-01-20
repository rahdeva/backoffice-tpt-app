import 'dart:core';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import '/data/local/storage/storage_constants.dart';

class StorageManager {
  final _box = GetStorage(StorageName.STORAGE_NAME);

  Future<void> write(String name, dynamic value) async {
    await _box.write(name, value);
  }

  Future<void> delete(String name) async {
    await _box.remove(name);
  }

  dynamic get(String name) {
    return _box.read(name);
  }

  bool has(String name) {
    return _box.hasData(name);
  }

  String encodeList<T>(List<T> datas) {
    return json.encode(datas);
  }

  Future<void> clearAll() async {
    await _box.erase();
  }
}
