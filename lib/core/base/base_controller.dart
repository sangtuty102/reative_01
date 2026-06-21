import 'package:get/get.dart';

enum ViewState { idle, loading, error, success }

class BaseController extends GetxController {
  final Rx<ViewState> _state = ViewState.idle.obs;

  ViewState get state => _state.value;

  void setViewState(ViewState newState) {
    _state.value = newState;
  }

  bool get isIdle => state == ViewState.idle;
  bool get isLoading => state == ViewState.loading;
  bool get isError => state == ViewState.error;
  bool get isSuccess => state == ViewState.success;
}
