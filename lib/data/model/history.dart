class History {
  ItemCase? itemCase;
  ItemRecovered? itemRecovered;
  ItemDeaths? itemDeaths;
  History({this.itemDeaths, this.itemRecovered, this.itemCase});
  factory History.fromJson(Map<String, dynamic> json) => History(
        itemCase: ItemCase.fromJson(json),
        itemRecovered: ItemRecovered(json: json["recovered"]),
        itemDeaths: ItemDeaths(json: json["deaths"]),
      );
}

class ItemCase {
  Map<String, dynamic>? json;
  ItemCase({this.json});
  factory ItemCase.fromJson(Map<String, dynamic> json) =>
      ItemCase(json: json["cases"]);
}

class ItemRecovered {
  Map<String, dynamic>? json;
  ItemRecovered({this.json});
  factory ItemRecovered.fromJson(Map<String, dynamic> json) =>
      ItemRecovered(json: json["ItemRecovered"]);
}

class ItemDeaths {
  Map<String, dynamic>? json;
  ItemDeaths({this.json});
  factory ItemDeaths.fromJson(Map<String, dynamic> json) =>
      ItemDeaths(json: json["deaths"]);
}
