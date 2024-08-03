import 'package:attendence_management_sys/data/network/BaseApiServices.dart';
import 'package:attendence_management_sys/data/network/NetworkApiServices.dart';
import 'package:attendence_management_sys/resources/app_url.dart';

class AuthRepository {
  BasedApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginApi() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponnse(AppUrl.loginEndPoint);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> SignUpApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.registerApiEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
