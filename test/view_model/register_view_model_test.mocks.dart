// Mocks generated by Mockito 5.1.0 from annotations
// in cracking_counter/test/view_model/register_view_model_test.dart.
// Do not manually edit this file.

import 'package:cracking_counter/application/dto/cracking_counters.dart' as _i2;
import 'package:cracking_counter/application/service/cracking_counter_service.dart'
    as _i3;
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

class _FakeCrackingCounters_0 extends _i1.Fake implements _i2.CrackingCounters {
}

/// A class which mocks [CrackingCounterService].
///
/// See the documentation for Mockito's code generation for more information.
class MockCrackingCounterService extends _i1.Mock
    implements _i3.CrackingCounterService {
  MockCrackingCounterService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.CrackingCounters getCrackingCounters() =>
      (super.noSuchMethod(Invocation.method(#getCrackingCounters, []),
          returnValue: _FakeCrackingCounters_0()) as _i2.CrackingCounters);
}
