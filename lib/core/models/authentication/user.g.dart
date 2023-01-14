// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<_$_User> {
  @override
  final int typeId = 1;

  @override
  _$_User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_User(
      firstName: fields[0] as String?,
      lastName: fields[1] as String?,
      email: fields[2] as String?,
      regDate: fields[3] as String?,
      regIp: fields[4] as String?,
      emailConfirm: fields[5] as String?,
      userType: fields[6] as String?,
      typeApproved: fields[7] as String?,
      phoneNumber: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$_User obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.regDate)
      ..writeByte(4)
      ..write(obj.regIp)
      ..writeByte(5)
      ..write(obj.emailConfirm)
      ..writeByte(6)
      ..write(obj.userType)
      ..writeByte(7)
      ..write(obj.typeApproved)
      ..writeByte(8)
      ..write(obj.phoneNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      regDate: json['reg_date'] as String?,
      regIp: json['reg_ip'] as String?,
      emailConfirm: json['email_confirm'] as String?,
      userType: json['user_type'] as String?,
      typeApproved: json['type_approved'] as String?,
      phoneNumber: json['phone_number'] as String?,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('first_name', instance.firstName);
  writeNotNull('last_name', instance.lastName);
  writeNotNull('email', instance.email);
  writeNotNull('reg_date', instance.regDate);
  writeNotNull('reg_ip', instance.regIp);
  writeNotNull('email_confirm', instance.emailConfirm);
  writeNotNull('user_type', instance.userType);
  writeNotNull('type_approved', instance.typeApproved);
  writeNotNull('phone_number', instance.phoneNumber);
  return val;
}
