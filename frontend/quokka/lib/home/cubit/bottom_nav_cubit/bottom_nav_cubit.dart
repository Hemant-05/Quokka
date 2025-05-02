
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);

  void updateIndex(int index) => emit(index);
}
