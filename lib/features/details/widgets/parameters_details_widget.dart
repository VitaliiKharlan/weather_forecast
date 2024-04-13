import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_style.dart';
import '../../../repositories/weather_details/models/weather_forecast_details.dart';

class ParametersDetailsWidget extends StatelessWidget {
  final WeatherForecastDetails? weatherForecastDetails;

  const ParametersDetailsWidget({
    super.key,
    required this.weatherForecastDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _UVIndexWidget(weatherForecastDetails: weatherForecastDetails),
              _SunriseWidget(weatherForecastDetails: weatherForecastDetails),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _WindWidget(),
              _RainfallWidget(),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _FeelsLikeWidget(),
              _HumidityWidget(),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _VisibilityWidget(),
              _PressureWidget(),
            ],
          ),
        ),
        const SizedBox(height: 12),

      ],
    );
  }
}

class _UVIndexWidget extends StatelessWidget {
  final WeatherForecastDetails? weatherForecastDetails;

  const _UVIndexWidget({
    required this.weatherForecastDetails,
  });

  @override
  Widget build(BuildContext context) {
    final modelWeatherForecastDetails = weatherForecastDetails;

    final timeFormatter = DateFormat('jm');

    final offset = modelWeatherForecastDetails?.timezone ?? 0;

    final sunriseTime = modelWeatherForecastDetails?.sys.sunrise ?? 0;
    final sunriseTimeToMilliseconds = (sunriseTime + offset) * 1000;
    DateTime dateTimeSunriseTime =
        DateTime.fromMillisecondsSinceEpoch(sunriseTimeToMilliseconds);
    final outputSunriseTime = timeFormatter.format(dateTimeSunriseTime);

    final sunsetTime = modelWeatherForecastDetails?.sys.sunset ?? 0;
    final sunsetTimeToMilliseconds = (sunsetTime + offset) * 1000;
    DateTime dateTimeSunsetTime =
        DateTime.fromMillisecondsSinceEpoch(sunsetTimeToMilliseconds);
    final outputSunsetTime = timeFormatter.format(dateTimeSunsetTime);
    return SizedBox(
      height: 164,
      width: 164,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.linearWhiteHourlyButtonShort12.withOpacity(0.2),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(4, 2),
                ),
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/uv_index.svg',
                              height: 24,
                              width: 24,
                              colorFilter: ColorFilter.mode(
                                  Colors.white.withOpacity(0.4),
                                  BlendMode.srcIn),
                            ),
                            Text(
                              '  UV INDEX',
                              style: AppTextStyle.defaultTextDarkSemiBold
                                  .copyWith(
                                      color: Colors.white.withOpacity(0.4)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '4',
                          style: AppTextStyle.defaultTextDarkBold.copyWith(
                            fontSize: 28,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Moderate',
                          style: AppTextStyle.defaultTextDarkBold.copyWith(
                            fontSize: 20,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 4),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => modelWeatherForecastDetails?.id,
            ),
          ),
        ],
      ),
    );
  }
}

class _SunriseWidget extends StatelessWidget {
  final WeatherForecastDetails? weatherForecastDetails;

  const _SunriseWidget({
    required this.weatherForecastDetails,
  });

  @override
  Widget build(BuildContext context) {
    final modelWeatherForecastDetails = weatherForecastDetails;

    final timeFormatter = DateFormat('jm');

    final offset = modelWeatherForecastDetails?.timezone ?? 0;

    final sunriseTime = modelWeatherForecastDetails?.sys.sunrise ?? 0;
    final sunriseTimeToMilliseconds = (sunriseTime + offset) * 1000;
    DateTime dateTimeSunriseTime =
        DateTime.fromMillisecondsSinceEpoch(sunriseTimeToMilliseconds);
    final outputSunriseTime = timeFormatter.format(dateTimeSunriseTime);

    final sunsetTime = modelWeatherForecastDetails?.sys.sunset ?? 0;
    final sunsetTimeToMilliseconds = (sunsetTime + offset) * 1000;
    DateTime dateTimeSunsetTime =
        DateTime.fromMillisecondsSinceEpoch(sunsetTimeToMilliseconds);
    final outputSunsetTime = timeFormatter.format(dateTimeSunsetTime);
    return SizedBox(
      height: 164,
      width: 164,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.linearWhiteHourlyButtonShort12.withOpacity(0.2),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(4, 2),
                ),
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/sunrise.svg',
                              height: 24,
                              width: 24,
                              colorFilter: ColorFilter.mode(
                                  Colors.white.withOpacity(0.4),
                                  BlendMode.srcIn),
                            ),
                            Text(
                              '  SUNRISE',
                              style: AppTextStyle.defaultTextDarkSemiBold
                                  .copyWith(
                                      color: Colors.white.withOpacity(0.4)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          outputSunriseTime,
                          style: AppTextStyle.defaultTextDarkBold.copyWith(
                            fontSize: 28,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 48),
                        Row(
                          children: [
                            Text(
                              'Sunset:  ',
                              style: AppTextStyle.defaultTextDarkSemiBold
                                  .copyWith(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.4)),
                            ),
                            Text(
                              outputSunsetTime,
                              style: AppTextStyle.defaultTextDarkBold.copyWith(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 4),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => modelWeatherForecastDetails?.id,
            ),
          ),
        ],
      ),
    );
  }
}

class _WindWidget extends StatelessWidget {
  const _WindWidget();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/wind_bottom_widget_details_screen.png',
      height: 164,
      width: 164,
      fit: BoxFit.cover,
    );
  }
}

class _RainfallWidget extends StatelessWidget {
  const _RainfallWidget();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/rainfall_bottom_widget_details_screen.png',
      height: 164,
      width: 164,
      fit: BoxFit.cover,
    );
  }
}

class _FeelsLikeWidget extends StatelessWidget {
  const _FeelsLikeWidget();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/feels_like_bottom_widget_details_screen.png',
      height: 164,
      width: 164,
      fit: BoxFit.cover,
    );
  }
}

class _HumidityWidget extends StatelessWidget {
  const _HumidityWidget();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/humidity_bottom_widget_details_screen.png',
      height: 164,
      width: 164,
      fit: BoxFit.cover,
    );
  }
}

class _VisibilityWidget extends StatelessWidget {
  const _VisibilityWidget();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/visibility_bottom_widget_details_screen.png',
      height: 164,
      width: 164,
      fit: BoxFit.cover,
    );
  }
}

class _PressureWidget extends StatelessWidget {
  const _PressureWidget();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/pressure_bottom_widget_details_screen.png',
      height: 164,
      width: 164,
      fit: BoxFit.cover,
    );
  }
}



