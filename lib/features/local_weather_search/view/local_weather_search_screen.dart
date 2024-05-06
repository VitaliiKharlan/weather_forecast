import 'package:flutter/material.dart';
import 'package:weather_forecast/features/controllers/city/city_controller.dart';
import 'package:weather_forecast/features/theme/app_text_style.dart';
import 'package:weather_forecast/repositories/city_search_result/city_search_result_repository.dart';
import 'package:weather_forecast/repositories/city_search_result/models/city_search_result.dart';

class LocalWeatherSearch extends StatelessWidget {
  LocalWeatherSearch({
    super.key,
  });

  CitySearchResult? citySearchResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E335A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E335A),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Column(
          children: [
            Text(
              'Search',
              style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
                color: Colors.white.withOpacity(0.72),
                fontSize: 20,
                height: 1.2,
              ),
              maxLines: 2,
            ),
            Text(
              'City or Airport',
              style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
                color: Colors.white.withOpacity(0.72),
                fontSize: 20,
                height: 1.2,
              ),
              maxLines: 2,
            ),
          ],
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
              // 'Search',
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
  CitySearch({
    super.searchFieldLabel,
    super.searchFieldStyle,
    super.searchFieldDecorationTheme,
    super.keyboardType,
    super.textInputAction,
  });

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
    return FutureBuilder<List<CitySearchResult>>(
      future: CitySearchResultRepository.getCitySearchResult(query: query),
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
      child: FutureBuilder<List<CitySearchResult>>(
        future: CitySearchResultRepository.getCitySearchResult(query: query),
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

  Widget buildSuggestionsSuccess(List<CitySearchResult> suggestions) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          onTap: () {
            showResults(context);
            cityController.addNewCity(suggestion.name);
          },
          leading: const Icon(
            Icons.location_city,
            color: Colors.white,
          ),
          title: RichText(
            text: TextSpan(
              text: suggestion.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: [
                TextSpan(
                  text: suggestion.lat.toString(),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
                TextSpan(
                  text: suggestion.lon.toString(),
                  style: const TextStyle(
                    color: Colors.grey,
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

  Widget buildResultSuccess(List<CitySearchResult> citySearchResult) {
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
            query,
            style: const TextStyle(
              fontSize: 32,
              color: Colors.white,
              height: 2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
