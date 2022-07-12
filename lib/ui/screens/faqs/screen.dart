import 'package:get/get.dart';
import 'package:empoweromics/data/models/events/events.dart';
import 'package:empoweromics/data/models/responses/faqs_response.dart';
import 'package:empoweromics/data/models/states/states.dart';
import 'package:empoweromics/ui/base/base_bloc.dart';
import 'package:empoweromics/ui/base/base_screen.dart';
import 'package:empoweromics/utills/app_colors.dart';
import 'package:empoweromics/utills/helpers.dart';
import 'package:flutter/material.dart';
import 'package:empoweromics/utills/validator.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc.dart';

class FAQsScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => FAQsScreenState();
}

class FAQsScreenState extends BaseScreenState<FAQsScreen> {
  List<ExpansionTile> _listOfExpansions = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<FAQsBloc>().add(FAQsRequestEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'faq'.tr,
            style: TextStyle(
              color: AppColors.white,
              decoration: TextDecoration.none,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.bgBlue,
        ),
        body: BlocListener<FAQsBloc, BaseState>(
            listener: (BuildContext context, state) {
              if (state is LoadingState)
                onLoading(state.isLoading);
              else if (state is FAQsResponseState) {
                _onFAQsResponse(state.response);
              } else if (state is ErrorState) {onApiError(state.response);}
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: ListView(
                children: _listOfExpansions
                    .map((expansionTile) => expansionTile)
                    .toList(),
              ),
            )));
  }

  void _onFAQsResponse(FAQsResponse response) {
    if (response.isSuccessful) {
      if (!Helpers.isAuthenticated(context, response.code)) return;
      if (response.status) {
        setState(() {
          _listOfExpansions = List<ExpansionTile>.generate(
              response.data.length,
              (i) => ExpansionTile(
                    title: Text(response.data[i].name),
                    children: [Text(response.data[i].description)],
                  ));
        });
      } else {
        onApiError(response);
      }
    } else {
      onApiError(response);
    }
  }
}
