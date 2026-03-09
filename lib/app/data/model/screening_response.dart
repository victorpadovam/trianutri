class ScreeningResponse {
  int? id;
  int? firstQuestionPoints;
  int? secondQuestionPoints;
  int? thirdQuestionPoints;
  DateTime? createdAt;
  int? sum;
  bool? isMalnourished;
  String? firstQuestion;
  String? firstQuestionAnswer;
  String? secondQuestion;
  String? secondQuestionAnswer;
  String? thirdQuestion;
  String? thirdQuestionAnswer;

  ScreeningResponse(
      {this.id,
      this.firstQuestionPoints,
      this.secondQuestionPoints,
      this.thirdQuestionPoints,
      this.createdAt,
      this.sum,
      this.isMalnourished,
      this.firstQuestion,
      this.firstQuestionAnswer,
      this.secondQuestion,
      this.secondQuestionAnswer,
      this.thirdQuestion,
      this.thirdQuestionAnswer});

  ScreeningResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstQuestionPoints = json['first_question_points'];
    secondQuestionPoints = json['second_question_points'];
    thirdQuestionPoints = json['third_question_points'];
    createdAt = DateTime.parse(json['created_at']);
    sum = json['sum'];
    isMalnourished = json['is_malnourished'];
    firstQuestion = json['first_question'];
    firstQuestionAnswer = json['first_question_answer'];
    secondQuestion = json['second_question'];
    secondQuestionAnswer = json['second_question_answer'];
    thirdQuestion = json['third_question'];
    thirdQuestionAnswer = json['third_question_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['first_question_points'] = firstQuestionPoints;
    data['second_question_points'] = secondQuestionPoints;
    data['third_question_points'] = thirdQuestionPoints;
    data['created_at'] = createdAt;
    data['sum'] = sum;
    data['is_malnourished'] = isMalnourished;
    data['first_question'] = firstQuestion;
    data['first_question_answer'] = firstQuestionAnswer;
    data['second_question'] = secondQuestion;
    data['second_question_answer'] = secondQuestionAnswer;
    data['third_question'] = thirdQuestion;
    data['third_question_answer'] = thirdQuestionAnswer;
    return data;
  }
}
