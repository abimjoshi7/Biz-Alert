// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hivemodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceAdapter extends TypeAdapter<StockDbModel> {
  @override
  final int typeId = 0;

  @override
  StockDbModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StockDbModel(
      status: fields[0] as String,
      message: fields[1] as String,
      dataCollection: (fields[2] as List).cast<DataCollection>(),
    );
  }

  @override
  void write(BinaryWriter writer, StockDbModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.dataCollection);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ServiceAdapter1 extends TypeAdapter<DataCollection> {
  @override
  final int typeId = 1;

  @override
  DataCollection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataCollection(
      companyId: fields[3] as int?,
      companyName: fields[4] as String,
      stockSymbol: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DataCollection obj) {
    writer
      ..writeByte(3)
      ..writeByte(3)
      ..write(obj.companyId)
      ..writeByte(4)
      ..write(obj.companyName)
      ..writeByte(5)
      ..write(obj.stockSymbol);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceAdapter1 &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
