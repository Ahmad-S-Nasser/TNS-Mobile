import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState(index: 4)); // Default to Home (index 4)

  void changeIndex(int index) => emit(MainState(index: index));
}
