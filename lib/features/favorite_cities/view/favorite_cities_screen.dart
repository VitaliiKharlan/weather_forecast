import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../controllers/city/city_controller.dart';
import '../../details/view/details_screen.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_style.dart';
import '../../../repositories/weather_details/models/air_pollution_details.dart';
import '../../../repositories/weather_details/models/city_coordinate.dart';
import '../../../repositories/weather_details/models/weather_forecast_hourly_details.dart';
import '../../../../repositories/weather_details/models/weather_forecast_details.dart';

class FavoriteCitiesWidget extends StatefulWidget {
  final List<CityCoordinate>? cityCoordinates;
  final List<WeatherForecastDetails>? weatherForecastDetails;
  final List<WeatherForecastHourlyDetails>? weatherForecastHourlyDetails;
  final List<AirPollutionDetails>? airPollutionDetails;

  const FavoriteCitiesWidget({
    super.key,
    required this.cityCoordinates,
    required this.weatherForecastDetails,
    required this.weatherForecastHourlyDetails,
    required this.airPollutionDetails,
  });

  @override
  State<FavoriteCitiesWidget> createState() => _FavoriteCitiesWidgetState();
}

class _FavoriteCitiesWidgetState extends State<FavoriteCitiesWidget> {
  // List<CityCoordinate>? cities = [];
  // List<WeatherForecastDetails>? weatherForecastDetails;

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
                'My Favorite',
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
                'Cities',
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
      body: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          top: 40,
          right: 12,
        ),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.cityCoordinates?.length,
          itemExtent: 104,
          itemBuilder: (BuildContext context, int index) {
            return _FavoriteCitiesItemWidget(
              cityCoordinates: widget.cityCoordinates![index],
              weatherForecastDetails: widget.weatherForecastDetails![index],
              weatherForecastHourlyDetails:
                  widget.weatherForecastHourlyDetails![index],
              airPollutionDetails: widget.airPollutionDetails![index],
              // index: ,
            );
          },
        ),
      ),
    );
  }
}

class _FavoriteCitiesItemWidget extends StatelessWidget {
  final CityCoordinate cityCoordinates;
  final WeatherForecastDetails weatherForecastDetails;
  final WeatherForecastHourlyDetails weatherForecastHourlyDetails;
  final AirPollutionDetails airPollutionDetails;

  // final String index;

  const _FavoriteCitiesItemWidget({
    required this.cityCoordinates,
    required this.weatherForecastDetails,
    required this.weatherForecastHourlyDetails,
    required this.airPollutionDetails,

    // required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final modelWeatherForecastDetails = weatherForecastDetails;

    final city = modelWeatherForecastDetails.name.toString();
    final description =
        modelWeatherForecastDetails.weather.first.description.toString();
    final descriptionFirstUp = toBeginningOfSentenceCase(description);

    var now = DateTime.now().toUtc();

    var formatterTime = DateFormat('kk:mm');

    String actualTime = formatterTime.format(now);

    final currentTemp = modelWeatherForecastDetails.main.temp;
    final currentTempRound = currentTemp.toStringAsFixed(0).toString();

    final tempMax = modelWeatherForecastDetails.main.tempMax;
    final tempMaxRound = tempMax.toStringAsFixed(0).toString();

    final tempMin = modelWeatherForecastDetails.main.tempMin;
    final tempMinRound = tempMin.toStringAsFixed(0).toString();

    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        right: 8,
        bottom: 8,
        // top: 8,
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
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    cityCoordinate: cityCoordinates,
                    weatherForecastDetails: weatherForecastDetails,
                    airPollutionDetails: airPollutionDetails,
                    weatherForecastHourlyDetails: weatherForecastHourlyDetails,
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
              clipBehavior: Clip.hardEdge,
              child: Slidable(
                endActionPane: ActionPane(
                  extentRatio: 0.32,
                  motion: const BehindMotion(),
                  children: [
                    SlidableAction(
                      spacing: 32,
                      flex: 1,
                      borderRadius: BorderRadius.circular(24),
                      onPressed: (_) {
                        cityController.deleteFavoriteCity(city);
                        // cityController.deleteFavoriteCities();
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    top: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              city,
                              style: AppTextStyle.defaultTextDarkRegular
                                  .copyWith(color: Colors.white, fontSize: 20),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              actualTime,
                              style: AppTextStyle.defaultTextDarkRegular
                                  .copyWith(color: Colors.white, fontSize: 14),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              '$descriptionFirstUp',
                              style: AppTextStyle.defaultTextDarkRegular
                                  .copyWith(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              '$currentTempRound\u00B0',
                              style: AppTextStyle.defaultTextDarkRegular
                                  .copyWith(color: Colors.white, fontSize: 40),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'H: $tempMaxRound\u00B0  L: $tempMinRound\u00B0',
                              style: AppTextStyle.defaultTextDarkRegular
                                  .copyWith(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
