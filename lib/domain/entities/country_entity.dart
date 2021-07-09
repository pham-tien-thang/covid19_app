// class Country{
//  String? iso2;
//   String? name;
//   String? flag;
//   int? infected;
//   int? recovered;
//   int? death;
//   int? newInfected;
//   int? newRecovered;
//   int? newDeath;
//   Country(
//       {
//         this.infected,
//         this.recovered,
//         this.death,
//         this.newInfected,
//         this.newRecovered,
//         this.newDeath,
//        this.name,
//         this.iso2,
//         this.flag
//       });
//   factory Country.fromJson(List< dynamic> json,int i) {
//     return Country(
//       infected: json[i]['cases'] as int,
//       recovered: json[i]['recovered']as int,
//       death: json[i]['deaths']as int,
//       newInfected: json[i]['todayCases']as int,
//       newRecovered: json[i]['todayRecovered']as int,
//       newDeath: json[i]['todayDeaths']as int,
//       name: json[i]['country'] as String,
//       iso2: json[i]['countryInfo']['iso2'],
//       flag: json[i]['countryInfo']['flag'],
//     );
//   }
// }