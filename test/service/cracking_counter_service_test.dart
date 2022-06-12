import 'package:cracking_counter/application/dto/cracking_counters.dart';
import 'package:cracking_counter/application/service/cracking_counter_service.dart';
import 'package:cracking_counter/application/shared.dart';
import 'package:cracking_counter/domain/entity/cracking_counter_entity.dart';
import 'package:cracking_counter/domain/repository/i_cracking_counter_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';
import 'cracking_counter_service_test.mocks.dart';

@GenerateMocks([ICrackingCounterRepository])
void main() {
  final repository = MockICrackingCounterRepository();
  test("一覧取得", () async {
    var uuid = const Uuid();
    var userId = uuid.v4();
    Shared.userId = userId;
    var entity1 = CrackingCounterEntity(userId, uuid.v4(), '首', 10, 1, uuid.v4());
    var entity2 = CrackingCounterEntity(userId, uuid.v4(), '腰', 15, 2, uuid.v4());
    var crackingCounters = CrackingCounters([entity1, entity2]);
    when(repository.getAll(userId)).thenAnswer((_) async => [entity1, entity2]);

    var service = CrackingCounterService.repository(repository);
    var result = await service.getCrackingCounters();

    expect(result, crackingCounters.value);
  });
}
