import 'package:cracking_counter/application/dto/cracking_counters.dart';
import 'package:cracking_counter/application/shared.dart';
import 'package:cracking_counter/domain/entity/cracking_counter_entity.dart';
import 'package:cracking_counter/domain/repository/i_cracking_counter_repository.dart';
import 'package:cracking_counter/infrastructure/sqlite/cracking_counter_sqlite.dart';

class CrackingCounterService {
  late ICrackingCounterRepository _repository;
  CrackingCounterService() : this.repository(CrackingCounterSqlite());
  CrackingCounterService.repository(this._repository);

  Future<List<CrackingCounterEntity>> getCrackingCounters() async {
    List<CrackingCounterEntity> result = await _repository.getAll(Shared.userId ?? '');
    return result;
  }
}
