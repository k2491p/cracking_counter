import 'package:cracking_counter/domain/repository/i_cracking_counter_repository.dart';

class CrackingCounterService {
  late ICrackingCounterRepository _repository;
  CrackingCounterService(this._repository);

  getCrackingCounters() {}
}
