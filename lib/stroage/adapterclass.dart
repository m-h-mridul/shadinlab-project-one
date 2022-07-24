import 'package:hive_flutter/adapters.dart';
import '../model/modelapidata.dart';
part 'adapterclass.g.dart';

@HiveType(typeId: 0)
class PostDataList extends HiveObject {
  @HiveField(0)
  List<Post> systolicPressure;
  PostDataList({required this.systolicPressure});
}
