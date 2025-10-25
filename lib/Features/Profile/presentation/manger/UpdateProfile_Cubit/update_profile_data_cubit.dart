import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad/Features/Profile/data/repos/profile_repos.dart';
import 'package:tharad/Features/Profile/presentation/manger/UpdateProfile_Cubit/update_profile_data_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final ProfileRepos profileRepos;

  UpdateProfileCubit(this.profileRepos) : super(UpdateProfileInitial());

  Future<void> updateProfile({
    required String username,
    required String email,
    String? imagePath,
    String? password,
    String? newPassword,
    String? newPasswordConfirmation,
  }) async {
    emit(UpdateProfileLoading());

    try {
      final response = await profileRepos.updateProfile(
        username: username,
        email: email,
        imagePath: imagePath,
        password: password,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
      );

      emit(UpdateProfileSuccess(response.message));
    } catch (e) {
      emit(UpdateProfileFailure('حدث خطأ أثناء تحديث البيانات: $e'));
    }
  }
}
