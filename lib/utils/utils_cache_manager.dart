import 'package:flutter_cache_manager_tg/models/cache_db_model.dart';

import 'utils_cache_db_helper.dart';

class FlutterCacheManager extends FlutterCacheDBHelper {
  static FlutterCacheManager? _instance;

  factory FlutterCacheManager() {
    if (_instance == null) {
      _instance = new FlutterCacheManager._();
    }
    return _instance!;
  }

  FlutterCacheManager._();

  Future<bool> addCacheData(FlutterCacheDBModel model) async {
    await FlutterCacheDBHelper.init();
    bool isSaved = false;
    model.syncTime = new DateTime.now().millisecondsSinceEpoch;

    int res;

    if (!await this.isFlutterCacheKeyExist(model.key)) {
      res = await FlutterCacheDBHelper.insert(FlutterCacheDBModel.table, model);
    } else {
      res = await FlutterCacheDBHelper.customUpdate(
        FlutterCacheDBModel.table,
        model,
        columnName: "key",
        columnValue: model.key,
      );
    }

    isSaved = res > 0 ? true : false;

    return isSaved;
  }

  Future<FlutterCacheDBModel> getCacheData(String key) async {
    await FlutterCacheDBHelper.init();

    List<Map<String, dynamic>> cacheData = await FlutterCacheDBHelper.conditionalQuery(
      FlutterCacheDBModel.table,
      "key = ?",
      key,
    );

    return cacheData.map((item) => FlutterCacheDBModel.fromMap(item)).first;
  }

  Future<bool> isFlutterCacheKeyExist(String key) async {
    await FlutterCacheDBHelper.init();

    List<Map<String, dynamic>> cacheData = await FlutterCacheDBHelper.conditionalQuery(
      FlutterCacheDBModel.table,
      "key = ?",
      key,
    );

    return cacheData.length == 1 ? true : false;
  }

  Future<List<String>> getAllKeysContains(String key) async {
    await FlutterCacheDBHelper.init();

    List<Map<String, dynamic>> cacheData = await FlutterCacheDBHelper.conditionalQuery(
      FlutterCacheDBModel.table,
      "key LIKE ?",
      '%$key%',
    );

    return cacheData.map((item) => item["key"] as String).toList();
  }

  Future<void> emptyCache() async {
    await FlutterCacheDBHelper.init();
    FlutterCacheDBHelper.deleteAll(FlutterCacheDBModel.table);
  }

  Future<bool> deleteCache(String keyName) async {
    await FlutterCacheDBHelper.init();
    int res;
    res = await FlutterCacheDBHelper.delete(FlutterCacheDBModel.table, "key", keyName);

    return res == 1 ? true : false;
  }
}
