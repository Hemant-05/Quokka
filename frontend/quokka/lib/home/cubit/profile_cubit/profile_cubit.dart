import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_model.dart';
import '../../repository/user_repository.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository userRepository;

  ProfileCubit({required this.userRepository}) : super(ProfileInitial());

  Future<void> fetchUserProfile() async {
    emit(ProfileLoading());
    try {
      final user = await userRepository.getMyProfile();
      emit(ProfileLoaded(user: user));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
