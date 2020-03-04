import 'package:json_annotation/json_annotation.dart';
part 'community.g.dart';


@JsonSerializable()
class Community {
  final String name, description;
  Source links;


  Community({this.name, this.description, this.links});

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      name: json['name'].toString(),
      description: json['description'].toString(),
      links: Source.fromJson(json["links"]),
    );
  }

}

@JsonSerializable()
class Source {
  String facebook;
  String twitter;
  String instagram;
  String website;
  String youtube;
  String github;
  String medium;
  String meetup;
  String slack;


  Source({this.facebook, this.twitter, this.instagram, this.website,
    this.youtube, this.github , this.medium, this.meetup,this.slack});


  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      facebook: json["facebook"] as String,
      twitter: json["twitter"] as String,
      instagram: json["website"] as String,
      website: json["website"] as String,
      youtube: json["youtube"] as String,
      github: json["github"] as String,
      medium: json["medium"] as String,
      meetup: json["meetup"] as String,
      slack: json["slack"] as String,
    );
  }
}