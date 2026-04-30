class Run {
  String? id;
  String runWhere;
  String runPerson;
  double runDistance;

  Run({
    this.id,
    required this.runWhere,
    required this.runPerson,
    required this.runDistance,
  });

  factory Run.fromJson(Map<String, dynamic> json) {
    return Run(
      id: json['id'],
      runWhere: json['runWhere'],
      runPerson: json['runPerson'],
      runDistance: (json['runDistance'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'runWhere': runWhere,
      'runPerson': runPerson,
      'runDistance': runDistance,
    };
  }
}