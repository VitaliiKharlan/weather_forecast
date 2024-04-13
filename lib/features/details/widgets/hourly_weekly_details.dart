import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme/app.images.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_style.dart';
import '../../../repositories/weather_details/models/weather_forecast_details.dart';
import '../../../repositories/weather_details/models/weather_forecast_hourly_details.dart';

class HourlyWeeklyDetailsWidget extends StatelessWidget {
  final WeatherForecastDetails? weatherForecastDetails;
  final WeatherForecastHourlyDetails? weatherForecastHourlyDetails;

  const HourlyWeeklyDetailsWidget({
    super.key,
    required this.weatherForecastDetails,
    required this.weatherForecastHourlyDetails,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/separator_details_screen.png',
            width: 540.0,
            height: 4.0,
          ),
          Image.asset(
            'assets/images/shape_details_screen.png',
            width: 540.0,
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  'Hourly Forecast',
                  style: AppTextStyle.labelColorDarkSecondary
                      .copyWith(color: Colors.white54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Text(
                  'Weekly Forecast',
                  style: AppTextStyle.labelColorDarkSecondary
                      .copyWith(color: Colors.white54),
                ),
              ),
            ],
          ),
          _HourlyForecastWidget(
            weatherForecastDetails: weatherForecastDetails,
            weatherForecastHourlyDetails: weatherForecastHourlyDetails,
          ),
        ],
      ),
    );
  }
}

class _HourlyForecastWidget extends StatelessWidget {
  final WeatherForecastDetails? weatherForecastDetails;
  final WeatherForecastHourlyDetails? weatherForecastHourlyDetails;

  const _HourlyForecastWidget({
    required this.weatherForecastDetails,
    required this.weatherForecastHourlyDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 24,
          itemExtent: 72,
          itemBuilder: (BuildContext context, int index) {
            return _HourlyForecastItemWidget(
              weatherForecastDetails: weatherForecastDetails,
              weatherForecastHourlyDetails: weatherForecastHourlyDetails,
              timeIndex: index,
            );
          },
        ),
      ),
    );
  }
}

class _HourlyForecastItemWidget extends StatelessWidget {
  final WeatherForecastDetails? weatherForecastDetails;
  final WeatherForecastHourlyDetails? weatherForecastHourlyDetails;
  final int timeIndex;

  const _HourlyForecastItemWidget({
    required this.weatherForecastDetails,
    required this.weatherForecastHourlyDetails,
    required this.timeIndex,
  });

  @override
  Widget build(BuildContext context) {
    final modelWeatherForecastHourlyDetails = weatherForecastHourlyDetails;
    final hourTimeFormatter = DateFormat('j');
    final dateTimeFormatter = DateFormat('dd.MM');
    final offset = modelWeatherForecastHourlyDetails?.city.timezone ?? 0;
    final timeItem = modelWeatherForecastHourlyDetails?.list[timeIndex].dt ?? 0;
    final timeItemToMilliseconds = (timeItem + offset) * 1000;
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeItemToMilliseconds);
    final outputDateItem = dateTimeFormatter.format(time).toString();
    final outputTimeItem = hourTimeFormatter.format(time).toString();

    final clouds = modelWeatherForecastHourlyDetails?.list[timeIndex].clouds.all
        .toString();

    final temp = modelWeatherForecastHourlyDetails?.list[timeIndex].main.temp;
    final tempRound = temp?.toStringAsFixed(0).toString();

    final weatherIcon = modelWeatherForecastHourlyDetails
        ?.list[timeIndex].weather.first.icon
        .toString();

    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        top: 8,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.solidDarkHourlyButtonShort1.withOpacity(0.2),
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(4, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              const SizedBox(height: 16),
              Text(
                outputDateItem,
                style: AppTextStyle.defaultTextDarkRegular
                    .copyWith(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 12),
              Text(
                outputTimeItem,
                style: AppTextStyle.defaultTextDarkRegular
                    .copyWith(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 20),
              (weatherIcon == '01n')
                  ? const Image(
                      image: AssetImage(AppImages.smallIconSunCloudMidRain),
                    )
                  : (weatherIcon == '02n')
                      ? const Image(
                          image:
                              AssetImage(AppImages.smallIconMoonCloudFastWind),
                        )
                      : (weatherIcon == '03n')
                          ? const Image(
                              image: AssetImage(
                                  AppImages.smallIconSunCloudAngledRain),
                            )
                          : (weatherIcon == '03n')
                              ? const Image(
                                  image: AssetImage(
                                      AppImages.smallIconMoonCloudMidRain),
                                )
                              : const Image(
                                  image: AssetImage(
                                      AppImages.smallIconSunCloudAngledRain),
                                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        '$clouds%',
                        style: AppTextStyle.defaultTextDarkRegular
                            .copyWith(color: Colors.white),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        '$tempRound\u00B0',
                        style: AppTextStyle.defaultTextDarkRegular
                            .copyWith(color: Colors.white),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
