import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:weather_forecast/features/service_of_geolocation/animation_widget.dart';
import '../controllers/city/city_controller.dart';
import '../main/view/main_screen.dart';
import '../../repositories/weather_details/models/city_coordinate.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class ServiceOfGeolocation extends StatefulWidget {
  const ServiceOfGeolocation({
    super.key,
  });

  @override
  State<ServiceOfGeolocation> createState() => _ServiceOfGeolocationState();
}

class _ServiceOfGeolocationState extends State<ServiceOfGeolocation> {
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;

  String _currentAddress = '';
  String _currentCity = '';

  CityCoordinate? cityCoordinate;

  bool isLoading = false;

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, '
          'we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _getAddressFromCoordinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = '${place.locality}, ${place.country}';
        _currentCity = '${place.locality}';
      });
    } catch (e) {
      // print(e);
    }
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
        backgroundColor: const Color(0xFF2E335A),
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
      body: Stack(
        children: [
          Center(
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
                      _loadData();
                    },
                    child: _currentCity.isEmpty
                        ? const Text('Add Current City')
                        : const Text('Go to the Main Screen'),
                  ),
                ),
                const LottieAnimationWidget(),
              ],
            ),
          ),
          if (isLoading)
            const Positioned.fill(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });
    if (_currentCity.isEmpty) {
      _currentLocation = await _getCurrentLocation();
      await _getAddressFromCoordinates();
    } else {
      Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
      cityController.addMyGeoPosition(_currentCity);
    }
    setState(() {
      isLoading = false;
    });
  }
}
