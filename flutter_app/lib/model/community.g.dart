// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Community _$CommunityFromJson(Map<String, dynamic> json) {
  return Community(
    name: json['name'] as String,
    description: json['description'] as String,
    links: json['links'] == null
        ? null
        : Source.fromJson(json['links'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommunityToJson(Community instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'links': instance.links,
    };

Source _$SourceFromJson(Map<String, dynamic> json) {
  return Source(
    facebook: json['facebook'] as String,
    twitter: json['twitter'] as String,
    instagram: json['instagram'] as String,
    website: json['website'] as String,
    youtube: json['youtube'] as String,
    github: json['github'] as String,
    medium: json['medium'] as String,
    meetup: json['meetup'] as String,
    slack: json['slack'] as String,
  );
}

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
      'facebook': instance.facebook,
      'twitter': instance.twitter,
      'instagram': instance.instagram,
      'website': instance.website,
      'youtube': instance.youtube,
      'github': instance.github,
      'medium': instance.medium,
      'meetup': instance.meetup,
      'slack': instance.slack,
    };
