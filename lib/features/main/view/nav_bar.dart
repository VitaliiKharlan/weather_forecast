import 'package:flutter/material.dart';
import 'package:weather_forecast/features/favorite_cities/view/favorite_cities_screen.dart';
import 'package:weather_forecast/features/service_of_geolocation/service_of_geolocation.dart';
import 'package:weather_forecast/features/theme/app.images.dart';
import 'package:weather_forecast/repositories/weather_details/models/city_coordinate.dart';
import 'package:weather_forecast/repositories/weather_details/models/weather_forecast_details.dart';
import 'package:weather_forecast/repositories/weather_details/models/weather_forecast_hourly_details.dart';

class NavBar extends StatelessWidget {
  final List<CityCoordinate>? cityCoordinates;
  final List<WeatherForecastDetails>? weatherForecastDetails;
  final WeatherForecastHourlyDetails? weatherForecastHourlyDetails;
  final int pageIndex;
  final Function(int) onTap;

  const NavBar({
    super.key,
    required this.cityCoordinates,
    required this.weatherForecastDetails,
    required this.weatherForecastHourlyDetails,
    required this.pageIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      // fit: StackFit.loose,
      // clipBehavior: Clip.none,
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
                // FavoriteCitiesWidget
                navItem(
                  const AssetImage(
                      'assets/icons/bottom_navigation_bar_list_icon.png'),
                  pageIndex == 1,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoriteCitiesWidget(
                          cityCoordinates: cityCoordinates,
                          weatherForecastDetails: weatherForecastDetails,
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
