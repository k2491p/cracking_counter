import 'package:cracking_counter/application/dto/cracking_counters.dart';
import 'package:cracking_counter/application/shared.dart';
import 'package:cracking_counter/domain/entity/cracking_counter_entity.dart';
import 'package:cracking_counter/domain/repository/i_cracking_counter_repository.dart';

class CrackingCounterService {
  late ICrackingCounterRepository _repository;
  CrackingCounterService(this._repository);

  CrackingCounters getCrackingCounters() {
    CrackingCounters result = CrackingCounters([]);
    Future<List<CrackingCounterEntity>> future = _repository.getAll(Shared.userId ?? '');
    future.then((value) => result = CrackingCounters(value));
    return result;
  }
}
