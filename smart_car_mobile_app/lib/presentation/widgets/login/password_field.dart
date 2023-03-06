import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smart_car_mobile_app/controllers/login_controller.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.loginController,
  });

  final LoginController loginController;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Obx(
          () => TextFormField(
            validator: (value) {
              return loginController.validatePassword(value!);
            },
            onSaved: (value) => loginController.passwordController,
            cursorColor: const Color.fromARGB(255, 145, 55, 55),
            controller: loginController.passwordController,
            obscureText: loginController.obscureText.value,
            decoration: InputDecoration(
              filled: true, //<-- SEE HERE
              fillColor: Colors.grey[900],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: "Password",
              errorStyle: const TextStyle(
                  fontSize: 15, color: Color.fromARGB(182, 227, 34, 20)),
              prefixIcon: const Icon(Icons.lock, color: Colors.white),
              suffixIcon: Obx(() => IconButton(
                    onPressed: () {
                      loginController.obscureText.value =
                          !loginController.obscureText.value;
                      // setState(() {
                      //   obscureText = !obscureText;
                      // });
                    },
                    icon: loginController.obscureText.value
                        ? const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          )
                        // ignore: dead_code
                        : const Icon(
                            Icons.visibility,
                            color: Colors.white,
                          ),
                  )),
            ),
          ),
        ));
  }
}
