// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Blog _$$_BlogFromJson(Map<String, dynamic> json) => _$_Blog(
      id: json['id'] as String,
      title: json['title'] as String?,
      subTitle: json['sub_title'] as String?,
      shortDesc: json['short_desc'] as String?,
      detailDesc: json['detail_desc'] as String?,
      slug: json['slug'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String?,
      articleBy: json['article_by'] as String?,
      byDesc: json['by_desc'] as String?,
      addDate: json['add_date'] as String?,
      categoryId: json['category_id'] as String?,
      categoryName: json['category_name'] as String?,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$$_BlogToJson(_$_Blog instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('sub_title', instance.subTitle);
  writeNotNull('short_desc', instance.shortDesc);
  writeNotNull('detail_desc', instance.detailDesc);
  writeNotNull('slug', instance.slug);
  writeNotNull('image', instance.image);
  writeNotNull('type', instance.type);
  writeNotNull('article_by', instance.articleBy);
  writeNotNull('by_desc', instance.byDesc);
  writeNotNull('add_date', instance.addDate);
  writeNotNull('category_id', instance.categoryId);
  writeNotNull('category_name', instance.categoryName);
  writeNotNull('link', instance.link);
  return val;
}
