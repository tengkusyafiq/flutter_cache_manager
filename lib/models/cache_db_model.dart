import 'cache_db_base_model.dart';

class FlutterCacheDBModel extends FlutterCacheDBBaseModel {
  static String table = 'flutter_cache_data';

  String key;
  String syncData;
  int? syncTime;
  bool isInvalidated;

  FlutterCacheDBModel({
    required this.key,
    required this.syncData,
    this.syncTime,
    this.isInvalidated = false,
  });

  static FlutterCacheDBModel fromMap(Map<String, dynamic> map) {
    return FlutterCacheDBModel(
      key: map["key"],
      syncData: map["syncData"].toString(),
      syncTime: map["syncTime"],
      isInvalidated: map["isInvalidated"] == 1,
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
        'isInvalidated': isInvalidated == true ? 1 : 0,
      },
    );

    return map;
  }
}
