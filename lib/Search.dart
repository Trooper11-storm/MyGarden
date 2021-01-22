import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';


// To parse this JSON data, do
//
//     final plants = plantsFromJson(jsonString);


//'https://trefle.io/api/v1/plants?token=Hmdu-XqTVw-cQNvGp-qLuZpckmgvR7FjLLzFLmmu9Iw&filter[common_name]=jerusalem%20artichoke'
//'https://trefle.io/api/v1/plants?token=Hmdu-XqTVw-cQNvGp-qLuZpckmgvR7FjLLzFLmmu9Iw'


String url = 'https://trefle.io/api/v1/plants?token=Hmdu-XqTVw-cQNvGp-qLuZpckmgvR7FjLLzFLmmu9Iw&filter[common_name]=jerusalem%20artichoke';
//my test url from the trefle api which asks for all plants



Future<void> getPlant() async{
  final response = await http.get('$url');
  print(response.body);
  final plantdata = plantsFromJson(response.body);
  print (plantdata.Datum.imageUrl)

} //The getPlant() method will call the API endpoint which is defined in url.
//  A JSON string in response.body will be received,
//  this has to be sent to plantsFromJson so that it can parse the JSON data


Future<void> _saveUrl() async {//i have no idea what i'm doing - just guessing '-'
  final response = await http.get('$url');
 //var myUrl = Datum(imageUrl: response.body).imageUrl;
  //print(Datum.imageUrl);
  //print('${myUrl}');
  print('I am here!');
}


class plantSearch extends StatelessWidget {//'plantSearch screen'
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //sets an Appbar at the top of the screen
        title: Text('plantSearch'), //places a title in the Appbar
        backgroundColor: Colors.green,),
      body: Stack(
        children: <Widget> [
          Align(
              alignment: Alignment.center,
              child: FlatButton(
                child: Text(
                  'get plant',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async => getPlant(),
                color: Colors.green,
              )

          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                child: Text(
                  'get image',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async => _saveUrl(),
                color: Colors.green,
              )

          )
        ],
      )
    );
  }
}

/*Plants plantsFromJson(String str) => Plants.fromJson(json.decode(str));

String plantsToJson(Plants data) => json.encode(data.toJson());

class Plants {
  Plants({
    this.data,
    this.links,
    this.meta,
  });

  List<Datum> data;
  PlantsLinks links;
  Meta meta;

  factory Plants.fromJson(Map<String, dynamic> json) => Plants(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    links: json["links"] == null ? null : PlantsLinks.fromJson(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links == null ? null : links.toJson(),
    "meta": meta == null ? null : meta.toJson(),
  };
}

class Datum {
  Datum({
    this.id,
    this.commonName,
    this.slug,
    this.scientificName,
    this.year,
    this.bibliography,
    this.author,
    this.status,
    this.rank,
    this.familyCommonName,
    this.genusId,
    this.imageUrl,
    this.synonyms,
    this.genus,
    this.family,
    this.links,
  });

  int id;
  String commonName;
  String slug;
  String scientificName;
  int year;
  String bibliography;
  Author author;
  Status status;
  Rank rank;
  String familyCommonName;
  int genusId;
  String imageUrl;
  List<String> synonyms;
  String genus;
  String family;
  DatumLinks links;


  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    commonName: json["common_name"] == null ? null : json["common_name"],
    slug: json["slug"] == null ? null : json["slug"],
    scientificName: json["scientific_name"] == null ? null : json["scientific_name"],
    year: json["year"] == null ? null : json["year"],
    bibliography: json["bibliography"] == null ? null : json["bibliography"],
    author: json["author"] == null ? null : authorValues.map[json["author"]],
    status: json["status"] == null ? null : statusValues.map[json["status"]],
    rank: json["rank"] == null ? null : rankValues.map[json["rank"]],
    familyCommonName: json["family_common_name"] == null ? null : json["family_common_name"],
    genusId: json["genus_id"] == null ? null : json["genus_id"],
    imageUrl: json["image_url"] == null ? null : json["image_url"],
    synonyms: json["synonyms"] == null ? null : List<String>.from(json["synonyms"].map((x) => x)),
    genus: json["genus"] == null ? null : json["genus"],
    family: json["family"] == null ? null : json["family"],
    links: json["links"] == null ? null : DatumLinks.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "common_name": commonName == null ? null : commonName,
    "slug": slug == null ? null : slug,
    "scientific_name": scientificName == null ? null : scientificName,
    "year": year == null ? null : year,
    "bibliography": bibliography == null ? null : bibliography,
    "author": author == null ? null : authorValues.reverse[author],
    "status": status == null ? null : statusValues.reverse[status],
    "rank": rank == null ? null : rankValues.reverse[rank],
    "family_common_name": familyCommonName == null ? null : familyCommonName,
    "genus_id": genusId == null ? null : genusId,
    "image_url": imageUrl == null ? null : imageUrl,
    "synonyms": synonyms == null ? null : List<dynamic>.from(synonyms.map((x) => x)),
    "genus": genus == null ? null : genus,
    "family": family == null ? null : family,
    "links": links == null ? null : links.toJson(),
  };
}

enum Author { LAM, L, JACQ, L_MAXIM }

final authorValues = EnumValues({
  "Jacq.": Author.JACQ,
  "L.": Author.L,
  "Lam.": Author.LAM,
  "(L.) Maxim.": Author.L_MAXIM
});

class DatumLinks {
  DatumLinks({
    this.self,
    this.plant,
    this.genus,
  });

  String self;
  String plant;
  String genus;

  factory DatumLinks.fromJson(Map<String, dynamic> json) => DatumLinks(
    self: json["self"] == null ? null : json["self"],
    plant: json["plant"] == null ? null : json["plant"],
    genus: json["genus"] == null ? null : json["genus"],
  );

  Map<String, dynamic> toJson() => {
    "self": self == null ? null : self,
    "plant": plant == null ? null : plant,
    "genus": genus == null ? null : genus,
  };
}

enum Rank { SPECIES }

final rankValues = EnumValues({
  "species": Rank.SPECIES
});

enum Status { ACCEPTED }

final statusValues = EnumValues({
  "accepted": Status.ACCEPTED
});

class PlantsLinks {
  PlantsLinks({
    this.self,
    this.first,
    this.next,
    this.last,
  });

  String self;
  String first;
  String next;
  String last;

  factory PlantsLinks.fromJson(Map<String, dynamic> json) => PlantsLinks(
    self: json["self"] == null ? null : json["self"],
    first: json["first"] == null ? null : json["first"],
    next: json["next"] == null ? null : json["next"],
    last: json["last"] == null ? null : json["last"],
  );

  Map<String, dynamic> toJson() => {
    "self": self == null ? null : self,
    "first": first == null ? null : first,
    "next": next == null ? null : next,
    "last": last == null ? null : last,
  };
}

class Meta {
  Meta({
    this.total,
  });

  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "total": total == null ? null : total,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
*/
