import 'package:cracking_counter/application/dto/cracking_counters.dart';
import 'package:cracking_counter/application/shared.dart';
import 'package:cracking_counter/domain/repository/i_cracking_counter_repository.dart';

class CrackingCounterService {
  late ICrackingCounterRepository _repository;
  CrackingCounterService(this._repository);

  CrackingCounters getCrackingCounters() {
    return CrackingCounters(_repository.getAll(Shared.userId));
  }
}
