import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:trianutri_app/app/data/model/City.dart';
import 'package:trianutri_app/app/data/model/tratament.dart';
import 'package:trianutri_app/app/data/utils/mask.dart';
import 'package:trianutri_app/app/modules/register/register_controller.dart';
import 'package:trianutri_app/app/modules/routes/app_routes.dart';
import 'package:trianutri_app/app/modules/widgets/custom_buttom.dart';
import 'package:trianutri_app/app/modules/widgets/custom_rounded_buttom.dart';
import 'package:trianutri_app/app/theme/app_colors.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends GetView<RegisterController> {
  final _formKeyStepOne = GlobalKey<FormState>();
  final _formKeyStepTwo = GlobalKey<FormState>();

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
          Padding(
            padding: const EdgeInsets.only(top: 45, left: 300),
            child: CustomRoundedButtom(
              callback: () => Get.toNamed(Routes.LOGIN),
              icon: const Icon(
                FontAwesomeIcons.arrowLeft,
                size: 15,
              ),
              padding: 15,
            ),
          ),
          const Align(
            alignment: Alignment(-0.8, -0.72),
            child: Text(
              "Criar acesso",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: AppColors.bege,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 150,
            ),
            child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: Get.height * 0.95,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: SingleChildScrollView(
                  child: Obx(() {
                    print(controller.isLoadingCities);

                    return Column(
                      children: [
                        Visibility(
                            visible: controller.step == 1,
                            child: Form(
                                key: _formKeyStepOne,
                                child: Column(
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.only(top: 20),
                                    //   child: TextFormField(
                                    //     initialValue: controller.form.birthDate,
                                    //     onChanged: (value) =>
                                    //         controller.form.birthDate = value,
                                    //     inputFormatters: [Mask.dateMask],
                                    //     decoration: const InputDecoration(
                                    //         labelText: "Data de Nascimento",
                                    //         hintText: "00/00/0000"),
                                    //     keyboardType: TextInputType.number,
                                    //     validator: (value) {
                                    //       if (value == null || value.isEmpty) {
                                    //         return "Campo obrigatório!";
                                    //       }
                                    //       return null;
                                    //     },
                                    //   ),
                                    // ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(top: 20),
                                    //   child: DropDownTextField(
                                    //       initialValue: controller.gender,
                                    //       clearOption: true,
                                    //       enableSearch: false,
                                    //       textFieldDecoration:
                                    //           const InputDecoration(
                                    //               labelText: "Gênero"),
                                    //       clearIconProperty: IconProperty(
                                    //           color: AppColors.blue),
                                    //       validator: (value) {
                                    //         if (value == null ||
                                    //             value.isEmpty) {
                                    //           return "Campo obrigatório!";
                                    //         }
                                    //         return null;
                                    //       },
                                    //       dropDownItemCount:
                                    //           controller.geners.length,
                                    //       dropDownList: controller.geners
                                    //           .map<DropDownValueModel>(
                                    //               (Gender gender) {
                                    //         return DropDownValueModel(
                                    //           name: gender.value,
                                    //           value: gender.id,
                                    //         );
                                    //       }).toList(),
                                    //       onChanged: (value) {
                                    //         controller.gender = value.name;
                                    //         controller.form.genderId =
                                    //             value.value;
                                    //       }),
                                    // ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(top: 20),
                                    //   child: Obx(
                                    //     () => DropDownTextField(
                                    //       initialValue: controller.state,
                                    //       clearOption: true,
                                    //       enableSearch: true,
                                    //       searchDecoration:
                                    //           const InputDecoration(
                                    //         hintText: "Qual nome do estado?",
                                    //       ),
                                    //       textFieldDecoration:
                                    //           const InputDecoration(
                                    //         labelText: "Estado",
                                    //       ),
                                    //       clearIconProperty: IconProperty(
                                    //           color: AppColors.blue),
                                    //       validator: (value) {
                                    //         if (value == null ||
                                    //             value.isEmpty) {
                                    //           return "Campo obrigatório!";
                                    //         }
                                    //         return null;
                                    //       },
                                    //       dropDownItemCount: 10,
                                    //       dropDownList: controller.states
                                    //           .map<DropDownValueModel>(
                                    //               (StateModel state) {
                                    //         return DropDownValueModel(
                                    //             name: state.name,
                                    //             value: state.id);
                                    //       }).toList(),
                                    //       onChanged: (value) {
                                    //         controller.state = value.name;
                                    //         controller.stateSelected =
                                    //             value.value;
                                    //       },
                                    //     ),
                                    //   ),
                                    // ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(top: 20),
                                    //   child: GetBuilder<RegisterController>(
                                    //       builder: (controller) {
                                    //     if (controller.isLoadingCities ==
                                    //             false &&
                                    //         controller.state != "") {
                                    //       SchedulerBinding.instance
                                    //           .addPostFrameCallback((_) {
                                    //         ScaffoldMessenger.of(context)
                                    //             .hideCurrentSnackBar();
                                    //         ScaffoldMessenger.of(context)
                                    //             .showSnackBar(
                                    //           const SnackBar(
                                    //             content: Text(
                                    //               'Aguarde carregando lista de cidades...',
                                    //             ),
                                    //             duration: Duration(days: 1),
                                    //           ),
                                    //         );
                                    //       });
                                    //     } else {
                                    //       SchedulerBinding.instance
                                    //           .addPostFrameCallback((_) {
                                    //         ScaffoldMessenger.of(context)
                                    //             .hideCurrentSnackBar();
                                    //       });
                                    //     }

                                    //     return Focus(
                                    //       onFocusChange: (hasFocus) {
                                    //         if (hasFocus) {
                                    //           if (controller.state == null ||
                                    //               controller.state.isEmpty) {
                                    //             ScaffoldMessenger.of(context)
                                    //                 .showSnackBar(
                                    //               const SnackBar(
                                    //                 content: Text(
                                    //                   'Selecione um estado para selecionar uma cidade.',
                                    //                 ),
                                    //               ),
                                    //             );
                                    //           }
                                    //         }
                                    //       },
                                    //       child:
                                    //           dropDownTextFieldCidadesComLista(),
                                    //     );
                                    //   }),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: TextFormField(
                                        initialValue: controller
                                                    .form.serumCreatinine ==
                                                null
                                            ? ''
                                            : controller.form.serumCreatinine
                                                .toString(),
                                        onChanged: (value) =>
                                            controller.form.serumCreatinine =
                                                double.parse(value),
                                        inputFormatters: [Mask.floatMask],
                                        decoration: const InputDecoration(
                                            labelText:
                                                "Creatinina sériaca (MG/DL)",
                                            hintText: "Exemplo: 2.0, 0.77"),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Campo obrigatório!";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(top: 20),
                                    //   child: TextFormField(
                                    //     initialValue: controller.form.weight ==
                                    //             null
                                    //         ? ''
                                    //         : controller.form.weight.toString(),
                                    //     onChanged: (value) => controller
                                    //         .form.weight = double.parse(value),
                                    //     inputFormatters: [Mask.floatMask],
                                    //     decoration: const InputDecoration(
                                    //         labelText: "Peso (kg)",
                                    //         hintText: "Exemplo: 90.0"),
                                    //     keyboardType: TextInputType.number,
                                    //     validator: (value) {
                                    //       if (value == null || value.isEmpty) {
                                    //         return "Campo obrigatório!";
                                    //       }
                                    //       return null;
                                    //     },
                                    //   ),
                                    // ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(top: 20),
                                    //   child: TextFormField(
                                    //     initialValue: controller.form.size ==
                                    //             null
                                    //         ? ''
                                    //         : controller.form.size.toString(),
                                    //     onChanged: (value) => controller
                                    //         .form.size = double.parse(value),
                                    //     inputFormatters: [Mask.floatMask],
                                    //     decoration: const InputDecoration(
                                    //         labelText: "Altura (m)",
                                    //         hintText: "Exemplo: 1.79"),
                                    //     keyboardType: TextInputType.number,
                                    //     validator: (value) {
                                    //       if (value == null || value.isEmpty) {
                                    //         return "Campo obrigatório!";
                                    //       }
                                    //       return null;
                                    //     },
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: CustomButtom(
                                          backgroundColor: AppColors.blue,
                                          font_color: AppColors.bege,
                                          text: "Próxima etapa".toUpperCase(),
                                          border_color: AppColors.blue,
                                          callback: () => controller
                                              .nextStep(_formKeyStepOne)),
                                    )
                                  ],
                                ))),
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
                                    const Text(
                                      "Em qual situação você se encaixa? (marcar apenas uma)",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black),
                                    ),
                                    FormBuilderRadioGroup<String>(
                                      initialValue:
                                          controller.form.treatmentStatus,
                                      name: '',
                                      onChanged: (value) => controller
                                          .form.treatmentStatus = value,
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
                                              .nextStep(_formKeyStepTwo)),
                                    )
                                  ],
                                ))),
                        Visibility(
                            visible: controller.step == 3,
                            child: Form(
                                key: _formKeyStepTwo,
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
                                      "Qual das doenças abaixo você apresenta, alé, da doenã renal crônica? (podendo marcar mais de uma)",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black),
                                    ),
                                    FormBuilderCheckboxGroup<String>(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      initialValue: controller.form.illnesses,
                                      name: '',
                                      onChanged: (value) =>
                                          controller.form.illnesses = value,
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
                                ))),
                        Visibility(
                          visible: controller.step == 4,
                          child: Form(
                            key: _formKeyStepTwo,
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
                                  "Os próximos dados serão utilizados por você para ter acesso ao aplicativo.\nMantenha eles seguros e não se esqueça deles.",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: FormBuilderTextField(
                                    autovalidateMode: AutovalidateMode.always,
                                    name: 'E-mail',
                                    decoration: const InputDecoration(
                                      labelText: 'E-mail',
                                    ),
                                    onChanged: (val) =>
                                        controller.form.email = val,
                                    validator: Validatorless.multiple([
                                      Validatorless.email('E-mail invalido'),
                                      Validatorless.required(
                                          'Campo obrigatorio')
                                    ]),
                                    initialValue: controller.form.email,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: FormBuilderTextField(
                                    autovalidateMode: AutovalidateMode.always,
                                    name: 'Senha',
                                    decoration: const InputDecoration(
                                      labelText: 'Senha',
                                    ),
                                    onChanged: (val) =>
                                        controller.form.password = val,
                                    validator: Validatorless.multiple([
                                      Validatorless.required(
                                          'Campo obrigatorio'),
                                      Validatorless.min(6,
                                          'É preciso ter no minimo 6 digitos')
                                    ]),
                                    initialValue: controller.form.password,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: FormBuilderTextField(
                                    autovalidateMode: AutovalidateMode.always,
                                    name: 'Confirmação da Senha',
                                    decoration: const InputDecoration(
                                      labelText: 'Confirmação da Senha',
                                    ),
                                    onChanged: (val) => controller
                                        .form.passwordConfirmation = val,
                                    validator: Validatorless.multiple([
                                      Validatorless.required(
                                          'Campo obrigatorio'),
                                      Validatorless.min(6,
                                          'É preciso ter no minimo 6 digitos'),
                                      (value) {
                                        print(
                                            "Valor do input $value e ${controller.form.password}");
                                        if (value != controller.form.password) {
                                          return "As duas senhas devem ser iguais!";
                                        }
                                      }
                                    ]),
                                    initialValue: controller.form.password,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 20),
                                //   child: CustomButtom(
                                //       backgroundColor: AppColors.blue,
                                //       font_color: AppColors.bege,
                                //       disabled: controller.loading,
                                //       text:
                                //           "${controller.loading ? 'Salvando...' : 'Finalizar'}"
                                //               .toUpperCase(),
                                //       border_color: AppColors.blue,
                                //       callback: () => controller.register()),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () => controller.register(),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.blue,
                                        disabledBackgroundColor: Colors.grey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: controller.loading
                                          ? const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : Text(
                                              'Finalizar'.toUpperCase(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }),
                )),
          )
        ],
      ),
    );
  }

  DropDownTextField dropDownTextFieldCidadesComLista() {
    return DropDownTextField(
      initialValue: controller.city,
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
      dropDownList:
          controller.cities.map<DropDownValueModel>((CityModel state) {
        return DropDownValueModel(name: state.name, value: state.id);
      }).toList(),
      dropDownItemCount: 10,
      onChanged: (value) {
        controller.city = value.name;
        controller.form.cityId = value.value;
      },
    );
  }

  dropDownTextFieldCidadesSemLista(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Aguarde carregando lista de cidades...',
        ),
      ),
    );
  }
}
