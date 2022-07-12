import 'package:empoweromics/data/models/beans/ad.dart';
import 'package:empoweromics/data/models/beans/service.dart';
import 'package:empoweromics/data/models/responses/ads_response.dart';
import 'package:empoweromics/data/models/responses/services_response.dart';
import 'package:empoweromics/data/models/states/states.dart';
import 'package:empoweromics/ui/adapters/services_adapter.dart';
import 'package:empoweromics/ui/base/base_stateful_widget.dart';
import 'package:empoweromics/ui/componants/ads.dart';
import 'package:empoweromics/ui/componants/app_svg.dart';
import 'package:empoweromics/ui/componants/nav_drawer.dart';
import 'package:empoweromics/ui/screens/main/cubit.dart';
import 'package:empoweromics/utils/app_colors.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MainScreen extends BaseStatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends BaseStatefulWidgetState<MainScreen>
    implements ServicesAdapterCallback {
  MainCubit cubit = MainCubit();

  ServicesAdapter servicesAdapter;
  List<Ad> ads = [];
  Service selectedService;

  @override
  void initState() {
    super.initState();
    servicesAdapter = ServicesAdapter(setState, this);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      cubit.requestServices();
      cubit.requestAds();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(1),
        appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: true,
          elevation: 0,
          toolbarHeight: AppSizes.h0_1,
          title: Text(
            'app_name'.tr,
            style: TextStyle(color: AppColors.black),
          ),
          leading: Builder(
            builder: (context) =>
                IconButton(
                  icon: AppSvg.load(
                    'assets/icons/ic_navigation_icon.svg',
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
          ),
        ),
        body: BlocListener<MainCubit, BaseState>(
            bloc: cubit,
            listener: (BuildContext context, state) {
               if (state is AdsResponseState) {
                _onAdsResponse(state.response);
              } else if (state is ServicesResponseState) {
                _onServicesResponse(state.response);
              }
            },
            child: Container(
              color: AppColors.white,
              height: AppSizes.screenHeight,
              child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.w0_07),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Ads(ads),
                          Align(
                              alignment: AlignmentDirectional.center,
                              child: servicesAdapter.build()),
                          Text(
                            'overview'.tr,
                            style: TextStyle(
                                color: AppColors.colorPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: AppSizes.txt_20),
                          ),
                          Text(" • " + 'purchase_new_unit'.tr),
                          Text(" • " + 'extend_installment_tenor'.tr),
                          Text(" • " + 'refinance_buy_lease_back'.tr),
                          Text('features'.tr,
                              style: TextStyle(
                                  color: AppColors.colorPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.txt_20)),
                          Text(" • " + 'tenor_up_to'.tr + " : " +
                              (selectedService != null
                              ? selectedService.Tenor
                              : "")+" "+ 'years'.tr),
                          Text(" • " + 'ftv_up_to'.tr + " : " +
                              (selectedService != null
                                  ? selectedService.FTV
                                  : "")+" "+ 'percentge'.tr),
                          Text(" • " + 'financed_amount_up_to'.tr + " : " +
                              (selectedService != null
                                  ? selectedService.financed_amount
                                  : "")+" "+ 'mn'.tr),
                          Text('eligibility_criteria'.tr,
                              style: TextStyle(
                                  color: AppColors.colorPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.txt_20)),
                          Text(" • " + 'egyptians'.tr),
                          Text(" • " + 'expats'.tr),
                          Text(" • " + 'non_egyptian_resident'.tr),
                        ]),
                  )),
            )));
  }

  void _onAdsResponse(AdsResponse response) {
    setState(() {
      ads = response.data;
    });
  }

  void _onServicesResponse(ServicesResponse response) {
    servicesAdapter.setData(response.data);
    servicesAdapter.setSelectedIndex(0);
    onServiceSelect(response.data[0]);
  }

  @override
  void onServiceSelect(Service service) {
    setState(() {
      selectedService = service;
    });
  }
}
