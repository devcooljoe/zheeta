import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zheeta/app/common/color.dart';
import 'package:zheeta/app/router/app_router.dart';
import 'package:zheeta/profile/presentation/viewmodel/location_viewmodel.dart';
import 'package:zheeta/widgets/primary_button.dart';

Future locationBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isDismissible: false,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          final locationViewModel = ref.read(locationViewModelProvider.notifier);
          final locationState = ref.watch(locationViewModelProvider);
          return Container(
            padding: EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Icon(Icons.location_pin, color: AppColors.primaryDark, size: 32.0),
                  SizedBox(height: 10),
                  Text("Location Services", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.primaryDark)),
                  SizedBox(height: 15),
                  Text('We need to know where you’re in order\nto find nearby friends', style: TextStyle(color: AppColors.grayscale, fontSize: 14, fontWeight: FontWeight.normal), textAlign: TextAlign.center),
                  SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      state: locationState.getCurrentLocationState.isLoading || locationState.getAddressFromLocationCoordinateState.isLoading,
                      title: 'Enable location services',
                      action: () async {
                        final result = await locationViewModel.getCurrentLocation();
                        if (result) router.pop();
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      invert: true,
                      color: AppColors.secondaryLight,
                      title: 'Skip',
                      action: () {
                        router.pop();
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
