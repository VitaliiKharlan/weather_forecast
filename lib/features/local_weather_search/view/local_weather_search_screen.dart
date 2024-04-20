import 'package:flutter/material.dart';
import 'package:weather_forecast/features/controllers/city/city_controller.dart';
import 'package:weather_forecast/features/theme/app_text_style.dart';
import 'package:weather_forecast/repositories/weather_details/local_weather_search_lat_lon_repository.dart';
import 'package:weather_forecast/repositories/weather_details/local_weather_search_repository.dart';
import 'package:weather_forecast/repositories/weather_details/models/weather_forecast_details.dart';

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
              showSearch(
                context: context,
                delegate: CitySearch(),
              );

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
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
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
            showResults(context);
            cityController.addNewCity('Energodar');
          },
          leading: const Icon(
            Icons.location_city,
            color: Colors.white,
          ),
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
          ],
        ),
      ],
    ),
  );
}

