import 'dart:async';

void Function() cDebounce(Duration duration, Function() action) {
  Timer? timer;

  return () {
    timer?.cancel();
    timer = Timer(duration, action);
  };
}
