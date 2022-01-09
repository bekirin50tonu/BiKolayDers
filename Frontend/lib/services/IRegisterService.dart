import 'package:bikolayders/models/register_request_model.dart';
import 'package:bikolayders/models/register_response_model.dart';
import 'package:dio/dio.dart';

abstract class IRegisterService {
  final Dio dio;

  IRegisterService(this.dio);

  Future<RegisterResponseModel?> postUserRegister(
      RegisterRequestModel registerRequestModel);
}
