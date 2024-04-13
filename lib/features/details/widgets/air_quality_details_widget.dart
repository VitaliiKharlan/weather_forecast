import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'air_quality_components_widget.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_style.dart';
import '../../../repositories/weather_details/models/air_pollution_details.dart';

class AirQualityDetailsWidget extends StatefulWidget {
  final AirPollutionDetails? airPollutionDetails;

  const AirQualityDetailsWidget({
    super.key,
    required this.airPollutionDetails,
  });

  @override
  State<AirQualityDetailsWidget> createState() =>
      _AirQualityDetailsWidgetState();
}

class _AirQualityDetailsWidgetState extends State<AirQualityDetailsWidget> {
  // List<AirPollutionDetails>? airPollutionDetails;
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   final airPollutionDetailsController = AirPollutionController();
  //   airPollutionDetailsController.init();
  //   airPollutionDetailsController.addListener(() {
  //     setState(() {
  //       airPollutionDetails = airPollutionDetailsController.airPollutionDetails;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final modelAirPollutionDetails = widget.airPollutionDetails;

    final airQualityIndex =
        modelAirPollutionDetails?.list.first.main.aqi.toString();

    final style = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      foregroundColor: MaterialStateProperty.all(Colors.black),
      overlayColor: MaterialStateProperty.all(Colors.green),
      shadowColor: MaterialStateProperty.all(Colors.blue),
      // elevation: MaterialStateProperty.all(100),
      padding: MaterialStateProperty.all(const EdgeInsets.all(4)),
      minimumSize: MaterialStateProperty.all(const Size(20, 20)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: const BorderSide(color: Colors.deepPurple),
        ),
      ),
      // alignment: Alignment.topLeft,
      // visualDensity: VisualDensity(horizontal: 3, vertical: 3),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        height: 164,
        width: 348,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.linearWhiteHourlyButtonShort12.withOpacity(0.2),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(4, 2),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Stack(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const SizedBox(height: 12),
                      Positioned(
                        // left: 12,
                        top: 12,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/air_quality.svg',
                              height: 24,
                              width: 24,
                              colorFilter: ColorFilter.mode(
                                  Colors.white.withOpacity(0.4),
                                  BlendMode.srcIn),
                            ),
                            Text(
                              '  AIR QUALITY',
                              style: AppTextStyle.defaultTextDarkSemiBold
                                  .copyWith(
                                      color: Colors.white.withOpacity(0.4)),
                            ),
                          ],
                        ),
                      ),
                      // const SizedBox(height: 20),
                      Positioned(
                        // left: 12,
                        top: 48,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$airQualityIndex',
                              style: AppTextStyle.defaultTextDarkBold.copyWith(
                                fontSize: 28,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              ' - ',
                              style: AppTextStyle.defaultTextDarkBold.copyWith(
                                fontSize: 28,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            (airQualityIndex == '1')
                                ? Text(
                                    'Good',
                                    style: AppTextStyle.defaultTextDarkBold
                                        .copyWith(
                                      fontSize: 28,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : (airQualityIndex == '2')
                                    ? Text(
                                        'Fair',
                                        style: AppTextStyle.defaultTextDarkBold
                                            .copyWith(
                                          fontSize: 28,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : (airQualityIndex == '3')
                                        ? Text(
                                            'Moderate',
                                            style: AppTextStyle
                                                .defaultTextDarkBold
                                                .copyWith(
                                              fontSize: 24,
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : (airQualityIndex == '4')
                                            ? Text(
                                                'Poor',
                                                style: AppTextStyle
                                                    .defaultTextDarkBold
                                                    .copyWith(
                                                  fontSize: 28,
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            : Text(
                                                'Very Poor',
                                                style: AppTextStyle
                                                    .defaultTextDarkBold
                                                    .copyWith(
                                                  fontSize: 28,
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                          ],
                        ),
                      ),
                      // const SizedBox(height: 40),
                      Positioned(
                        // left: 12,
                        bottom: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'See more',
                              style:
                                  AppTextStyle.defaultTextDarkSemiBold.copyWith(
                                fontSize: 18,
                                color: Colors.white.withOpacity(0.72),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(width: 192),
                            ElevatedButton(
                              style: style,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AirQualityComponentsWidget(
                                      airPollutionDetails:
                                          widget.airPollutionDetails,
                                    ),
                                  ),
                                );
                              },
                              child: const Icon(Icons.chevron_right),
                            ),
                            // Icon(Icons.add),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // const SizedBox(width: 4),
            ],
          ),
        ),
      ),
    );
  }
}
