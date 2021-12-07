
import 'package:flutter_canastas/domain/entities/current_time_entity.dart';
import 'package:flutter_canastas/domain/repositories/current_time_repository.dart';


class GetCurrentTimeWorldUseCase{
  final CurrentTimeRepository _currentTimeRepository;

  GetCurrentTimeWorldUseCase(this._currentTimeRepository);

  Future<CurrentTimeEntity> execute() async{
    return await _currentTimeRepository.get();
  }
  
}