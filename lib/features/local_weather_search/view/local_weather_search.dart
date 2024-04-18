import 'package:flutter/material.dart';
import 'package:weather_forecast/features/theme/app_text_style.dart';


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
              // 1 option - show results
              //
              showSearch(
                context: context,
                delegate: CitySearch(),
              );

              // 2 option - close search & return result
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
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,
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
  List<Widget> buildActions(BuildContext context) => [
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

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, ''),
      );

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_city, size: 120),
            const SizedBox(height: 48),
            Text(
              query,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
          ],
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recentCities
        : cities.where((city) {
            final cityLower = city.toLowerCase();
            final queryLower = query.toLowerCase();

            return cityLower.startsWith(queryLower);
          }).toList();

    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          final queryText = suggestion.substring(0, query.length);
          final remainingText = suggestion.substring(query.length);

          return ListTile(
            onTap: () {
              query = suggestion;

              // 1 option - show results
              //
              showResults(context);

              // 2 option - close search & return result
              //
              // close(context, suggestion);

              // 3 option
              //
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (BuildContext context) => ResultPage(suggestion),
              //   ),
              // );
            },
            leading: const Icon(Icons.location_city),
            // title: Text(suggestion),
            title: RichText(
              text: TextSpan(
                text: queryText,
                style: const TextStyle(
                  color: Colors.black,
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
