import 'package:hive_flutter/adapters.dart';
import '../model/dataModel.dart';

class Hivedb {
  static String boxname = 'datalist';
  final _box = Hive.box(boxname);
  static String dataName = 'datalist';

  Future<String> dataCheak() async {
    return await _box.get(dataName) ?? Future.value('Not find');
  }

  Future<List<DataModel>> getdata() async {
    return await _box.get(dataName);
  }

  putdata(List<DataModel> data) {
    _box.put(dataName, data);
  }
}
