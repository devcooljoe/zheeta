import 'package:flutter/material.dart';
import 'package:zheeta/app/common/color.dart';
import 'package:zheeta/app/router/app_router.dart';

class CustomBackButton extends StatelessWidget {
  final bool isOpaque;
  final bool greyBackground;
  const CustomBackButton({super.key, this.isOpaque = true, this.greyBackground = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        router.pop();
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: isOpaque
              ? greyBackground
                  ? AppColors.grey.withOpacity(0.1)
                  : AppColors.white
              : AppColors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: Icon(Icons.arrow_back_ios,
                size: 18,
                color: isOpaque
                    ? greyBackground
                        ? AppColors.grey
                        : AppColors.grey.withOpacity(0.4)
                    : AppColors.white),
          ),
        ),
      ),
    );
  }
}

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        router.pop();
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.only(left: 20, right: 5, bottom: 5, top: 5),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(100)),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Icon(Icons.arrow_back_ios, size: 18, color: AppColors.grey.withOpacity(0.4)),
        )),
      ),
    );
  }
}
