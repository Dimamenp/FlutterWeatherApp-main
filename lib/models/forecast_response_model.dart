class ForecastResponseModel {
  ForecastResponseModel({
    this.list,
    this.city,
  });

  ForecastResponseModel.fromJson(dynamic json) {
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list?.add(ForecastItem.fromJson(v));
      });
    }
    city = json['city'] != null ? City.fromJson(json['city']) : null;
  }
  List<ForecastItem>? list;
  City? city;

  ForecastResponseModel copyWith({
    List<ForecastItem>? list,
    City? city,
  }) =>
      ForecastResponseModel(
        list: list ?? this.list,
        city: city ?? this.city,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (list != null) {
      map['list'] = list?.map((v) => v.toJson()).toList();
    }
    if (city != null) {
      map['city'] = city?.toJson();
    }
    return map;
  }
}

class City {
  City({
    this.id,
    this.name,
    this.country,
  });

  City.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
  }

  num? id;
  String? name;
  String? country;

  City copyWith({
    num? id,
    String? name,
    String? country,
  }) =>
      City(
        id: id ?? this.id,
        name: name ?? this.name,
        country: country ?? this.country,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['country'] = country;
    return map;
  }
}

class ForecastItem {
  ForecastItem({
    this.dt,
    this.main,
    this.weather,
    this.dtTxt,
  });

  ForecastItem.fromJson(dynamic json) {
    dt = json['dt'];
    main = json['main'] != null ? Main.fromJson(json['main']) : null;
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather?.add(Weather.fromJson(v));
      });
    }
    dtTxt = json['dt_txt'];
  }

  num? dt;
  Main? main;
  List<Weather>? weather;
  String? dtTxt;

  ForecastItem copyWith({
    num? dt,
    Main? main,
    List<Weather>? weather,

    String? dtTxt,
  }) =>
      ForecastItem(
        dt: dt ?? this.dt,
        main: main ?? this.main,
        weather: weather ?? this.weather,
        dtTxt: dtTxt ?? this.dtTxt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dt'] = dt;
    if (main != null) {
      map['main'] = main?.toJson();
    }
    if (weather != null) {
      map['weather'] = weather?.map((v) => v.toJson()).toList();
    }
    map['dt_txt'] = dtTxt;
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

class Main {
  Main({
    this.temp,
  });

  Main.fromJson(dynamic json) {
    temp = json['temp'];
  }

  num? temp;

  Main copyWith({
    num? temp,
  }) =>
      Main(
        temp: temp ?? this.temp,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['temp'] = temp;
    return map;
  }
}
