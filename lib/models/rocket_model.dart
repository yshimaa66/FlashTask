class RocketModel {

  dynamic id, name,details,launchpad,
      flightNumber,dateTime,webcastLink,articleLink,youtubeId;


  RocketModel({this.id,this.details,this.launchpad,
    this.name,this.flightNumber,this.dateTime,
    this.webcastLink,this.articleLink,this.youtubeId});


  factory RocketModel.fromJson(Map<String, dynamic> json) {
    {

      return RocketModel(

        id: json['id'],
        details: json["details"],
        launchpad:json["launchpad"],
        name:json["name"],
        flightNumber:json["flight_number"],
        dateTime: json["date_unix"],
        webcastLink: json["links"]["webcast"],
        articleLink: json["links"]["article"],
        youtubeId: json["links"]["youtube_id"]

      );
    }
  }
}