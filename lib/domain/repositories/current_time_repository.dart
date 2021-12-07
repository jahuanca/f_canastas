
import 'package:flutter_canastas/domain/entities/current_time_entity.dart';

abstract class CurrentTimeRepository{
  Future<CurrentTimeEntity> get();
}