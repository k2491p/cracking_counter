// Mocks generated by Mockito 5.1.0 from annotations
// in cracking_counter/test/view_model/register_view_model_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:cracking_counter/application/service/cracking_counter_service.dart'
    as _i2;
import 'package:cracking_counter/domain/entity/cracking_counter_entity.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [CrackingCounterService].
///
/// See the documentation for Mockito's code generation for more information.
class MockCrackingCounterService extends _i1.Mock
    implements _i2.CrackingCounterService {
  MockCrackingCounterService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.CrackingCounterEntity>> getCrackingCounters() =>
      (super.noSuchMethod(Invocation.method(#getCrackingCounters, []),
              returnValue: Future<List<_i4.CrackingCounterEntity>>.value(
                  <_i4.CrackingCounterEntity>[]))
          as _i3.Future<List<_i4.CrackingCounterEntity>>);
}
