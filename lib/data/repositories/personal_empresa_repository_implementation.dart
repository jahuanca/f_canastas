import 'package:flutter_actividades/data/http_manager/app_http_manager.dart';
import 'package:flutter_actividades/domain/entities/personal_empresa_entity.dart';
import 'package:flutter_actividades/domain/repositories/personal_empresa_repository.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:hive/hive.dart';

class PersonalEmpresaRepositoryImplementation
    extends PersonalEmpresaRepository {
  final urlModule = '/personal_empresa';

  @override
  Future<List<PersonalEmpresaEntity>> getAll() async {
    if (PreferenciasUsuario().offLine) {
      Box dataHive =
          await Hive.openBox<PersonalEmpresaEntity>('personal_sincronizar');
      List<PersonalEmpresaEntity> local = [];
      dataHive.toMap().forEach((key, value) => local.add(value));
      await dataHive.close();
      return local;
    }

    final AppHttpManager http = AppHttpManager();

    final res = await http.get(
      url: urlModule,
    );

    return personalEmpresaEntityFromJson((res));
  }

  @override
  Future<List<PersonalEmpresaEntity>> getAllBySubdivision(
      int idSubdivision) async {
    if (PreferenciasUsuario().offLine) {
      Box<PersonalEmpresaEntity> dataHive =
          await Hive.openBox<PersonalEmpresaEntity>('personal_sincronizar');
      List<PersonalEmpresaEntity> local = [];
      dataHive.values.forEach((element) {
        if (element.personalEmpresaSubdivision != null &&
            element.personalEmpresaSubdivision.idsubdivision == idSubdivision) {
          local.add(element);
        }
      });
      await dataHive.close();
      return local;
    }

    final AppHttpManager http = AppHttpManager();

    final res = await http.get(
      url: '$urlModule/subdivision/$idSubdivision',
    );

    return personalEmpresaEntityFromJson((res));
  }
}
