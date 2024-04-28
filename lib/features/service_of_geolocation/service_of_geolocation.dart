import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';

import '../controllers/city/city_controller.dart';

import '../main/view/main_screen.dart';

import '../../repositories/weather_details/models/air_pollution_details.dart';
import '../../repositories/weather_details/models/city_coordinate.dart';
import '../../repositories/weather_details/models/weather_forecast_details.dart';
import '../../repositories/weather_details/models/weather_forecast_hourly_details.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class ServiceOfGeolocation extends StatefulWidget {
  const ServiceOfGeolocation({
    super.key,
  });

  @override
  State<ServiceOfGeolocation> createState() => _ServiceOfGeolocationState();
}

class _ServiceOfGeolocationState extends State<ServiceOfGeolocation>
    with SingleTickerProviderStateMixin {
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;
  late AnimationController _controller;

  bool _isLoaded = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50000),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isLoaded = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _currentAddress = '';
  String _currentCity = '';

  CityCoordinate? cityCoordinate;
  WeatherForecastDetails? weatherForecastDetails;
  WeatherForecastHourlyDetails? weatherForecastHourlyDetails;
  AirPollutionDetails? airPollutionDetails;

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, '
          'we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  _getAddressFromCoordinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = '${place.locality}, ${place.country}';
        _currentCity = '${place.locality}';
        cityController.addNewCity(_currentCity);
      });
    } catch (e) {
      // print(e);
    }
  }

  _getLoaded() async {
    setState(() {
      _isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E335A),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
        // automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF2E335A),
        // centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'Get',
                style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
                  color: Colors.white.withOpacity(0.72),
                  fontSize: 20,
                  height: 1.2,
                ),
                maxLines: 2,
              ),
            ),
            Center(
              child: Text(
                'User Location',
                style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
                  color: Colors.white.withOpacity(0.72),
                  fontSize: 20,
                  height: 1.2,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
        titleTextStyle: AppTextStyle.defaultSemiBoldLargeTitle
            .copyWith(color: AppColors.solidDarkParametersButtonShort2),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              'Location Coordinate',
              style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white.withOpacity(0.72),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'latitude = ${_currentLocation?.latitude}',
              style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.72),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'longitude = ${_currentLocation?.longitude}',
              style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.72),
              ),
            ),
            const SizedBox(height: 48),
            Text(
              'Location Address',
              style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white.withOpacity(0.72),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _currentAddress,
              style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.72),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 48,
              width: 200,
              child: ElevatedButton(
                onPressed: () async {
                  if (_currentCity.isEmpty) {
                    _currentLocation = await _getCurrentLocation();
                    await _getAddressFromCoordinates();
                    _getLoaded();
                  } else {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                    );
                  }
                },
                child: _currentCity.isEmpty
                    ? const Text('Add Current City')
                    : const Text('Go to the Main Screen'),
              ),
            ),
            const SizedBox(height: 4),
            Lottie.asset(
              'assets/lottie_animation/hare.json',
              controller: _controller,
              onLoaded: (comp) {
                _controller.duration = comp.duration;
                _controller.forward();
              },
            ),
          ],
        ),
      ),
    );
  }
}
