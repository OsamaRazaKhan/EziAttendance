import 'package:attendence_management_sys/data/network/BaseApiServices.dart';
import 'package:attendence_management_sys/data/network/NetworkApiServices.dart';
import 'package:attendence_management_sys/resources/app_url.dart';

class UserRepository {
  BasedApiServices _apiServices = NetworkApiService();

  Future<dynamic> GetStudentsApi() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponnse(AppUrl.getstudentsEndPoint);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> PutUserApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPutApiResponse(AppUrl.putUserApiEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
