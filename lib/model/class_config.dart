class ClassConfig {
  int id;
  int classId;
  double minimumAverage;
  int maxQntAbsence;

  ClassConfig({this.id, this.classId, this.minimumAverage, this.maxQntAbsence});

  ClassConfig.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classId = json['classId'];
    minimumAverage = json['minimumAverage'];
    maxQntAbsence = json['maxQntAbsence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['classId'] = classId;
    data['minimumAverage'] = minimumAverage;
    data['maxQntAbsence'] = maxQntAbsence;
    return data;
  }
}
