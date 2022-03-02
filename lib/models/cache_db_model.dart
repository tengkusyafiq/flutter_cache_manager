import 'cache_db_base_model.dart';

class FlutterCacheDBModel extends CacheDBBaseModel {
  static String table = 'flutter_cache_data';

  String key;
  String syncData;
  int? syncTime;

  FlutterCacheDBModel({
    required this.key,
    required this.syncData,
    this.syncTime,
  });

  static FlutterCacheDBModel fromMap(Map<String, dynamic> map) {
    return FlutterCacheDBModel(
      key: map["key"],
      syncData: map["syncData"].toString(),
      syncTime: map["syncTime"],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map.addAll(
      {
        'key': key,
        'syncData': syncData,
        'syncTime': syncTime,
      },
    );

    return map;
  }
}
