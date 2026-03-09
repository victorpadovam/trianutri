import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trianutri_app/app/modules/login/Login_controller.dart';

class PasswordField extends StatefulWidget {
  final FormFieldValidator<String>? validator;

  const PasswordField({
    super.key,
    this.validator,
  });

  @override
  PasswordFieldState createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  final LoginController controller =
      Get.find<LoginController>(); // Obtém o controller

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Senha",
        suffixIcon: IconButton(
          icon: Icon(
            controller.obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              controller
                  .changeIcon(); // Chama a função no controller para alterar o estado
            });
          },
        ),
      ),
      obscureText: controller.obscureText,
      onChanged: (value) {
        controller.authDto.password = value;
      },
      validator: widget.validator,
    );
  }
}
