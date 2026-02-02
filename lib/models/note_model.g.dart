// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 0;

  @override
  NoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModel(
      id: fields[0] as String,
      title: fields[1] as String,
      content: fields[2] as String,
      createdAt: fields[3] as DateTime,
      updatedAt: fields[4] as DateTime,
      tags: (fields[5] as List).cast<String>(),
      backgroundColor: fields[6] as String,
      fontStyle: fields[7] as String,
      isLocked: fields[8] as bool,
      isPinned: fields[9] as bool,
      unlockDate: fields[10] as DateTime?,
      imagePaths: (fields[11] as List).cast<String>(),
      isChecklist: fields[12] as bool,
      checklistItems: (fields[13] as List).cast<ChecklistItem>(),
      reminderDate: fields[14] as DateTime?,
      isArchived: fields[15] as bool,
      isFavorite: fields[16] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt)
      ..writeByte(5)
      ..write(obj.tags)
      ..writeByte(6)
      ..write(obj.backgroundColor)
      ..writeByte(7)
      ..write(obj.fontStyle)
      ..writeByte(8)
      ..write(obj.isLocked)
      ..writeByte(9)
      ..write(obj.isPinned)
      ..writeByte(10)
      ..write(obj.unlockDate)
      ..writeByte(11)
      ..write(obj.imagePaths)
      ..writeByte(12)
      ..write(obj.isChecklist)
      ..writeByte(13)
      ..write(obj.checklistItems)
      ..writeByte(14)
      ..write(obj.reminderDate)
      ..writeByte(15)
      ..write(obj.isArchived)
      ..writeByte(16)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChecklistItemAdapter extends TypeAdapter<ChecklistItem> {
  @override
  final int typeId = 1;

  @override
  ChecklistItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChecklistItem(
      text: fields[0] as String,
      isCompleted: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ChecklistItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChecklistItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
