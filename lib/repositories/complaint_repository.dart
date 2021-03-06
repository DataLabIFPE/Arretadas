import 'package:arretadas/helpers/custom_dio.dart';
import 'package:arretadas/exceptions/rest_exception.dart';
import 'package:arretadas/models/complaint_model.dart';
import 'package:dio/dio.dart';

class ComplaintRepository {
  Future<List<ComplaintModel>> findAll() async {
    var dio = CustomDio().instance;
    try {
      final response =
          await dio.get('https://arretadas-api.herokuapp.com/complaint');
      return response.data
          .map<ComplaintModel>((m) => ComplaintModel.fromMap(m))
          .toList();
    } on DioError catch (e) {
      print('Erro na requisição');
      print(e);
      throw RestException('Erro ao buscar Denúncias');
    }
  }

  Future<void> sendComplaint(
    dynamic local,
    String data,
    String hora,
    String tipoViolencia,
  ) async {
    var dio = CustomDio().instance;
    try {
      await dio.post('https://arretadas-api.herokuapp.com/complaint', data: {
        'latitude': local.latitude,
        'longitude': local.longitude,
        'date': data,
        'hour': hora,
        'type_complaint': tipoViolencia,
      });
    } on DioError catch (e) {
      print('Erro na requisição');
      print(e);
      throw RestException('Erro ao enviar alerta');
    }
  }
}
