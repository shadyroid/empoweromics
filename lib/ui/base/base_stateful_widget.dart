import 'package:empoweromics/utils/validation.dart';
import 'package:flutter/material.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  BaseStatefulWidget({Key key}) : super(key: key);
}

abstract class BaseStatefulWidgetState<Screen extends BaseStatefulWidget>
    extends State<Screen> {
  Validation validation;

  @override
  void initState() {
    super.initState();
    validation = Validation(context);
  }
}
