import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_get_new/app/data/models/request/auth_req.dart';
import 'package:todolist_get_new/app/modules/register/bindings/register_binding.dart';
import 'package:todolist_get_new/app/modules/register/views/register_view.dart';
import 'package:todolist_get_new/app/widgets/export.dart';
import 'package:todolist_get_new/theme.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Form(
              key: controller.formKey,
              child: ListView(
                children: [
                  HeightSpacer(height: 50.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: textStyles(30, kWhite, FontWeight.normal),
                      ),
                    ],
                  ),
                  HeightSpacer(height: 40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Username",
                        style: textStyles(15, kWhite, FontWeight.normal),
                      ),
                    ],
                  ),
                  HeightSpacer(height: 5.h),
                  CustomTextField(
                    controller: controller.usernameController,
                    hintText: "Username",
                    keyboardType: TextInputType.name,
                    validator: (username) {
                      if (username!.isEmpty || username.length < 3) {
                        return "Username harus lebih dari 3";
                      } else {
                        return null;
                      }
                    },
                  ),
                  HeightSpacer(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Password",
                        style: textStyles(15, kWhite, FontWeight.normal),
                      ),
                    ],
                  ),
                  HeightSpacer(height: 5.h),
                  Obx(
                    () => CustomTextField(
                      controller: controller.passwordController,
                      hintText: "Password",
                      keyboardType: TextInputType.text,
                      obscureText: controller.obscureText.value,
                      validator: (password) {
                        if (password!.isEmpty || password.length < 7) {
                          return "Password tidak boleh kosong dan harus lebih dari 7";
                        } else {
                          return null;
                        }
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.toggleObscureText();
                        },
                        icon: Icon(
                          controller.obscureText.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: kWhite,
                        ),
                      ),
                    ),
                  ),
                  HeightSpacer(height: 50.h),
                  Obx(
                    () => controller.isLoading.value
                        ? LoadingButton(onPressed: () {})
                        : CustomButton(
                            onPressed: () {
                              if (controller.validateForm()) {
                                controller.login(
                                  AuthRequest(
                                    username:
                                        controller.usernameController.text,
                                    password:
                                        controller.passwordController.text,
                                  ),
                                );
                              }
                            },
                            text: "Login",
                          ),
                  ),
                  HeightSpacer(height: 10.h),
                  TextButton(
                    onPressed: () {
                      Get.offAll(
                        () => const RegisterView(),
                        binding: RegisterBinding(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 100),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: kWhite,
                      padding: const EdgeInsets.all(10),
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: textStyles(12, kWhite, FontWeight.normal),
                        ),
                        Text(
                          "Daftar",
                          style: textStyles(12, kWhite, FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
