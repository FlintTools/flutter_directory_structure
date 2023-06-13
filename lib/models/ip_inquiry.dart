// To parse this JSON data, do
//
//     final expressDelivery = expressDeliveryFromJson(jsonString);

import 'dart:convert';

IpInquiry expressDeliveryFromJson(String str) => IpInquiry.fromJson(json.decode(str));

String expressDeliveryToJson(IpInquiry data) => json.encode(data.toJson());

class IpInquiry {
  IpInquiry({
    this.continent = "",
    this.owner = "",
    this.country = "",
    this.lng = "",
    this.adcode = "",
    this.city = "",
    this.timezone = "",
    this.isp = "",
    this.accuracy = "",
    this.source = "",
    this.areacode = "",
    this.zipcode = "",
    this.radius = "",
    this.prov = "",
    this.lat = "",
    this.queryIp = "",
  });

  String continent;
  String owner;
  String country;
  String lng;
  String adcode;
  String city;
  String timezone;
  String isp;
  String accuracy;
  String source;
  String areacode;
  String zipcode;
  String radius;
  String prov;
  String lat;
  String queryIp;

  factory IpInquiry.fromJson(Map<String, dynamic> json) => IpInquiry(
        continent: json["continent"],
        owner: json["owner"],
        country: json["country"],
        lng: json["lng"],
        adcode: json["adcode"],
        city: json["city"],
        timezone: json["timezone"],
        isp: json["isp"],
        accuracy: json["accuracy"],
        source: json["source"],
        areacode: json["areacode"],
        zipcode: json["zipcode"],
        radius: json["radius"],
        prov: json["prov"],
        lat: json["lat"],
      );

  Map<String, dynamic> toJson() => {
        "continent": continent,
        "owner": owner,
        "country": country,
        "lng": lng,
        "adcode": adcode,
        "city": city,
        "timezone": timezone,
        "isp": isp,
        "accuracy": accuracy,
        "source": source,
        "areacode": areacode,
        "zipcode": zipcode,
        "radius": radius,
        "prov": prov,
        "lat": lat,
      };
}
