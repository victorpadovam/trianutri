class Register {
  String? birthDate;
  dynamic illnesses;
  int? genderId;
  int? cityId;
  double? serumCreatinine;
  double? size;
  String? treatmentStatus;
  double? weight;
  String? email;
  String? password;
  String? passwordConfirmation;

  Register(
      {this.birthDate,
      this.illnesses,
      this.genderId,
      this.cityId,
      this.serumCreatinine,
      this.size,
      this.treatmentStatus,
      this.weight,
      this.email,
      this.password,
      this.passwordConfirmation});

  Register.fromJson(Map<String, dynamic> json) {
    birthDate = json['birth_date'];
    illnesses = json['illnesses'];
    genderId = json['gender_id'];
    cityId = json['city_id'];
    serumCreatinine = json['serum_creatinine'];
    size = json['size'];
    treatmentStatus = json['treatment_status'];
    weight = json['weight'];
    email = json['email'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    final split =
        birthDate == null || birthDate == "" ? null : birthDate!.split('/');

    data['birth_date'] = split == null
        ? null
        : "${split[2]}-${split[1]}-${split[0]}"; // Verifica se split é nulo antes de acessar os índices
    data['illnesses'] = (illnesses as List<dynamic>)
        .map((value) => {"slug": value, "comments": value})
        .toList();
    data['gender_id'] = genderId; // Não é necessário usar ?? null
    data['city_id'] = cityId; // Não é necessário usar ?? null
    data['serum_creatinine'] = serumCreatinine;
    data['size'] = size; // Não é necessário usar ?? null
    data['weight'] = weight; // Não é necessário usar ?? null
    data['treatment_status'] = treatmentStatus;
    data['email'] = email;
    data['password'] = password;
    data['password_confirmation'] = passwordConfirmation;
    return data;
  }
}
