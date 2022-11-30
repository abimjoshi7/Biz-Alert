// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_sector_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SectorAdapter extends TypeAdapter<StockSectorDbModel> {
  @override
  final int typeId = 3;

  @override
  StockSectorDbModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StockSectorDbModel(
      status: fields[6] as String,
      message: fields[7] as String,
      dataCollection: (fields[8] as List).cast<DataCollection>(),
    );
  }

  @override
  void write(BinaryWriter writer, StockSectorDbModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.message)
      ..writeByte(8)
      ..write(obj.dataCollection);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SectorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SectorAdapter1 extends TypeAdapter<DataCollection> {
  @override
  final int typeId = 4;

  @override
  DataCollection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataCollection(
      sectorName: fields[9] as String,
      sectorId: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DataCollection obj) {
    writer
      ..writeByte(2)
      ..writeByte(9)
      ..write(obj.sectorName)
      ..writeByte(10)
      ..write(obj.sectorId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SectorAdapter1 &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
