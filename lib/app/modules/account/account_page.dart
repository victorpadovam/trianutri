import 'dart:convert';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trianutri_app/app/data/model/City.dart';
import 'package:trianutri_app/app/data/model/Gender.dart';
import 'package:trianutri_app/app/data/model/State.dart';
import 'package:trianutri_app/app/data/model/tratament.dart';
import 'package:trianutri_app/app/data/provider/api.dart';
import 'package:trianutri_app/app/data/utils/mask.dart';
import 'package:trianutri_app/app/modules/account/account_controller.dart';
import 'package:trianutri_app/app/modules/routes/app_routes.dart';
import 'package:trianutri_app/app/modules/widgets/custom_buttom.dart';
import 'package:trianutri_app/app/modules/widgets/custom_rounded_buttom.dart';
import 'package:trianutri_app/app/theme/app_colors.dart';
import 'package:trianutri_app/app/data/repository/auth_repository.dart';

class AccountPage extends GetView<AccountController> {
  final _formKeyStepOne = GlobalKey<FormState>();
  final _formKeyStepTwo = GlobalKey<FormState>();
  final _formKeyStepTres = GlobalKey<FormState>();
  final _formKeyStepQuadro = GlobalKey<FormState>();
  final AuthRepository repository = AuthRepository(apiClient: MyApiClient());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bege,
        body: Stack(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: AppColors.blue,
            ),
            Positioned(
              top: 45,
              right: 20,
              child: CustomRoundedButtom(
                callback: () => Get.toNamed(Routes.HOME),
                icon: const Icon(
                  FontAwesomeIcons.arrowLeft,
                  size: 15,
                ),
                padding: 15,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 90),
                  Text(
                    "Minha conta",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bege,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 170,
              left: 10,
              right: 10,
              child: Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  height: Get.height * 0.79,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: SingleChildScrollView(
                    child: Obx(() {
                      if (controller.loading) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Column(
                          children: [
                            Visibility(
                              visible: controller.step == 1,
                              child: Form(
                                key: _formKeyStepOne,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: FormBuilderTextField(
                                        readOnly: true,
                                        controller: controller.emailController,
                                        name: '',

                                        decoration: const InputDecoration(
                                          labelText: "E-mail",
                                        ),
                                        // validator: (value) {
                                        //   if (value == null ||
                                        //       value.isEmpty) {
                                        //     return "Campo obrigatório!";
                                        //   }
                                        //   return null;
                                        // },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: FormBuilderTextField(
                                        autofocus: false,
                                        controller:
                                            controller.birthDateController,
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        name: '',
                                        onChanged: (value) =>
                                            controller.form.birthDate = value,
                                        inputFormatters: [Mask.dateMask],
                                        decoration: const InputDecoration(
                                            labelText: "Data de Nascimento",
                                            hintText: "00/00/0000"),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Campo obrigatório!";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: DropDownTextField(
                                          controller:
                                              controller.genderController,
                                          clearOption: true,
                                          enableSearch: false,
                                          textFieldDecoration:
                                              const InputDecoration(
                                                  labelText: "Gênero"),
                                          clearIconProperty: IconProperty(
                                              color: AppColors.blue),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Campo obrigatório!";
                                            }
                                            return null;
                                          },
                                          dropDownItemCount:
                                              controller.geners.length,
                                          dropDownList: controller.geners
                                              .map<DropDownValueModel>(
                                                  (Gender gender) {
                                            return DropDownValueModel(
                                                name: gender.value,
                                                value: gender.id);
                                          }).toList(),
                                          onChanged: (value) {
                                            controller.genderIdController.text =
                                                value.value.toString();

                                            controller.gender = value.name;
                                            controller.form.genderId =
                                                value.value;
                                          }),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Obx(
                                        () => DropDownTextField(
                                            controller:
                                                controller.stateController,
                                            clearOption: true,
                                            enableSearch: true,
                                            searchDecoration:
                                                const InputDecoration(
                                              hintText: "Qual nome do estado?",
                                            ),
                                            textFieldDecoration:
                                                const InputDecoration(
                                              labelText: "Estado",
                                            ),
                                            clearIconProperty: IconProperty(
                                                color: AppColors.blue),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Campo obrigatório!";
                                              }
                                              return null;
                                            },
                                            dropDownItemCount: 10,
                                            dropDownList: controller.states
                                                .map<DropDownValueModel>(
                                                    (StateModel state) {
                                              return DropDownValueModel(
                                                  name: state.name,
                                                  value: state.id);
                                            }).toList(),
                                            onChanged: (value) {
                                              controller.state = value.name;
                                              controller.stateSelected =
                                                  value.value;
                                            }),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: GetBuilder<AccountController>(
                                          builder: (controller) {
                                        if (controller.isLoadingCities ==
                                                false &&
                                            controller.state != "") {
                                          SchedulerBinding.instance
                                              .addPostFrameCallback((_) {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Aguarde carregando lista de cidades...',
                                                ),
                                                duration: Duration(days: 1),
                                              ),
                                            );
                                          });
                                        } else {
                                          SchedulerBinding.instance
                                              .addPostFrameCallback((_) {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                          });
                                        }

                                        return Focus(
                                          onFocusChange: (hasFocus) {
                                            if (hasFocus) {
                                              if (controller.state == null ||
                                                  controller.state.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Selecione um estado para selecionar uma cidade.',
                                                    ),
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                          child:
                                              dropDownTextFieldCidadesComLista(),
                                        );
                                      }),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: CustomButtom(
                                        backgroundColor: AppColors.blue,
                                        font_color: AppColors.bege,
                                        text: "Próxima etapa".toUpperCase(),
                                        border_color: AppColors.blue,
                                        callback: () {
                                          if (controller
                                                  .birthDateController.text ==
                                              '00/00/0000') {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Data de Nascimento incorreta',
                                                ),
                                              ),
                                            );
                                          } else {
                                            controller
                                                .nextStep(_formKeyStepOne);
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: controller.step == 2,
                              child: Form(
                                key: _formKeyStepTwo,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomRoundedButtom(
                                        callback: () => controller.step = 1,
                                        icon: const Icon(
                                          FontAwesomeIcons.arrowLeft,
                                          size: 15,
                                        ),
                                        padding: 15),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: TextFormField(
                                        initialValue: controller.form.weight ==
                                                null
                                            ? ''
                                            : controller.form.weight.toString(),
                                        onChanged: (value) => controller
                                            .form.weight = double.parse(value),
                                        inputFormatters: [Mask.floatMask],
                                        decoration: const InputDecoration(
                                            labelText: "Peso (kg)",
                                            hintText: "Exemplo: 90.0"),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Campo obrigatório!";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: TextFormField(
                                        initialValue: controller.form.size ==
                                                null
                                            ? ''
                                            : controller.form.size.toString(),
                                        onChanged: (value) => controller
                                            .form.size = double.parse(value),
                                        inputFormatters: [Mask.floatMask],
                                        decoration: const InputDecoration(
                                            labelText: "Altura (m)",
                                            hintText: "Exemplo: 1.79"),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Campo obrigatório!";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: CustomButtom(
                                          backgroundColor: AppColors.blue,
                                          font_color: AppColors.bege,
                                          text: "Próxima etapa".toUpperCase(),
                                          border_color: AppColors.blue,
                                          callback: () => controller
                                              .nextStep(_formKeyStepTwo)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: controller.step == 3,
                              child: Form(
                                key: _formKeyStepTres,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomRoundedButtom(
                                        callback: () => controller.step = 2,
                                        icon: const Icon(
                                          FontAwesomeIcons.arrowLeft,
                                          size: 15,
                                        ),
                                        padding: 15),
                                    const Text(
                                      "Em qual situação você se encaixa? (marcar apenas uma)",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black),
                                    ),
                                    FormBuilderRadioGroup<String>(
                                      initialValue: controller.treatmentStatus,
                                      name: '',
                                      onChanged: (value) =>
                                          controller.treatmentStatus = value,
                                      options: controller.trataments
                                          .map((Tratament tratament) =>
                                              FormBuilderFieldOption(
                                                value: tratament.code,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(tratament.value),
                                                    Divider(),
                                                  ],
                                                ),
                                              ))
                                          .toList(growable: false),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Campo obrigatório!";
                                        }
                                        return null;
                                      },
                                      controlAffinity: ControlAffinity.leading,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: CustomButtom(
                                          backgroundColor: AppColors.blue,
                                          font_color: AppColors.bege,
                                          text: "Próxima etapa".toUpperCase(),
                                          border_color: AppColors.blue,
                                          callback: () => controller
                                              .nextStep(_formKeyStepTres)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: controller.step == 4,
                              child: Form(
                                key: _formKeyStepQuadro,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomRoundedButtom(
                                        callback: () => controller.step = 3,
                                        icon: const Icon(
                                          FontAwesomeIcons.arrowLeft,
                                          size: 15,
                                        ),
                                        padding: 15),
                                    const Text(
                                      "Qual das doenças abaixo você apresenta, além, da doença renal crônica? (podendo marcar mais de uma)",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black),
                                    ),
                                    FormBuilderCheckboxGroup<String>(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      initialValue:
                                          controller.illnessesSelected,
                                      name: '',
                                      onChanged: (value) =>
                                          controller.illnessesSelected = value,
                                      options: controller.illnesses
                                          .map((Tratament tratament) =>
                                              FormBuilderFieldOption(
                                                value: tratament.code,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(tratament.value),
                                                    Divider(),
                                                  ],
                                                ),
                                              ))
                                          .toList(growable: false),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Campo obrigatório!";
                                        }
                                        return null;
                                      },
                                    ),
                                    salvarForm(
                                      context,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    }),
                  )),
            )
          ],
        ));
  }

  DropDownTextField dropDownTextFieldCidadesComLista() {
    return DropDownTextField(
      controller: controller.cityController,
      clearOption: true,
      enableSearch: true,
      searchDecoration: const InputDecoration(
        hintText: "Qual nome da cidade?",
      ),
      textFieldDecoration: const InputDecoration(
        labelText: "Cidade",
      ),
      clearIconProperty: IconProperty(color: AppColors.blue),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Campo obrigatório!";
        }
        return null;
      },
      dropDownItemCount: 10,
      dropDownList:
          controller.cities.map<DropDownValueModel>((CityModel state) {
        return DropDownValueModel(name: state.name, value: state.id);
      }).toList(),
      onChanged: (value) {
        print(value);
        controller.city = value.name;
        controller.form.cityId = value.value;
        controller.cityIdController.text = value.value.toString();
      },
    );
  }

  Padding salvarForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GetBuilder<AccountController>(
        builder: (controller) {
          return controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.blue,
                    strokeWidth: 2,
                  ),
                )
              : CustomButtom(
                  backgroundColor: AppColors.blue,
                  font_color: AppColors.bege,
                  text: "SALVAR",
                  border_color: AppColors.blue,
                  callback: () async {
                    controller.setIsloadingTrue();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Carregando, aguarde...',
                        ),
                      ),
                    );

                    Map dados = await getSavedData();
                    var id = dados["id"];
                    var email = dados["email"];
                    var serumCreatinine = dados["serum_creatinine"];

                    var weight = controller.form.weight;
                    var size = controller.form.size;

                    var birthDate = controller.birthDateController.text;
                    var genderId =
                        controller.genderController.dropDownValue!.props[1];
                    var stateId =
                        controller.stateController.dropDownValue!.props[1];
                    var cityId =
                        controller.cityController.dropDownValue!.props[1];
                    var treatmentStatus = controller.treatmentStatus;

                    var illnesses = controller.illnessesSelected;

                    final form = AccountForm(
                      id: id,
                      email: email,
                      birthDate: birthDate,
                      genderId: int.tryParse(genderId.toString()),
                      stateId: int.tryParse(stateId.toString()),
                      cityId: int.tryParse(cityId.toString()),
                      treatmentStatus: treatmentStatus,
                      serumCreatinine: serumCreatinine.toDouble(),
                      weight: weight!.toDouble(),
                      size: size!.toDouble(),
                      illnesses: (illnesses as List<String>?)
                          ?.map((illnessName) => Illness(slug: illnessName))
                          .toList(),
                    );

                    var busca = await repository.update(
                      form,
                    );

                    if (busca == true) {
                      controller.setIsloadingFalse();
                      Get.offAllNamed(Routes.HOME);
                      Future.delayed(const Duration(milliseconds: 500), () {
                        controller.setEtapa();
                      });
                    }
                    if (busca == false) {
                      controller.setIsloadingFalse();
                    }
                  },
                );
        },
      ),
    );
  }
}

Future getSavedData() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString('me');
    if (savedData != null) {
      return jsonDecode(savedData) as Map<String, dynamic>;
    }
    return null;
  } catch (e) {
    print('Erro ao recuperar os dados salvos: $e');
    return null;
  }
}

class AccountForm {
  int? id;
  String? email;
  String? birthDate;
  double? serumCreatinine;
  double? weight;
  double? size;
  int? genderId;
  int? stateId;
  int? cityId;
  String? treatmentStatus;
  List<Illness>? illnesses;

  AccountForm({
    required this.id,
    required this.email,
    required this.birthDate,
    required this.genderId,
    required this.stateId,
    required this.cityId,
    required this.treatmentStatus,
    required this.serumCreatinine,
    required this.weight,
    required this.size,
    required this.illnesses,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "birth_date": birthDate,
      "serum_creatinine": serumCreatinine,
      "weight": weight,
      "size": size,
      "gender_id": genderId,
      "city_id": cityId,
      "treatment_status": treatmentStatus,
      "illnesses": illnesses?.map((illness) => illness.toJson()).toList(),
    };
  }
}

class Illness {
  String slug;

  Illness({required this.slug});

  Map<String, dynamic> toJson() {
    if (slug == "others") {
      return {
        "slug": slug,
        "comments": "não especificado",
      };
    }
    return {
      "slug": slug,
    };
  }
}
