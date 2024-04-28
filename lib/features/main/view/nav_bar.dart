import 'package:flutter/material.dart';

import '../../favorite_cities/view/favorite_cities_screen.dart';
import '../../service_of_geolocation/service_of_geolocation.dart';
import '../../theme/app.images.dart';
import '../../../repositories/weather_details/models/air_pollution_details.dart';
import '../../../repositories/weather_details/models/city_coordinate.dart';
import '../../../repositories/weather_details/models/weather_forecast_details.dart';
import '../../../repositories/weather_details/models/weather_forecast_hourly_details.dart';

class NavBar extends StatelessWidget {
  final List<CityCoordinate>? cityCoordinates;
  final List<WeatherForecastDetails>? weatherForecastDetails;
  final List<WeatherForecastHourlyDetails>? weatherForecastHourlyDetails;
  final List<AirPollutionDetails>? airPollutionDetails;

  final int pageIndex;
  final Function(int) onTap;

  const NavBar({
    super.key,
    required this.cityCoordinates,
    required this.weatherForecastDetails,
    required this.weatherForecastHourlyDetails,
    required this.airPollutionDetails,
    required this.pageIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Image.asset(
            AppImages.backgroundMainImage,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Image.asset(AppImages.bottomNavigationBarRectangle),
        ),
        Positioned(
          left: 64,
          bottom: 0,
          child: Image.asset(AppImages.bottomNavigationBarSubtract),
        ),
        SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 32,
              top: 32,
              right: 32,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                navItem(
                  const AssetImage(
                      'assets/icons/bottom_navigation_bar_map_icon.png'),
                  pageIndex == 0,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ServiceOfGeolocation(),
                      ),
                    );
                  },
                ),
                navItem(
                  const AssetImage(
                    'assets/icons/bottom_navigation_bar_list_icon.png',
                  ),
                  pageIndex == 1,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoriteCitiesWidget(
                          cityCoordinates: cityCoordinates,
                          weatherForecastDetails: weatherForecastDetails,
                          weatherForecastHourlyDetails:
                              weatherForecastHourlyDetails,
                          airPollutionDetails: airPollutionDetails,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget navItem(AssetImage image, bool selected, {Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Image(
      image: image,
      color: selected ? Colors.white : Colors.white24,
    ),
  );
}

class TabPage extends StatelessWidget {
  final int tab;

  const TabPage({
    super.key,
    required this.tab,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tab $tab')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tab $tab'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Page(tab: tab),
                  ),
                );
              },
              child: const Text('Go to page'),
            ),
          ],
        ),
      ),
    );
  }
}

class Page extends StatelessWidget {
  final int tab;

  const Page({
    super.key,
    required this.tab,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Tab $tab')),
      body: Center(child: Text('Tab $tab')),
    );
  }
}
