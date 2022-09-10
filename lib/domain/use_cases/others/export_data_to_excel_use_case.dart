
import 'package:flutter_actividades/domain/repositories/export_data_repository.dart';

class ExportDataToExcelUseCase{
  final ExportDataRepository _exportDataRepository;

  ExportDataToExcelUseCase(this._exportDataRepository);

  Future<void> execute(dynamic data) async{
    return await _exportDataRepository.exportToExcel(data);
  }
  
}