import 'package:flutter/material.dart';
import 'package:weather_forecast/features/theme/app_colors.dart';
import 'package:weather_forecast/features/theme/app_text_style.dart';

import '../../../repositories/weather_details/models/weather_forecast_hourly_details.dart';
import '../../../repositories/weather_details/models/air_pollution_details.dart';
import '../../../repositories/weather_details/models/weather_forecast_details.dart';
import '../widgets/air_quality_details_widget.dart';
import '../widgets/hourly_weekly_details.dart';
import '../widgets/main_details_widget.dart';
import '../widgets/parameters_details_widget.dart';

class DetailsScreen extends StatefulWidget {
  final WeatherForecastDetails weatherForecastDetails;
  final AirPollutionDetails airPollutionDetails;
  final WeatherForecastHourlyDetails weatherForecastHourlyDetails;

  const DetailsScreen({
    super.key,
    required this.weatherForecastDetails,
    required this.airPollutionDetails,
    required this.weatherForecastHourlyDetails,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
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
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF2E335A),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Details \n',
          style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
            color: Colors.white.withOpacity(0.72),
            fontSize: 20,
            height: 1.2,
          ),
          maxLines: 2,
        ),
        titleTextStyle: AppTextStyle.defaultSemiBoldLargeTitle
            .copyWith(color: AppColors.solidDarkParametersButtonShort2),
      ),

      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 20),
          MainDetailsWidget(
            weatherForecastDetails: widget.weatherForecastDetails,
          ),
          const SizedBox(height: 24),
          HourlyWeeklyDetailsWidget(
            weatherForecastDetails: widget.weatherForecastDetails,
            weatherForecastHourlyDetails: widget.weatherForecastHourlyDetails,
          ),
          const SizedBox(height: 8),
          AirQualityDetailsWidget(
            airPollutionDetails: widget.airPollutionDetails,
          ),
          const SizedBox(height: 12),
          ParametersDetailsWidget(
            weatherForecastDetails: widget.weatherForecastDetails,
          ),
        ],
      ),
    );
  }
}
