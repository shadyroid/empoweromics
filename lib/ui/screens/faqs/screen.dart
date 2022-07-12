import 'package:empoweromics/data/models/responses/faqs_response.dart';
import 'package:empoweromics/ui/base/base_stateful_widget.dart';
import 'package:empoweromics/ui/componants/app_svg.dart';
import 'package:empoweromics/ui/componants/nav_drawer.dart';
import 'package:empoweromics/utils/app_colors.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:empoweromics/data/models/states/states.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc.dart';

class FAQsScreen extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() => FAQsScreenState();
}

class FAQsScreenState extends BaseStatefulWidgetState<FAQsScreen> {
  List<ExpansionTile> _listOfExpansions = [];
  FAQsCubit cubit = FAQsCubit();


  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      cubit.requestFAQs();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(3),
        appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: true,
          elevation: 0,
          toolbarHeight: AppSizes.h0_1,
          title: Text(
            'faqs'.tr,
            style: TextStyle(color: AppColors.black),
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: AppSvg.load(
                'assets/icons/ic_navigation_icon.svg',
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        body: BlocListener<FAQsCubit, BaseState>(
            bloc: cubit,
            listener: (BuildContext context, state) {
               if (state is FAQsResponseState) {
                _onFAQsResponse(state.response);
              }
            },
            child: Container(
              color: AppColors.white,
              padding: EdgeInsets.all(8.0),
              child: ListView(
                children: _listOfExpansions
                    .map((expansionTile) => expansionTile)
                    .toList(),
              ),
            )));
  }

  void _onFAQsResponse(FAQsResponse response) {
    setState(() {
      _listOfExpansions = List<ExpansionTile>.generate(
          response.data.length,
              (i) => ExpansionTile(
            title: Text(response.data[i].question),
            children: [Text(response.data[i].answer)],
          ));
    });
  }
}
