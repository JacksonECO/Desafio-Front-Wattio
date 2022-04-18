import 'package:desafio/enum/person.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
part 'simulation_store.g.dart';

class SimulationStore = _SimulationStoreBase with _$SimulationStore;

abstract class _SimulationStoreBase with Store {
  late TextEditingController controller;

  _SimulationStoreBase(this.controller) {
    value = 1000;
  }

  @observable
  Person person = Person.physical;

  @observable
  String _value = '1.000,00';

  @computed
  double get value {
    try {
      double temp = double.parse(_value.replaceAll('.', '').replaceAll(',', ''));
      temp = temp / 100;
      if (temp > 100000) {
        return 100000;
      }
      return temp;
    } catch (e) {
      return 0;
    }
  }

  @computed
  set value(dynamic value) {
    if (value is String) {
      _value = value;
      return;
    }
    String temp = value.toStringAsFixed(2);
    temp = temp.replaceAll('.', ',');
    if (temp.length >= 7) {
      temp = temp.substring(0, temp.length - 6) + '.' + temp.substring(temp.length - 6, temp.length);
    }
    _value = temp;
    controller.text = temp;
  }
}