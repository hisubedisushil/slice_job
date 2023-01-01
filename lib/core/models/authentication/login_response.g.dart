// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthDataAdapter extends TypeAdapter<_$_AuthData> {
  @override
  final int typeId = 0;

  @override
  _$_AuthData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_AuthData(
      token: fields[0] as String,
      email: fields[1] as String,
      expiresAt: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, _$_AuthData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.expiresAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthData _$$_AuthDataFromJson(Map<String, dynamic> json) => _$_AuthData(
      token: json['token'] as String,
      email: json['email'] as String,
      expiresAt: json['expires_at'] as int?,
    );

Map<String, dynamic> _$$_AuthDataToJson(_$_AuthData instance) {
  final val = <String, dynamic>{
    'token': instance.token,
    'email': instance.email,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('expires_at', instance.expiresAt);
  return val;
}
