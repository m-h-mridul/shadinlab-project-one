// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adapterclass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostDataListAdapter extends TypeAdapter<PostDataList> {
  @override
  final int typeId = 0;

  @override
  PostDataList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostDataList(
      systolicPressure: (fields[0] as List).cast<Post>(),
    );
  }

  @override
  void write(BinaryWriter writer, PostDataList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.systolicPressure);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostDataListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
