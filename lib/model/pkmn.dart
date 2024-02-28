class Pkmn {
  Pkmn({
    this.id,
    this.name,
    this.url,
    this.imageUrl,
  });

  int? id;
  String? name;
  String? url;
  String? imageUrl;

  Pkmn.fromJson(dynamic json) {
    url = json['url'];
    id = int.parse(url!.split('/')[6]);
    name = json['name'];
    imageUrl =
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['url'] = url;
    map['imageUrl'] = imageUrl;
    return map;
  }
}
