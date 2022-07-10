class Ad {
  int id;
  String link;

  Ad({this.id, this.link});

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        id: json["id"],
        link: json["link"],
      );
}
