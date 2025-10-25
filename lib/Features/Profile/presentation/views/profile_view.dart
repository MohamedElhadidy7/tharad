import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tharad/Features/Auth/presentation/Widgets/Picked_image_widget.dart';
import 'package:tharad/Features/Auth/presentation/manger/LogOut_Cubit/log_out_cubit.dart';
import 'package:tharad/Features/Auth/presentation/manger/LogOut_Cubit/log_out_state.dart';
import 'package:tharad/Features/Profile/presentation/manger/GetProfileData_Cubit/getprofiledata_cubit.dart';
import 'package:tharad/Features/Profile/presentation/manger/GetProfileData_Cubit/getprofiledata_state.dart';
import 'package:tharad/Features/Profile/presentation/manger/UpdateProfile_Cubit/update_profile_data_cubit.dart';
import 'package:tharad/Features/Profile/presentation/manger/UpdateProfile_Cubit/update_profile_data_state.dart';
import 'package:tharad/constants.dart';
import 'package:tharad/core/Widgets/Custom_Buttom.dart';
import 'package:tharad/core/Widgets/Custom_TextFormField.dart';
import 'package:tharad/core/utils/helpers/validation.dart';
import 'package:tharad/core/utils/styles/app_styles.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController oldpasscontroller = TextEditingController();
  final TextEditingController newpasscontroller = TextEditingController();
  final TextEditingController confirmnewpasscontroller =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedImagePath;
  String? _currentUserImage;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getUserProfile();
  }

  @override
  void dispose() {
    namecontroller.dispose();
    emailcontroller.dispose();
    oldpasscontroller.dispose();
    newpasscontroller.dispose();
    confirmnewpasscontroller.dispose();
    super.dispose();
  }

  void _handleUpdateProfile() {
    if (_formKey.currentState!.validate()) {
      context.read<UpdateProfileCubit>().updateProfile(
        username: namecontroller.text.trim(),
        email: emailcontroller.text.trim(),
        imagePath: _selectedImagePath,
        password: oldpasscontroller.text.isNotEmpty
            ? oldpasscontroller.text
            : null,
        newPassword: newpasscontroller.text.isNotEmpty
            ? newpasscontroller.text
            : null,
        newPasswordConfirmation: confirmnewpasscontroller.text.isNotEmpty
            ? confirmnewpasscontroller.text
            : null,
      );
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('تسجيل الخروج'),
        content: const Text('هل أنت متأكد من تسجيل الخروج؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<LogoutCubit>().logout();
            },
            child: const Text(
              'تسجيل الخروج',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          actionsPadding: EdgeInsets.symmetric(horizontal: 20.w),
          toolbarHeight: 80.h,
          actions: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey.shade300.withOpacity(.4),
              child: const Icon(
                Icons.notifications_none,
                size: 20,
                color: Colors.white,
              ),
            ),
          ],
          title: Text(
            'الملف الشخصي',
            style: AppStyles.textstyle16.copyWith(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff5CC7A3), Color(0xff265355)],
              ),
            ),
          ),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is ProfileLoaded) {
                  namecontroller.text = state.user.username;
                  emailcontroller.text = state.user.email;
                  setState(() {
                    _currentUserImage = state.user.image;
                  });
                }
              },
            ),
            BlocListener<UpdateProfileCubit, UpdateProfileState>(
              listener: (context, state) {
                if (state is UpdateProfileSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: primaryColor,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  oldpasscontroller.clear();
                  newpasscontroller.clear();
                  confirmnewpasscontroller.clear();
                  _selectedImagePath = null;
                  context.read<ProfileCubit>().getUserProfile(
                    forceRefresh: true,
                  );
                } else if (state is UpdateProfileFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              },
            ),
            BlocListener<LogoutCubit, LogoutState>(
              listener: (context, state) {
                if (state is LogoutSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: primaryColor,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                  context.go('/');
                } else if (state is LogoutFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return Center(
                  child: CircularProgressIndicator(color: primaryColor),
                );
              }

              if (state is ProfileFailure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      Gap(16.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          state.errorMessage,
                          style: AppStyles.textstyle14,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Gap(16.h),
                      ElevatedButton(
                        onPressed: () {
                          context.read<ProfileCubit>().getUserProfile(
                            forceRefresh: true,
                          );
                        },
                        child: const Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                );
              }

              return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                builder: (context, updateState) {
                  final isUpdating = updateState is UpdateProfileLoading;

                  return BlocBuilder<LogoutCubit, LogoutState>(
                    builder: (context, logoutState) {
                      final isLoggingOut = logoutState is LogoutLoading;

                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Form(
                            key: _formKey,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Gap(32.h),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'إسم المستخدم',
                                      style: AppStyles.textstyle12,
                                    ),
                                  ),
                                  Gap(6.h),
                                  CustomTextFormField(
                                    hint: 'thar22',
                                    ispassword: false,
                                    controller: namecontroller,
                                    validator: AppValidators.validateUsername,
                                  ),
                                  Gap(12.h),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'البريد الإلكتروني',
                                      style: AppStyles.textstyle12,
                                    ),
                                  ),
                                  Gap(6.h),
                                  CustomTextFormField(
                                    hint: 'Tharad@gmail.com',
                                    ispassword: false,
                                    controller: emailcontroller,
                                    validator: AppValidators.validateEmail,
                                  ),
                                  Gap(12.h),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'الصوره الشخصية',
                                      style: AppStyles.textstyle12,
                                    ),
                                  ),
                                  Gap(6.h),
                                  PickedImageWidget(
                                    onImagePicked: (imagePath) {
                                      setState(() {
                                        _selectedImagePath = imagePath;
                                      });
                                    },
                                    initialImageUrl: _currentUserImage,
                                  ),
                                  Gap(12.h),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'كلمة المرور القديمه',
                                      style: AppStyles.textstyle12,
                                    ),
                                  ),
                                  Gap(6.h),
                                  CustomTextFormField(
                                    hint: '**********',
                                    ispassword: true,
                                    controller: oldpasscontroller,
                                    validator: AppValidators.validatePassword,
                                  ),
                                  Gap(12.h),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'كلمة المرور الجديدة',
                                      style: AppStyles.textstyle12,
                                    ),
                                  ),
                                  Gap(6.h),
                                  CustomTextFormField(
                                    hint: '**********',
                                    ispassword: true,
                                    controller: newpasscontroller,
                                    validator: AppValidators.validatePassword,
                                  ),
                                  Gap(12.h),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'تأكيد كلمة المرور الجديدة',
                                      style: AppStyles.textstyle12,
                                    ),
                                  ),
                                  Gap(6.h),
                                  CustomTextFormField(
                                    hint: '**********',
                                    ispassword: true,
                                    controller: confirmnewpasscontroller,
                                    validator: (value) {
                                      if (newpasscontroller.text.isNotEmpty) {
                                        return AppValidators.validateConfirmPassword(
                                          value,
                                          newpasscontroller.text,
                                        );
                                      }
                                      return null;
                                    },
                                  ),
                                  Gap(20.h),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 68,
                                    ),
                                    child: isUpdating
                                        ? CircularProgressIndicator(
                                            color: primaryColor,
                                          )
                                        : CustomButtom(
                                            text: 'حفظ التغييرات',
                                            onTap: _handleUpdateProfile,
                                          ),
                                  ),
                                  Gap(12.h),
                                  GestureDetector(
                                    onTap: isLoggingOut
                                        ? null
                                        : _showLogoutDialog,
                                    child: isLoggingOut
                                        ? SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.red,
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : Text(
                                            'تسجيل الخروج',
                                            style: AppStyles.textstyle14
                                                .copyWith(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor: Colors.red,
                                                  color: Colors.red,
                                                ),
                                          ),
                                  ),
                                  Gap(40.h),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
