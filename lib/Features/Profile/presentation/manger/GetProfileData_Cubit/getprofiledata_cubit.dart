import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad/Features/Profile/data/models/user_profile_model.dart';
import 'package:tharad/Features/Profile/data/repos/profile_repos.dart';
import 'package:tharad/Features/Profile/presentation/manger/GetProfileData_Cubit/getprofiledata_state.dart';
import 'package:tharad/core/utils/helpers/Cache_helper.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepos profileRepos;

  ProfileCubit(this.profileRepos) : super(ProfileInitial());

  Future<void> getUserProfile({bool forceRefresh = false}) async {
    emit(ProfileLoading());

    try {
      if (!forceRefresh) {
        final cachedData = CacheHelper.getUserProfile();
        if (cachedData != null) {
          final user = UserProfileModel.fromJson(cachedData);
          emit(ProfileLoaded(user: user));

          getUserProfileFromApi();
          return;
        }
      }

      await getUserProfileFromApi();
    } catch (e) {
      final cachedData = CacheHelper.getUserProfile();
      if (cachedData != null) {
        final user = UserProfileModel.fromJson(cachedData);
        emit(ProfileLoaded(user: user));
      } else {
        emit(ProfileFailure('حدث خطأ أثناء تحميل البيانات: $e'));
      }
    }
  }

  Future<void> getUserProfileFromApi() async {
    try {
      final response = await profileRepos.getUserProfile();

      if (response.data != null) {
        await CacheHelper.saveUserProfile(response.data!.toJson());
        emit(ProfileLoaded(user: response.data!));
      } else {
        emit(ProfileFailure('لم يتم العثور على بيانات المستخدم'));
      }
    } catch (e) {
      rethrow;
    }
  }
}
