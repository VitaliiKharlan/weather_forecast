import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_style.dart';
import '../../../repositories/weather_details/models/air_pollution_details.dart';

class AirQualityComponentsWidget extends StatelessWidget {
  final AirPollutionDetails? airPollutionDetails;

  const AirQualityComponentsWidget(
      {super.key, required this.airPollutionDetails});

  @override
  Widget build(BuildContext context) {
    final modelAirPollutionModel = airPollutionDetails;

    final co = modelAirPollutionModel?.list.first.components.co.toString();
    final no = modelAirPollutionModel?.list.first.components.no.toString();
    final no2 = modelAirPollutionModel?.list.first.components.no2.toString();
    final o3 = modelAirPollutionModel?.list.first.components.o3.toString();
    final so2 = modelAirPollutionModel?.list.first.components.so2.toString();
    final pm2_5 =
        modelAirPollutionModel?.list.first.components.pm2_5.toString();
    final pm10 = modelAirPollutionModel?.list.first.components.pm10.toString();
    final nh3 = modelAirPollutionModel?.list.first.components.nh3.toString();

    final style = TextStyle(
      color: Colors.white.withOpacity(0.72),
      fontSize: 18,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.ellipsis,
    );

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
          'Components \nof Air Quality',
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
      body: Column(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              bottom: 40,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 220,
                  child: Text(
                    'Сoncentration of CO',
                    style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.72),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 48),
                Expanded(child: Text('$co', style: style)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              bottom: 40,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 220,
                  child: Text(
                    'Сoncentration of NO',
                    style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.72),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 48),
                Expanded(child: Text('$no', style: style)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              bottom: 40,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 220,
                  child: Text(
                    'Сoncentration of NO\u2082',
                    style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.72),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 48),
                Expanded(child: Text('$no2', style: style)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              bottom: 40,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 220,
                  child: Text(
                    'Сoncentration of O\u2083',
                    style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.72),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 48),
                Expanded(child: Text('$o3', style: style)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              bottom: 40,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 220,
                  child: Text(
                    'Сoncentration of SO\u2082',
                    style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.72),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 48),
                Expanded(child: Text('$so2', style: style)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              bottom: 40,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 220,
                  child: Text(
                    'Сoncentration of PM\u2082.\u2085',
                    style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.72),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 48),
                Expanded(child: Text('$pm2_5', style: style)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              bottom: 40,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 220,
                  child: Text(
                    'Сoncentration of PM\u2081\u2080',
                    style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.72),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 48),
                Expanded(child: Text('$pm10', style: style)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              bottom: 40,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 220,
                  child: Text(
                    'Сoncentration of NH\u2083',
                    style: AppTextStyle.defaultTextDarkSemiBold.copyWith(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.72),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 48),
                Expanded(child: Text('$nh3', style: style)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
