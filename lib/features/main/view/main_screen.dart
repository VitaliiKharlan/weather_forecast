import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;


import '../../../repositories/weather_details.dart';
import '../../theme/app_colors.dart';
import '../../../repositories/city_search_result/models/city_search_result.dart';

import '../../details/view/details_screen.dart';
import '../../local_weather_search/view/local_weather_search_screen.dart';

import 'nav_bar_model.dart';
import 'nav_bar.dart';

import '../../constants/cities_names.dart';
import '../../constants/lat_lon.dart';

import '../../controllers/air_pollution/air_pollution_controller.dart';
import '../../controllers/city/city_controller.dart';
import '../../controllers/coord/coord_controller.dart';
import '../../controllers/hourly_forecast/hourly_forecast_controller.dart';

import '../../../repositories/weather_details/models/air_pollution_details.dart';
import '../../../repositories/weather_details/models/weather_forecast_hourly_details.dart';
import '../../../repositories/weather_details/models/city_coordinate.dart';
import '../../../repositories/weather_details/models/weather_forecast_details.dart';

import '../../theme/app.images.dart';
import '../../theme/app_text_style.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final homeNavKey = GlobalKey<NavigatorState>();
  final searchNavKey = GlobalKey<NavigatorState>();
  final notificationNavKey = GlobalKey<NavigatorState>();
  final profileNavKey = GlobalKey<NavigatorState>();
  int _selectedTab = 0;
  List<NavBarModel> items = [];

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  List<WeatherDetails> listOfWeatherDetails = [];
  List<CityCoordinate> cities = [];
  List<WeatherForecastDetails> weatherForecastDetails = [];
  List<AirPollutionDetails> airPollutionDetails = [];
  List<WeatherForecastHourlyDetails> weatherForecastHourlyDetails = [];
  CitySearchResult? citySearchResul;

  @override
  void initState() {
    super.initState();
    cityController.addNewCities(
      [
        CitiesNames.first,
        CitiesNames.second,
        CitiesNames.third,
        CitiesNames.fourth,
      ],
    );

    cityController.fetchListOfCities();
    cityController.addListener(() {
      setState(() {
        cities = cityController.cities;

        final hourlyWeatherForecastController = HourlyForecastController(
          cities: cityController.cities
              .map((e) => LatLon(lat: e.lat, lon: e.lon))
              .toList(),
        );

        hourlyWeatherForecastController.init();
        hourlyWeatherForecastController.addListener(() {
          setState(() {
            weatherForecastHourlyDetails =
                hourlyWeatherForecastController.weatherForecastHourlyDetails;
          });
        });

        final detailsController = CoordController(
          cities: cityController.cities
              .map((e) => LatLon(lat: e.lat, lon: e.lon))
              .toList(),
        );
        detailsController.init();
        detailsController.addListener(() {
          setState(() {
            weatherForecastDetails = detailsController.details;
          });
        });

        final airPollutionDetailsController = AirPollutionController(
          cities: cityController.cities
              .map((e) => LatLon(lat: e.lat, lon: e.lon))
              .toList(),
        );
        airPollutionDetailsController.init();
        airPollutionDetailsController.addListener(() {
          setState(() {
            airPollutionDetails =
                airPollutionDetailsController.airPollutionDetails;
          });
        });
      });
      Future.delayed(const Duration(seconds: 2)).then((value) => fillData());
    });

    items = [
      NavBarModel(
        page: const TabPage(tab: 1),
        navKey: homeNavKey,
      ),
      NavBarModel(
        page: const TabPage(tab: 2),
        navKey: searchNavKey,
      ),
    ];
  }

  void fillData() {
    listOfWeatherDetails.clear();
    for (int i = 0; i < (cities.length); i++) {
      listOfWeatherDetails.add(WeatherDetails(
          addedAt: DateTime.now(),
          cityCoordinates: cities[i],
          weatherForecastDetails: weatherForecastDetails[i],
          weatherForecastHourlyDetails: weatherForecastHourlyDetails[i],
          airPollutionDetails: airPollutionDetails[i]));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (weatherForecastDetails != null) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: const EdgeInsets.only(top: 88),
          height: 80,
          width: 80,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocalWeatherSearch(),
                ),
              );
            },
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 4,
                color: Color(0xFF5B5F78),
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.add,
              color: Color(0xFF48319D),
            ),
          ),
        ),
        bottomNavigationBar: NavBar(
          listOfWeatherDetails: listOfWeatherDetails,
          pageIndex: _selectedTab,
          onTap: (index) {
            if (index == _selectedTab) {
              items[index]
                  .navKey
                  .currentState
                  ?.popUntil((route) => route.isFirst);
            } else {
              setState(() {
                _selectedTab = index;
              });
            }
          },
        ),
        backgroundColor: AppColors.solidDarkBackgroundMainScreen,
        body: PageBuilderWidget(
          weatherList: listOfWeatherDetails,
        ),
      );
    }
    return const ColoredBox(
      color: AppColors.solidDarkBackgroundMainScreen,
      child: Center(
        child: SizedBox(
          height: 80,
          width: 80,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class PageBuilderWidget extends StatefulWidget {
  const PageBuilderWidget({
    super.key,
    required this.weatherList,
  });

  final List<WeatherDetails> weatherList;

  @override
  State<PageBuilderWidget> createState() => _PageBuilderWidgetState();
}

class _PageBuilderWidgetState extends State<PageBuilderWidget> {
  final PageController _pageController = PageController(initialPage: 0);
  int _activePage = 0;
  final List<Widget> _pages = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _activePage = page;
            });
          },
          itemCount: widget.weatherList.length,
          itemBuilder: (context, index) {
            return _CityPage(weatherDetails: widget.weatherList[index]);
          },
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
              widget.weatherList.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: InkWell(
                  onTap: () {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor:
                        _activePage == index ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Image.asset(
        AppImages.backgroundMainImage,
        fit: BoxFit.fill,
      ),
    );
  }
}

class HouseWidget extends StatelessWidget {
  const HouseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 54,
      bottom: 184,
      height: 280,
      child: Image.asset(
        AppImages.backgroundHouseImage,
        fit: BoxFit.fill,
      ),
    );
  }
}

class DetailsInfoWidget extends StatelessWidget {
  const DetailsInfoWidget({
    super.key,
    required this.weatherDetails,
  });

  final WeatherDetails weatherDetails;

  @override
  Widget build(BuildContext context) {
    // if (weatherForecastDetails != null) {
    final modelWeatherForecastDetails = weatherDetails.weatherForecastDetails;
    final currentTemp = modelWeatherForecastDetails.main.temp;
    final currentTempRound = currentTemp.toStringAsFixed(0).toString();

    final description =
        modelWeatherForecastDetails.weather.first.description.toString();
    final descriptionFirstUp = toBeginningOfSentenceCase(description);

    final tempMax = modelWeatherForecastDetails.main.tempMax;
    final tempMaxRound = tempMax.toStringAsFixed(0).toString();

    final tempMin = modelWeatherForecastDetails.main.tempMin;
    final tempMinRound = tempMin.toStringAsFixed(0).toString();

    final modelCityCoordinate = weatherDetails.cityCoordinates;
    final cityName = modelCityCoordinate.name.toString();
    final countryName = modelCityCoordinate.country.toString().toUpperCase();

    // final modelAirPollutionDetails = weatherDetails.airPollutionDetails;
    // final concentrationOfCO =
    //     modelAirPollutionDetails.list.first.components.co.toString();

    // final modelWeatherForecastHourlyDetails =
    //     weatherDetails.weatherForecastHourlyDetails;
    // final seaLevel =
    //     modelWeatherForecastHourlyDetails.list.first.main.seaLevel.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 72),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(
                  weatherDetails: weatherDetails,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          child: Text(
            '$cityName, $countryName',
            style: AppTextStyle.defaultRegularLargeTitle
                .copyWith(color: Colors.white),
          ),
        ),
        Text(
          '$currentTempRound\u00B0',
          style:
              AppTextStyle.defaultThinLargeTitle.copyWith(color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '$descriptionFirstUp',
                style: AppTextStyle.defaultSemiBoldLargeTitle
                    .copyWith(color: Colors.white24),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                // '$latCoord',
                'H: $tempMaxRound\u00B0',
                style: AppTextStyle.defaultSemiBoldLargeTitle
                    .copyWith(color: Colors.white),
              ),
              Text(
                'L: $tempMinRound\u00B0',
                style: AppTextStyle.defaultSemiBoldLargeTitle
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
    // }
    // return const Center(
    //   child: SizedBox(
    //     height: 80,
    //     width: 80,
    //     child: CircularProgressIndicator(),
    //   ),
    // );
  }
}

class _CityPage extends StatelessWidget {
  final WeatherDetails? weatherDetails;

  const _CityPage({
    required this.weatherDetails,
  });

  @override
  Widget build(BuildContext context) {
    return (weatherDetails == null)
        ? const Center(child: CircularProgressIndicator())
        : Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.hardEdge,
            children: [
              const BackgroundWidget(),
              const HouseWidget(),
              DetailsInfoWidget(
                weatherDetails: weatherDetails!,
              ),
            ],
          );
  }
}
