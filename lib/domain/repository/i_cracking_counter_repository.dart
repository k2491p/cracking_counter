import 'package:cracking_counter/application/dto/cracking_counters.dart';

abstract class ICrackingCounterRepository {
  CrackingCounters getAll();
}
