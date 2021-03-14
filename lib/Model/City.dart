class City {
  String dbId = "";
  String cityName;
  String iD;

  get cityname => cityName;

  City.constructor(String id, String cityName) {
    this.iD = id;
    this.cityName = cityName;
  }

  City.fromJson(Map<String, dynamic> json)
      : dbId = json["dbId"].toString(),
        cityName = json["CityName"],
        iD = json["ID"];

  Map<String, dynamic> toJson() => {'CityName': cityName, 'ID': iD};
}
