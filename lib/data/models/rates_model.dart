class RatesModel {
  String? disclaimer;
  String? license;
  int? timestamp;
  String? base;
  Rates? rates;

  RatesModel(
      this.disclaimer, this.license, this.timestamp, this.base, this.rates);

  factory RatesModel.fromJson(dynamic json) {
    return RatesModel(
      json['disclaimer'] as String,
      json['license'] as String,
      json['timestamp'] as int,
      json['base'] as String,
      Rates.fromJson(json['rates']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['disclaimer'] = this.disclaimer;
    data['license'] = this.license;
    data['timestamp'] = this.timestamp;
    data['base'] = this.base;
    if (this.rates != null) {
      data['rates'] = this.rates?.toJson();
    }
    return data;
  }
}

class Rates {
  double? aED;
  double? cAD;
  double? eUR;
  double? gBP;

  Rates(this.aED, this.cAD, this.eUR, this.gBP);

  factory Rates.fromJson(dynamic json) {
    return Rates(
      json['AED'] as double,
      json['CAD'] as double,
      json['EUR'] as double,
      json['GBP'] as double,
    );

    /*aED = json['AED'];
    cAD = json['CAD'];
    eUR = json['EUR'];
    gBP = json['GBP'];*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AED'] = this.aED;
    data['CAD'] = this.cAD;
    data['EUR'] = this.eUR;
    data['GBP'] = this.gBP;
    return data;
  }
}
