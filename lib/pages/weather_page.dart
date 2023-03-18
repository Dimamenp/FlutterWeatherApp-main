import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_flutter/providers/weather_provider.dart';
import 'package:weather_app_flutter/utils/constants.dart';
import 'package:weather_app_flutter/utils/helper_functions.dart';
import 'package:weather_app_flutter/utils/text_style.dart';

import '../utils/location_service.dart';

class WeatherPage extends StatefulWidget {
  static String routeName = '/';

  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late WeatherProvider provider;
  bool isFirst = true;

  @override
  void didChangeDependencies() {
    if (isFirst) {
      provider = Provider.of<WeatherProvider>(context);
      _detectLocation();
      isFirst = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Погода'),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {
              _detectLocation();
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final result = await showSearch(
                  context: context, delegate: _CitySearchDeligate());

              if (result != null && result.isNotEmpty) {
                provider.convertCityToLatLng(result: result, onError: (msg){
                  showMsg(context ,msg);
                });
              }
            },
          ),
        ],
      ),
      body: Center(
        child: provider.hasDataLoaded
            ? ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                children: [
                  _currentWeatherSection(),
                  _forecastWeatherSection(),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  Text(
                    'Пожалуйста подождите',
                    style: txtAddress25,
                  )
                ],
              ),
      ),
    );
  }

  void _detectLocation() async {
    try{
      final position = await determinePosition();
      provider.setNewLocation(position.latitude, position.longitude);
      provider.setTempUnit(await provider.getTempUnitPreferenceValue());
      provider.getWeatherData();
    }catch(error){
      showMsg(context, 'Ошибка');
    }
  }

  Widget _currentWeatherSection() {
    final current = provider.currentResponseModel;
    return Column(
      children: [
        Text(
          getFormattedDateTime(
            current!.dt!,
            'MMM dd, yyyyy',
          ),
          style: txtDateBig18,
        ),
        Text(
          '${current.name}, ${current.sys!.country}',
         style: txtAddress25,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                '$iconPrefix${current.weather![0].icon}$iconSuffix',
                fit: BoxFit.cover,
              ),
              Text(
                '${current.main!.temp!.round()}$degree${provider.unitSymbol}',
                style: txtTempBig70,
              ),
            ],
          ),
        ),
        Text(
          'Ощущается как ${current.main!.feelsLike}$degree${provider.unitSymbol}',
         style: txtNormal16White54,
        ),
        Text(
          '${current.weather![0].description}',
          style: txtNormal16White54,
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _forecastWeatherSection() {
    final forecast = provider.forecastResponseModel;
    //final city = provider.city;
    return Card(
      elevation: 10,
      color: Colors.blue,
      child: Column(
        children: forecast!.list!
            .map((item) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        '$iconPrefix${item.weather![0].icon}$iconSuffix'),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Row(children: [
                    Text(
                      getFormattedDateTime(item.dt!, 'MMM dd'),
                      style: txtNormal16,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.watch_later),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      getFormattedDateTime(item.dt!, 'hh:mm a'),
                      style: txtNormal16White54,
                    ),
                  ]),
                  subtitle: Row(children: [
                    Text(
                      item.weather![0].description!,
                      style: txtNormal12White54,
                    ),
                  ]),
                  trailing: Text(
                    '${item.main!.temp!.round()}$degree${provider.unitSymbol}',
                    style: txtNormal16,
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class _CitySearchDeligate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      onPressed: () {},
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.search),
      title: Text(query),
      onTap: () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredList = query.isEmpty
        ? cities
        : cities
            .where((city) => city.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) => ListTile(
              title: Text(filteredList[index]),
              onTap: () {
                query = filteredList[index];
                close(context, query);
              },
            ));
  }
}
