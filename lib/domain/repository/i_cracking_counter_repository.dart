import 'package:cracking_counter/domain/entity/cracking_counter_entity.dart';

abstract class ICrackingCounterRepository {
  List<CrackingCounterEntity> getAll(String? userId);
}
