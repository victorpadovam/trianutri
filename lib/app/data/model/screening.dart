class Screening {
  int? firstQuestionPoints;
  int? secondQuestionPoints;
  int? thirdQuestionPoints;

  Screening(
      {this.firstQuestionPoints,
      this.secondQuestionPoints,
      this.thirdQuestionPoints});

  Screening.fromJson(Map<String, dynamic> json) {
    firstQuestionPoints = json['first_question_points'];
    secondQuestionPoints = json['second_question_points'];
    thirdQuestionPoints = json['third_question_points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['first_question_points'] = firstQuestionPoints;
    data['second_question_points'] = secondQuestionPoints;
    data['third_question_points'] = thirdQuestionPoints;
    return data;
  }
}
