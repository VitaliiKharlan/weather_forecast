import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:weather_forecast/features/details/view/details_screen.dart';
import 'package:weather_forecast/features/main/view/main_screen.dart';

import 'package:weather_forecast/features/theme/app.images.dart';
import 'package:weather_forecast/features/theme/app_text_style.dart';
import 'package:weather_forecast/repositories/weather_details/local_weather_search_lat_lon_repository.dart';
import 'package:weather_forecast/repositories/weather_details/local_weather_search_repository.dart';
import 'package:weather_forecast/repositories/weather_details/models/air_pollution_details.dart';
import 'package:weather_forecast/repositories/weather_details/models/city_coordinate.dart';
import 'package:weather_forecast/repositories/weather_details/models/weather_forecast_details.dart';
import 'package:weather_forecast/repositories/weather_details/models/weather_forecast_hourly_details.dart';

class LocalWeatherSearch extends StatelessWidget {
  const LocalWeatherSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E335A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E335A),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Search City or Airport',
          style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
            color: Colors.white.withOpacity(0.72),
            fontSize: 20,
            height: 1.2,
          ),
          maxLines: 2,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () async {
              // 1. option - show results
              //
              showSearch(
                context: context,
                delegate: CitySearch(),
              );

              // 2. option - close search & return result
              //
              // final results = await showSearch(
              //   context: context,
              //   delegate: CitySearch(),
              // );
              // print('Result: $results');
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Local',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            Text(
              'Weather',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            Text(
              'Search',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CitySearch extends SearchDelegate<String> {
  final cities = [
    'London',
    'Berlin',
    'Paris',
    'Tokyo',
    'Canberra',
  ];

  final recentCities = [
    'London',
    'Berlin',
    'Paris',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          // query = '';
          if (query.isEmpty) {
            close(context, '');
          } else {
            query = '';
            showSuggestions(context);
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

  // implementation without internet access
  //
  // @override
  // Widget buildResults(BuildContext context) {
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         const Icon(Icons.location_city, size: 120),
  //         const SizedBox(height: 48),
  //         Text(
  //           query,
  //           style: const TextStyle(
  //             color: Colors.black,
  //             fontWeight: FontWeight.bold,
  //             fontSize: 40,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // implementation with internet access
  // something went wrong
  //
  // @override
  // Widget buildResults(BuildContext context) {
  //   return const MainScreen();
  // }

  // implementation with internet access
  //
  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<WeatherForecastDetails>(
      future: LocalWeatherSearchLatLonRepository.getLocalWeatherSearchLatLon(
          latCoord: 50.45, lonCoord: 30.52),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Container(
                color: Colors.black,
                alignment: Alignment.center,
                child: const Text(
                  'Something went wrong!',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
              );
            } else {
              return buildResultSuccess(snapshot.requireData);
            }
        }
      },
    );
  }

  // implementation without internet access
  //
  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   final suggestions = query.isEmpty
  //       ? recentCities
  //       : cities.where((city) {
  //           final cityLower = city.toLowerCase();
  //           final queryLower = query.toLowerCase();
  //
  //           return cityLower.startsWith(queryLower);
  //         }).toList();
  //
  //   return buildSuggestionsSuccess(suggetions);
  // }

  // implementation with internet access
  //
  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: const Color(0xFF2E335A),
      child: FutureBuilder<List<String>>(
        future:
            LocalWeatherSearchRepository.getLocalWeatherSearch(query: query),
        builder: (context, snapshot) {
          if (query.isEmpty) return buildNoSuggestions();

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError || snapshot.requireData.isEmpty) {
                return buildNoSuggestions();
              } else {
                return buildSuggestionsSuccess(snapshot.requireData);
              }
          }
        },
      ),
    );
  }

  Widget buildNoSuggestions() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Enter the name',
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
            ),
          ),
          Text(
            'of the city or airport',
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSuggestionsSuccess(List<String> suggestions) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        final queryText = suggestion.substring(0, query.length);
        final remainingText = suggestion.substring(query.length);

        return ListTile(
          onTap: () {
            query = suggestion;

            // 1. option - show results
            //
            showResults(context);

            // 2. option - close search & return result
            //
            // close(context, suggestion);

            // 3. option - navigate to Result Page
            //
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (BuildContext context) => ResultPage(suggestion),
            //   ),
            // );
          },
          leading: const Icon(
            Icons.location_city,
            color: Colors.white,
          ),
          // title: Text(suggestion),
          title: RichText(
            text: TextSpan(
              text: queryText,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: [
                TextSpan(
                  text: remainingText,
                  style: const TextStyle(
                    color: Colors.grey,
                    // fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// implementation with internet access
//
Widget buildResultSuccess(WeatherForecastDetails weatherForecastDetails) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF3279e2), Colors.purple],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: ListView(
      padding: const EdgeInsets.all(64),
      children: [
        Text(
          weatherForecastDetails.name,
          // weather.city,
          style: const TextStyle(
            fontSize: 40,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        const SizedBox(
          height: 120,
          width: 120,
          child: Image(
            image: AssetImage(
              'assets/icons/big_icon_tornado.png',
            ),
            height: 120,
            width: 120,
            color: Colors.white,
          ),
        ),
        // const Icon(
        //   Icons.add,
        //   // weather.icon,
        //   color: Colors.white,
        //   size: 140,
        // ),
        const SizedBox(height: 72),
        Text(
          weatherForecastDetails.weather.first.description.toUpperCase(),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${weatherForecastDetails.main.temp.toStringAsFixed(0)}\u00B0',
              style: const TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // Text(
            //   '\u00B0',
            //   style: style,
            // ),

            // Text('${weather.degrees}°', style: style),
          ],
        ),
      ],
    ),
  );
}

// Widget buildDegrees(WeatherForecastDetails weatherForecastDetails) {
//   const style = TextStyle(
//     fontSize: 100,
//     fontWeight: FontWeight.bold,
//     color: Colors.white,
//   );
//
//   return const Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Text(
//         ,
//         style: style,
//       ),
//       Text(
//         '\u00B0',
//         style: style,
//       ),
//
//       // Text('${weather.degrees}°', style: style),
//     ],
//   );
// }
