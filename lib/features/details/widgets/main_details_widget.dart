import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../repositories/weather_details/models/weather_forecast_details.dart';
import '../../theme/app_text_style.dart';

class MainDetailsWidget extends StatelessWidget {
  final WeatherForecastDetails? weatherForecastDetails;

  const MainDetailsWidget({
    super.key,
    this.weatherForecastDetails,
  });

  @override
  Widget build(BuildContext context) {
    final modelWeatherForecastDetails = weatherForecastDetails;

    final cityName = modelWeatherForecastDetails?.name.toString();
    final country = modelWeatherForecastDetails?.sys.country.toString();

    final temp = modelWeatherForecastDetails?.main.temp;
    final tempRound = temp?.toStringAsFixed(0).toString();

    final description =
        modelWeatherForecastDetails?.weather.first.description.toString();
    final descriptionFirstUp = toBeginningOfSentenceCase('$description');

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$cityName, $country',
            // 'Montreal',
            style: AppTextStyle.defaultRegularLargeTitle
                .copyWith(color: Colors.white),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$tempRound\u00B0',
                style: AppTextStyle.defaultSemiBoldTitle3
                    .copyWith(color: Colors.white24),
                maxLines: 1,
              ),
              Text(
                ' | ',
                style: AppTextStyle.defaultSemiBoldTitle3
                    .copyWith(color: Colors.white24),
              ),
              Text(
                '$descriptionFirstUp',
                style: AppTextStyle.defaultSemiBoldTitle3
                    .copyWith(color: Colors.white24),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
