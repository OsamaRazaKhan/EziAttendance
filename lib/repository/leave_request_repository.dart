import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../resources/app_url.dart';

class LeaveRequestRepository {
  BasedApiServices _apiServices = NetworkApiService();

  Future<dynamic> GetPostLeaveRequestApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.postLeaveRequestApiEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> GetAllLeaveRequestsApi() async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponnse(AppUrl.getLeaveRequestsApiEndPoint);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> GetPutLeaveRequestApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPutApiResponse(
          AppUrl.putLeaveRequestApiEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
