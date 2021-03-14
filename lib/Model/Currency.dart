class Currency {
  String dbId = "";
  String currencyName;
  String iD;


  Currency.constructor(String id, String currencyName) {
    this.iD = id;
    this.currencyName = currencyName;
  }

  Currency.fromJson(Map<String, dynamic> json)
      : dbId = json["dbId"].toString(),
        currencyName = json["CurrencyName"],
        iD = json["ID"];

  Map<String, dynamic> toJson() => {'CurrencyName': currencyName, 'ID': iD};
}
