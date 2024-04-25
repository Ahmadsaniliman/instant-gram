enum LottieAnimation {
  dataNotFound(name: 'animation_four.json'),
  empty(name: 'animation_one.json'),
  loading(name: 'animation_three.json'),
  smallError(name: 'animation_two.json'),
  error(name: 'animation_two.json');

  final String name;
  const LottieAnimation({
    required this.name,
  });
}
