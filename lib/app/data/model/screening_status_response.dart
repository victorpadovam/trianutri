class ScreeningStatusResponse {
  bool? isScreeningEnabled;
  DateTime? nextScreeningAt;

  ScreeningStatusResponse({
    this.isScreeningEnabled,
    this.nextScreeningAt,
  });

  ScreeningStatusResponse.fromJson(Map<String, dynamic> json) {
    isScreeningEnabled = json['is_screening_enabled'];
    nextScreeningAt = DateTime.parse(json['next_screening_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['is_screening_enabled'] = isScreeningEnabled;
    data['next_screening_at'] = nextScreeningAt;
    return data;
  }
}
