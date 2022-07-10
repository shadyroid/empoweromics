import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Service;
import 'package:get/get.dart';
import 'package:empoweromics/data/models/beans/service.dart';
import 'package:empoweromics/utils/app_colors.dart';
import 'package:empoweromics/utils/app_sizes.dart';

class ServicesAdapter {
  List<Service> data = [];
  final ServicesAdapterCallback servicesAdapterCallback;

  void Function(VoidCallback fn) notify;
  int selectedIndex = -1;

  ServicesAdapter(
      this.notify,
      this.servicesAdapterCallback,
      );

  void setData(List<Service> data) {
    notify(() {
      this.data = data;
    });
  }

  void setSelectedIndex(int index) {
    notify(() {
      selectedIndex = index;
    });
  }

  Widget build() {
    return Container(
      height: AppSizes.h0_12,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                servicesAdapterCallback.onServiceSelect(data[index]);
                setSelectedIndex(index);
              },
              child: Container(
                margin: EdgeInsetsDirectional.only(end: AppSizes.w0_05),
                padding: AppSizes.e0_002,
                decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? AppColors.colorPrimary
                        : AppColors.colorAccent,
                    border: Border.all(
                        color: selectedIndex == index
                            ? AppColors.colorPrimary
                            : AppColors.colorAccent),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Column(
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: AppSizes.h0_06,
                      imageUrl: data[index].image,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/logo.png'),
                        width: AppSizes.screenWidth,
                      ),
                    ),
                    Text(
                      data[index].name(Get.locale.languageCode),
                      style: TextStyle(
                          color: selectedIndex == index
                              ? AppColors.white
                              : AppColors.black),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

abstract class ServicesAdapterCallback {
  void onServiceSelect(Service service);
}
