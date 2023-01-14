// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileAdapter extends TypeAdapter<_$_Profile> {
  @override
  final int typeId = 2;

  @override
  _$_Profile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Profile(
      firstName: fields[0] as String?,
      lastName: fields[1] as String?,
      email: fields[2] as String?,
      mobileNumber: fields[3] as String?,
      gender: fields[4] as String?,
      dob: fields[5] as String?,
      qualification: fields[6] as String?,
      experience: fields[7] as String?,
      nationality: fields[8] as String?,
      currCountry: fields[9] as String?,
      currCity: fields[10] as String?,
      photo: fields[11] as String?,
      regDate: fields[12] as String?,
      userType: fields[13] as String?,
      isPremium: fields[14] as String?,
      premiumDtart: fields[15] as String?,
      premiumEnd: fields[16] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Profile obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.mobileNumber)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.dob)
      ..writeByte(6)
      ..write(obj.qualification)
      ..writeByte(7)
      ..write(obj.experience)
      ..writeByte(8)
      ..write(obj.nationality)
      ..writeByte(9)
      ..write(obj.currCountry)
      ..writeByte(10)
      ..write(obj.currCity)
      ..writeByte(11)
      ..write(obj.photo)
      ..writeByte(12)
      ..write(obj.regDate)
      ..writeByte(13)
      ..write(obj.userType)
      ..writeByte(14)
      ..write(obj.isPremium)
      ..writeByte(15)
      ..write(obj.premiumDtart)
      ..writeByte(16)
      ..write(obj.premiumEnd);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Profile _$$_ProfileFromJson(Map<String, dynamic> json) => _$_Profile(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      mobileNumber: json['mobile_number'] as String?,
      gender: json['gender'] as String?,
      dob: json['dob'] as String?,
      qualification: json['qualification'] as String?,
      experience: json['experience'] as String?,
      nationality: json['nationality'] as String?,
      currCountry: json['curr_country'] as String?,
      currCity: json['curr_city'] as String?,
      photo: json['photo'] as String?,
      regDate: json['reg_date'] as String?,
      userType: json['user_type'] as String?,
      isPremium: json['is_premium'] as String?,
      premiumDtart: json['premium_dtart'] as String?,
      premiumEnd: json['premium_end'] as String?,
    );

Map<String, dynamic> _$$_ProfileToJson(_$_Profile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('first_name', instance.firstName);
  writeNotNull('last_name', instance.lastName);
  writeNotNull('email', instance.email);
  writeNotNull('mobile_number', instance.mobileNumber);
  writeNotNull('gender', instance.gender);
  writeNotNull('dob', instance.dob);
  writeNotNull('qualification', instance.qualification);
  writeNotNull('experience', instance.experience);
  writeNotNull('nationality', instance.nationality);
  writeNotNull('curr_country', instance.currCountry);
  writeNotNull('curr_city', instance.currCity);
  writeNotNull('photo', instance.photo);
  writeNotNull('reg_date', instance.regDate);
  writeNotNull('user_type', instance.userType);
  writeNotNull('is_premium', instance.isPremium);
  writeNotNull('premium_dtart', instance.premiumDtart);
  writeNotNull('premium_end', instance.premiumEnd);
  return val;
}
