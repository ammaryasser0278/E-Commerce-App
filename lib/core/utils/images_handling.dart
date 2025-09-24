import 'package:flutter/material.dart';

class ImagesHandling extends StatelessWidget {
  final String src;
  final double? height;
  final double? width;
  final BoxFit fit;

  const ImagesHandling({
    super.key,
    required this.src,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final bool isNetwork =
        src.startsWith('http://') || src.startsWith('https://');
    if (isNetwork) {
      return Image.network(
        src,
        height: height ?? 200,
        width: width ?? double.infinity,
        fit: fit,
        filterQuality: FilterQuality.medium,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.error,
          size: 30,
          color: const Color.fromARGB(255, 155, 155, 155),
        ),
      );
    }
    return Image.asset(
      src,
      height: height ?? 230,
      width: width ?? double.infinity,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => Icon(
        Icons.error,
        size: 30,
        color: const Color.fromARGB(255, 155, 155, 155),
      ),
    );
  }
}
