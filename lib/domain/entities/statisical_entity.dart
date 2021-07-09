class Statisical{

  int? infected;
  int? recovered;
  int? death;
  int? newInfected;
  int? newRecovered;
  int? newDeath;
  Statisical(
      {
        this.infected,
        this.recovered,
        this.death,
        this.newInfected,
        this.newRecovered,
        this.newDeath,
      });
  factory Statisical.fromJson(Map<String, dynamic> json) {
    return Statisical(
      infected: json['cases'] as int,
      recovered: json['recovered']as int,
      death: json['deaths']as int,
      newInfected: json['todayCases']as int,
      newRecovered: json['todayRecovered']as int,
      newDeath: json['todayDeaths']as int,
    );
  }
}