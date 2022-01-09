import 'package:bikolayders/constants/strings.dart';
import 'package:bikolayders/models/register_response_model.dart';
import 'package:bikolayders/models/register_request_model.dart';
import 'package:bikolayders/services/IRegisterService.dart';
import 'package:dio/src/dio.dart';

class RegisterService extends IRegisterService {
  RegisterService(Dio dio) : super(dio);

  @override
  Future<RegisterResponseModel?> postUserRegister(
      RegisterRequestModel registerRequestModel) async {
    dio.options.headers['Accept'] = 'application/json';
    final response =
        await dio.post(StaticStrings.registerPath, data: registerRequestModel);

    if (response.statusCode == 200) {
      return RegisterResponseModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
