import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trianutri_app/app/data/model/City.dart';
import 'package:trianutri_app/app/data/model/Gender.dart';
import 'package:trianutri_app/app/data/model/State.dart';
import 'package:trianutri_app/app/data/model/register.dart';
import 'package:trianutri_app/app/data/model/tratament.dart';
import 'package:trianutri_app/app/data/repository/auth_repository.dart';
import 'package:trianutri_app/app/data/repository/register_repository.dart';
import 'package:trianutri_app/app/modules/account/account_page.dart';
import 'package:trianutri_app/app/theme/app_colors.dart';

class AccountController extends GetxController {
  late final RegisterRepository repository;
  late final AuthRepository authRepository;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController genderIdController = TextEditingController();
  final TextEditingController cityIdController = TextEditingController();
  final TextEditingController treatmentStatusCodeController =
      TextEditingController();

  final SingleValueDropDownController genderController =
      SingleValueDropDownController();

  final SingleValueDropDownController cityController =
      SingleValueDropDownController();
  final SingleValueDropDownController stateController =
      SingleValueDropDownController();

  AccountController({required this.repository, required this.authRepository});

  final RxList<StateModel> _states = <StateModel>[].obs;
  final RxList<CityModel> _cities = <CityModel>[].obs;
  final form = Register();

  final _gender = ''.obs;
  final _state = ''.obs;
  final _city = ''.obs;
  final _loading = false.obs;

  final _treatmentStatus = ''.obs;

  final _illnesses = [].obs;

  final _stateSelected = 0.obs;
  final _step = 1.obs;

  final List<Gender> geners = [
    Gender(id: 1, value: "Masculino"),
    Gender(id: 2, value: "Feminino"),
    Gender(id: 3, value: "Não quero informar"),
  ];

  final List<Tratament> trataments = [
    Tratament(code: "do_hemodialysis", value: "Realizo hemodiálise"),
    Tratament(code: "do_not_hemodialysis", value: "Não realizo hemodiálise"),
    Tratament(code: "peritoneal_dialysis", value: "Realizo diálise peritonea"),
    Tratament(code: "transplanted", value: "Sou transplantado"),
  ];

  final List<Tratament> illnesses = [
    Tratament(
        code: "arterial_hypertension",
        value: "Hipertensão Arterial (pressão alta)"),
    Tratament(code: "diabetes", value: "Diabetes"),
    Tratament(code: "others", value: "Outras"),
  ];

  List<StateModel> get states => _states.value;

  List<CityModel> get cities => _cities.value;

  set step(value) => _step.value = value;
  get step => _step.value;

  set stateSelected(value) => _stateSelected.value = value;
  get stateSelected => _stateSelected.value;

  set gender(value) => _gender.value = value;
  get gender => _gender.value;

  set state(value) => _state.value = value;
  get state => _state.value;

  set city(value) => _city.value = value;
  get city => _city.value;

  set loading(value) => _loading.value = value;
  get loading => _loading.value;

  set treatmentStatus(value) => _treatmentStatus.value = value;
  get treatmentStatus => _treatmentStatus.value;

  set illnessesSelected(value) => _illnesses.value = value;
  get illnessesSelected => _illnesses.value;
  var isLoadingCities = false;

  updateStateTrue() {
    isLoadingCities = true;
    update();
  }

  updateStateFalse() {
    isLoadingCities = false;
    update();
  }

  // set form(value) => _form.value = value;
  // Register get form => _form.value;

  loadStates() async {
    _states.value = await repository.states();
    update();
  }

  loadCities(String state) async {
    try {
      updateStateFalse();
      await Future.delayed(Duration(seconds: 2));
      _cities.value = await repository.cities(state);
      updateStateTrue();
    } catch (e) {
      print("Erro ao carregar cidades: $e");
    } finally {
      updateStateTrue();
    }
  }

  nextStep(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      step = step + 1;
    } else {
      print("Formulario invalido");
    }
  }

  setEtapa() {
    step = 1;
    update();
  }

  bool isLoading = false;

  setIsloadingTrue() {
    isLoading = true;
    update();
  }

  setIsloadingFalse() {
    isLoading = false;
    update();
  }

  int? cidadeId = 0;
  updateCidade(int nova) {
    cidadeId = nova;
    update();
  }

  loaduser() async {
    final user = await authRepository.me();
    await loadStates();

    if (user['me']['city'] != null && user['me']['city']['state_id'] != null) {
      await loadCities(user['me']['city']['state_id'].toString());
    }

    // Verificação para o campo de gênero
    final genderSelected = user['me']['gender_id'] != null
        ? geners.firstWhere((i) => i.id == user['me']['gender_id'])
        : null;

    final stateSelected =
        user['me']['city'] != null && user['me']['city']['state_id'] != null
            ? states.firstWhere((i) => i.id == user['me']['city']['state_id'])
            : null;

    final citySelected = user['me']['city'] != null
        ? cities.firstWhere((i) => i.id == user['me']['city']['id'])
        : null;

    if (user['me']['birth_date'] != null) {
      birthDateController.text = DateFormat("dd/MM/y")
          .format(DateTime.parse(user['me']['birth_date']));
    } else {
      birthDateController.text = '00/00/0000';
    }

    if (user['me']['size'] != null) {
      form.size = user['me']['size'].toDouble();
    }

    if (user['me']['weight'] != null) {
      form.weight = user['me']['weight'].toDouble();
    }

    if (user['me']['birth_date'] != null) {
      birthDateController.text = DateFormat("dd/MM/y")
          .format(DateTime.parse(user['me']['birth_date']));
    }

    emailController.text = user['me']['email'];

    // Verificação e atribuição do valor de gênero
    if (genderSelected != null) {
      genderController.dropDownValue = DropDownValueModel(
          name: genderSelected.value, value: genderSelected.id);
    }

    // Verificação e atribuição do valor de cidade
    if (citySelected != null) {
      cityController.dropDownValue =
          DropDownValueModel(name: citySelected.name, value: citySelected.id);
    }

    // Verificação e atribuição do valor de estado
    if (stateSelected != null) {
      stateController.dropDownValue =
          DropDownValueModel(name: stateSelected.name, value: stateSelected.id);
    }

    treatmentStatus = user['me']['treatment_status'];

    final List<dynamic> teste = user['illnesses'];
    illnessesSelected = teste.map((i) => i['slug'] as String).toList();

    print(illnessesSelected);

    loading = false;
  }

  buscaDadosDoPerfil() {
    return Scaffold(
      body: FutureBuilder(
        future: loaduser(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(color: AppColors.blue),
              );
            case ConnectionState.none:
              print("none");
              break;
            case ConnectionState.active:
              print("active");
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                print('error');
              }

              WidgetsBinding.instance.addPostFrameCallback((_) {
                Get.showSnackbar(
                  const GetSnackBar(
                    message: 'Carregando dados da sua conta...',
                    duration: Duration(seconds: 2),
                    snackPosition: SnackPosition.BOTTOM,
                  ),
                );
              });

              return AccountPage();
          }

          return Container();
        },
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();

    // loaduser();

    ever(_stateSelected, (state) {
      loadCities(state.toString());
    });
  }

  @override
  void onReady() {
    super.onReady();
    setEtapa(); // Executa toda vez que a página é carregada
  }
}
