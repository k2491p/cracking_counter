import 'package:cracking_counter/application/dto/cracking_counters.dart';
import 'package:cracking_counter/application/shared.dart';
import 'package:cracking_counter/domain/entity/cracking_counter_entity.dart';
import 'package:cracking_counter/domain/entity/cracking_history_entity.dart';
import 'package:cracking_counter/domain/repository/i_cracking_counter_repository.dart';
import 'package:cracking_counter/domain/value_object/body_part_id.dart';
import 'package:cracking_counter/infrastructure/sqlite/cracking_counter_sqlite.dart';
import 'package:uuid/uuid.dart';

class CrackingCounterService {
  late ICrackingCounterRepository _repository;
  CrackingCounterService() : this.repository(CrackingCounterSqlite());
  CrackingCounterService.repository(this._repository);

  Future<List<CrackingCounterEntity>> getCrackingCounters() async {
    List<CrackingCounterEntity> crackingCounterEntityList = await _repository.getAll(Shared.userId.value);
    var result = setChildren(crackingCounterEntityList);
    return result;
  }

  List<CrackingCounterEntity> setChildren(List<CrackingCounterEntity> list) {
    List<CrackingCounterEntity> result = list.where((element) => element.parentId?.value == null).toList();
    var childrenList = list.where((element) => element.parentId?.value != null).map((e) => e.parentId?.value).toList();
    for (var parentId in childrenList) {
      var children = list.where((element) => element.parentId?.value == parentId).toList();
      for (var element in result) {
        if (element.bodyPartId?.value == parentId) element.children = children;
      }
    }
    return result;
  }

  void register(BodyPartId bodyPartId) {
    var entity = CrackingHistoryEntity(bodyPartId);
    _repository.register(entity);
  }

}
