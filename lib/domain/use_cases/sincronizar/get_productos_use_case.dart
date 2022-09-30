
import 'package:flutter_actividades/domain/entities/producto_entity.dart';
import 'package:flutter_actividades/domain/repositories/producto_repository.dart';

class GetProductosUseCase{
  final ProductoRepository _productoRepository;

  GetProductosUseCase(this._productoRepository);

  Future<List<ProductoEntity>> execute() async{
    return await _productoRepository.getAll();
  }
  
}