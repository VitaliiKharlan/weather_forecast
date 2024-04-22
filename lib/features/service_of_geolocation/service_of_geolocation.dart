import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_forecast/features/controllers/city/city_controller.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class ServiceOfGeolocation extends StatefulWidget {
  const ServiceOfGeolocation({super.key});

  @override
  State<ServiceOfGeolocation> createState() => _ServiceOfGeolocationState();
}

class _ServiceOfGeolocationState extends State<ServiceOfGeolocation> {
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;

  String _currentAddress = '';
  String _currentCity = '';

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
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Location Coordinate',
              style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white.withOpacity(0.72),
              ),
            ),
            // const SizedBox(height: 20),
            // Text(
            //   '$_currentLocation',
            //   style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
            //     fontSize: 18,
            //     fontWeight: FontWeight.w500,
            //     color: Colors.white.withOpacity(0.72),
            //   ),
            // ),
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
            const SizedBox(height: 80),
            ElevatedButton(
              onPressed: () async {
                _currentLocation = await _getCurrentLocation();
                // print('${_currentLocation!.latitude}');
                // print('${_currentLocation!.longitude}');

                await _getAddressFromCoordinates();
                // print(_currentAddress);

                // print('test here');
              },
              child: const Text('get Location'),
            ),
          ],
        ),
      ),
    );
  }
}
