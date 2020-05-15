import 'package:json_annotation/json_annotation.dart';
part 'GetMyWeather.g.dart';

@JsonSerializable()
class GetMyWeather {
  String cod;
  int message;
  int cnt;
  @JsonKey(name: 'list')
  List<Listok> list;
  City city;

  GetMyWeather({this.cod, this.message, this.cnt, this.list, this.city});
  factory GetMyWeather.fromJson(Map<String, dynamic> json) =>
      _$GetMyWeatherFromJson(json);
  Map<String, dynamic> toJson() => _$GetMyWeatherToJson(this);
}

@JsonSerializable()
class Listok {
  int dt;
  Main main;
  List<Weather> weather;
  Clouds clouds;
  Wind wind;
  Sys sys;
  String dtTxt;
  Rain rain;

  Listok(
      {this.dt,
      this.main,
      this.weather,
      this.clouds,
      this.wind,
      this.sys,
      this.dtTxt,
      this.rain});
  factory Listok.fromJson(Map<String, dynamic> json) => _$ListokFromJson(json);
  Map<String, dynamic> toJson() => _$ListokToJson(this);
}

@JsonSerializable()
class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int seaLevel;
  int grndLevel;
  int humidity;
  double tempKf;

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.seaLevel,
      this.grndLevel,
      this.humidity,
      this.tempKf});
  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);
  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable()
class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({this.id, this.main, this.description, this.icon});
  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable()
class Clouds {
  int all;

  Clouds({this.all});
  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);
  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}

@JsonSerializable()
class Wind {
  double speed;
  int deg;

  Wind({this.speed, this.deg});
  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);
  Map<String, dynamic> toJson() => _$WindToJson(this);
}

@JsonSerializable()
class Sys {
  String pod;

  Sys({this.pod});
  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);
  Map<String, dynamic> toJson() => _$SysToJson(this);
}

@JsonSerializable()
class Rain {
  double d3h;

  Rain({this.d3h});
  factory Rain.fromJson(Map<String, dynamic> json) => _$RainFromJson(json);
  Map<String, dynamic> toJson() => _$RainToJson(this);
}

@JsonSerializable()
class City {
  int id;
  String name;
  Coord coord;
  String country;
  int timezone;
  int sunrise;
  int sunset;

  City(
      {this.id,
      this.name,
      this.coord,
      this.country,
      this.timezone,
      this.sunrise,
      this.sunset});
  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
  Map<String, dynamic> toJson() => _$CityToJson(this);
}

@JsonSerializable()
class Coord {
  double lat;
  double lon;

  Coord({this.lat, this.lon});
  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);
  Map<String, dynamic> toJson() => _$CoordToJson(this);
}
