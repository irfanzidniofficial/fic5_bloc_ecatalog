import 'package:dartz/dartz.dart';
import 'package:fic5_bloc_ecatalog/model/request/register_request_model.dart';
import 'package:fic5_bloc_ecatalog/model/response/register_response_model.dart';
import 'package:http/http.dart' as http;

class AuthDatasource {
  Future<Either<String, RegisterResponseModel>> register(
      RegisterRequestModel model) async {
    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/users/'),
      body: model.toJson(),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 201) {
      return Right(RegisterResponseModel.fromJson(response.body));
    } else {
      return Left("Register Gagal");
    }
  }
}