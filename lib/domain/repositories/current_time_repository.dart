
import 'package:flutter_actividades/domain/entities/current_time_entity.dart';

abstract class CurrentTimeRepository{
  Future<CurrentTimeEntity> get();
}