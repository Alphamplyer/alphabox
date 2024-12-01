
class AnimationStudio {
  final String name;
  final String url;

  AnimationStudio({
    required this.name,
    required this.url,
  });

  @override
  String toString() {
    return 'Studio: $name ($url)';
  }

  factory AnimationStudio.defaultStudio() {
    return AnimationStudio(name: 'Unknown', url: '');
  }
}