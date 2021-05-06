import 'dart:core';

class Data {
  final String pulse;
  final String spo2;
  final String remarks;
  Data(this.pulse, this.spo2, this.remarks);

  Data.fromJson(Map<String, dynamic> json)
      : pulse = json['pulse'],
        spo2 = json['spo2'],
        remarks = json['remarks'];

  Map<String, dynamic> toJson() => {'pulse': pulse, 'spo2': spo2, 'remarks': remarks};
}
