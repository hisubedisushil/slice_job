import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/helpers/extensions/string_extension.dart';
import 'package:slice_job/helpers/util/util.dart';

class SliceImage extends ConsumerWidget {
  const SliceImage(
    this.url, {
    super.key,
    this.width = 50,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.enforceHeight = true,
  });

  final String? url;
  final double width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final bool enforceHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ezConsoleLog('url => $url, ::: cacheKey => ${url!.cacheKey()}');
    return url == null
        ? SizedBox(
            height: height?.w ?? 50.w,
            width: width.w,
            child: const Text('No Image'),
          )
        : CachedNetworkImage(
            key: ValueKey(url!.cacheKey()),
            cacheKey: url!.cacheKey(),
            imageUrl: url!,
            errorWidget: (cxt, str, val) {
              return SizedBox(
                height: height?.w ?? 50.w * 0.75,
                width: width.w * 0.75,
                child: Center(
                  child: Icon(
                    Ionicons.alert_circle_outline,
                    color: AppColors.red,
                    size: 25.w,
                  ),
                ),
              );
            },
            fit: fit,
            height: enforceHeight ? height?.w : null,
            width: width.w,
          );
  }
}
