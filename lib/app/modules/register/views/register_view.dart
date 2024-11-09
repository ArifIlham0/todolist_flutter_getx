import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_get_new/app/data/models/request/auth_req.dart';
import 'package:todolist_get_new/app/modules/login/bindings/login_binding.dart';
import 'package:todolist_get_new/app/modules/login/views/login_view.dart';
import 'package:todolist_get_new/app/widgets/export.dart';
import 'package:todolist_get_new/theme.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  HeightSpacer(height: 50.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Register",
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
                                controller.register(AuthRequest(
                                  username: controller.usernameController.text,
                                  password: controller.passwordController.text,
                                ));
                              }
                            },
                            text: "Register",
                          ),
                  ),
                  HeightSpacer(height: 10.h),
                  TextButton(
                    onPressed: () {
                      Get.offAll(
                        () => const LoginView(),
                        binding: LoginBinding(),
                        transition: Transition.leftToRight,
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
                          "Already have an account? ",
                          style: textStyles(12, kWhite, FontWeight.normal),
                        ),
                        Text(
                          "Login",
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
