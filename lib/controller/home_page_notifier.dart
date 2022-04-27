import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_pre/models/home_page_state.dart';

class HomePageNotifier extends StateNotifier<HomePageState> {
  HomePageNotifier(this._read) : super(const HomePageState());

  final Reader _read;

  void increaseMainCount() async {
    state = state.copyWith(mainCount: state.mainCount + 1);
  }

  void increaseSubCount() async {
    state = state.copyWith(subCount: state.subCount + 1);
  }

  void resetAllCount() async {
    state = state.copyWith(
      mainCount: 0,
      subCount: 0,
    );
  }
}

final homePageNotifierProvider =
    StateNotifierProvider.autoDispose<HomePageNotifier, HomePageState>(
        (ref) => HomePageNotifier(ref.read));
