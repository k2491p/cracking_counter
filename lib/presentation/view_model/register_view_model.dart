import 'package:cracking_counter/application/dto/cracking_counters.dart';
import 'package:cracking_counter/application/service/cracking_counter_service.dart';
import 'package:cracking_counter/domain/entity/cracking_counter_entity.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final registerViewModelProvider = ChangeNotifierProvider((ref) => RegisterViewModel());

class RegisterViewModel extends ChangeNotifier {
  late List<CrackingCounterEntity> _crackingList;
  late CrackingCounterService _service;
  List<CrackingCounterEntity> get crackingList => _crackingList;

  RegisterViewModel() : this.service(CrackingCounterService());
  RegisterViewModel.service(this._service) {
    updateList();
  }

  updateList() async {
    _crackingList = await _service.getCrackingCounters();
    // notifyListeners();
  }
}
