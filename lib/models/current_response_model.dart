class CurrentResponseModel {
  CurrentResponseModel({
    this.weather,
    this.main,
    this.dt,
    this.sys,
    this.name,
  });

  CurrentResponseModel.fromJson(dynamic json) {
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather?.add(Weather.fromJson(v));
      });
    }
    main = json['main'] != null ? Main.fromJson(json['main']) : null;
    dt = json['dt'];
    sys = json['sys'] != null ? Sys.fromJson(json['sys']) : null;
    name = json['name'];
  }

  List<Weather>? weather;
  Main? main;
  num? dt;
  Sys? sys;
  String? name;

  CurrentResponseModel copyWith({
    List<Weather>? weather,
    Main? main,
    num? dt,
    Sys? sys,
    String? name,

  }) =>
      CurrentResponseModel(
        weather: weather ?? this.weather,
        main: main ?? this.main,
        dt: dt ?? this.dt,
        sys: sys ?? this.sys,
        name: name ?? this.name,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (weather != null) {
      map['weather'] = weather?.map((v) => v.toJson()).toList();
    }
    if (main != null) {
      map['main'] = main?.toJson();
    }
    map['dt'] = dt;
    if (sys != null) {
     map['sys'] = sys?.toJson();
   }
    map['name'] = name;
    return map;
  }
}

class Sys {
  Sys({
   this.country,
  });

  Sys.fromJson(dynamic json) {
    country = json['country'];
  }

  String? country;

  Sys copyWith({
  String? country,
  }) =>
      Sys(
        country: country ?? this.country,
      );

  Map<String, dynamic> toJson() {
   final map = <String, dynamic>{};
    map['country'] = country;
    return map;
  }
}
class Main {
  Main({
    this.temp,
    this.feelsLike,
  });

  Main.fromJson(dynamic json) {
    temp = json['temp'];
    feelsLike = json['feels_like'];
  }

  num? temp;
  num? feelsLike;

  Main copyWith({
    num? temp,
    num? feelsLike,
  }) =>
      Main(
        temp: temp ?? this.temp,
        feelsLike: feelsLike ?? this.feelsLike,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['temp'] = temp;
    map['feels_like'] = feelsLike;
    return map;
  }
}

class Weather {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  Weather.fromJson(dynamic json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  num? id;
  String? main;
  String? description;
  String? icon;

  Weather copyWith({
    num? id,
    String? main,
    String? description,
    String? icon,
  }) =>
      Weather(
        id: id ?? this.id,
        main: main ?? this.main,
        description: description ?? this.description,
        icon: icon ?? this.icon,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['main'] = main;
    map['description'] = description;
    map['icon'] = icon;
    return map;
  }
}

