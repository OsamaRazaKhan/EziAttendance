import 'package:attendence_management_sys/data/network/BaseApiServices.dart';
import 'package:attendence_management_sys/data/network/NetworkApiServices.dart';
import 'package:attendence_management_sys/resources/app_url.dart';

class AttendenceRepository {
  BasedApiServices _apiServices = NetworkApiService();

  Future<dynamic> GetAllAttendsApi() async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponnse(AppUrl.getallattendsApiEndPoint);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> GetSingleAttendsApi() async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponnse(AppUrl.getsingleattendApiEndPoint);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> GetReportApi() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponnse(AppUrl.getreportApiEndPoint);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> GetDeleteAttendApi() async {
    try {
      dynamic response = await _apiServices
          .getDeleteApiResponse(AppUrl.deleteAttendenceApiEndPoint);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> GetPostAttendenceApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.postAttendenceApiEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> GetPutAttendenceApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPutApiResponse(
          AppUrl.putAttendenceApiEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
