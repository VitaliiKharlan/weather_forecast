import 'package:dio/dio.dart';
import 'models/air_pollution_details.dart';

const _host = 'http://api.openweathermap.org/data/2.5/air_pollution?';
const _appID = '&appid=';
const _apiKey = '4dbe24134496b55a1b13855ddf7c5847';

class AirPollutionRepository {
  Future<AirPollutionDetails> getAirPollutionDetails(
      double latCoord, double lonCoord) async {
    final response =
        await Dio().get('${_host}lat=$latCoord&lon=$lonCoord&$_appID$_apiKey');

    final data = response.data as Map<String, dynamic>;

    final airPollutionList = AirPollutionDetails.fromJson(data);
    // print(airPollutionList);

    return airPollutionList;
  }
}
