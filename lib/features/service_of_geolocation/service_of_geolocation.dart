import 'package:flutter/material.dart';
import 'package:weather_forecast/features/theme/app_colors.dart';
import 'package:weather_forecast/features/theme/app_text_style.dart';

class ServiceOfGeolocation extends StatefulWidget {
  const ServiceOfGeolocation({super.key});

  @override
  State<ServiceOfGeolocation> createState() => _ServiceOfGeolocationState();
}

class _ServiceOfGeolocationState extends State<ServiceOfGeolocation> {
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
            const SizedBox(height: 20),
            Text('Coordinates',
              style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.72),
              ),),
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
            Text('Address',
              style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.72),
              ),),
            const SizedBox(height: 80),
            ElevatedButton(
              onPressed: () {
                print('test here');
              },
              child: const Text('get Location'),
            )
          ],
        ),
      ),
    );
  }
}
