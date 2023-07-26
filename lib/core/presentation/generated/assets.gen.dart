/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/coke.png
  AssetGenImage get coke => const AssetGenImage('assets/images/coke.png');

  /// File path: assets/images/milk_soda.png
  AssetGenImage get milkSoda =>
      const AssetGenImage('assets/images/milk_soda.png');

  /// File path: assets/images/plaif_background.png
  AssetGenImage get plaifBackground =>
      const AssetGenImage('assets/images/plaif_background.png');

  /// File path: assets/images/plaif_circle.png
  AssetGenImage get plaifCircle =>
      const AssetGenImage('assets/images/plaif_circle.png');

  /// File path: assets/images/plaif_circle_crop.png
  AssetGenImage get plaifCircleCrop =>
      const AssetGenImage('assets/images/plaif_circle_crop.png');

  /// File path: assets/images/plaif_text.png
  AssetGenImage get plaifText =>
      const AssetGenImage('assets/images/plaif_text.png');

  /// File path: assets/images/sprite.png
  AssetGenImage get sprite => const AssetGenImage('assets/images/sprite.png');

  /// File path: assets/images/welchs.png
  AssetGenImage get welchs => const AssetGenImage('assets/images/welchs.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        coke,
        milkSoda,
        plaifBackground,
        plaifCircle,
        plaifCircleCrop,
        plaifText,
        sprite,
        welchs
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
