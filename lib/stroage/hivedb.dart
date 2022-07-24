import 'package:hive_flutter/adapters.dart';
import '../model/dataModel.dart';
import '../model/modelapidata.dart';

class Hivedb {
  static String boxname = 'Hivebox_todolist';
  final _box = Hive.box(boxname);
  static String datadbName = 'datalist';
  static String postlistdbname = 'postrestapilist';

  bool dataCheak() {
    return _box.isEmpty;
  }

  Future<List<DataModel>> firebasegetdata() async {
    return await _box.get(datadbName);
  }

  Future<List<Post>> restpaigetdata() async {
    return await _box.get(postlistdbname);
  }

  putdata(List<DataModel> data) {
    _box.put(datadbName, data);
  }

  putrestpailist(List<Post> data) {
    _box.put(postlistdbname, data);
  }
}
