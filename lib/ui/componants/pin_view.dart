import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Take it from pin_view 1.0.1

class PinView extends StatefulWidget {
  final Function submit;
  final int count;
  final bool obscureText;
  final bool autoFocusFirstField;
  final bool enabled;
  final List<int> dashPositions;
  final TextStyle style;
  final TextStyle dashStyle;
  final InputDecoration inputDecoration;
  final EdgeInsetsGeometry margin;
  final bool requestFocus;

  PinView(
      {@required this.submit,
      @required this.count,
      this.obscureText: false,
      this.autoFocusFirstField: true,
      this.enabled: true,
      this.dashPositions: const [],
      this.dashStyle: const TextStyle(fontSize: 30.0, color: Colors.grey),
      this.style: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
      ),
      this.inputDecoration:
          const InputDecoration(border: UnderlineInputBorder()),
      this.margin: const EdgeInsets.all(5.0),
      this.requestFocus});

  @override
  _PinViewState createState() => _PinViewState();
}

class _PinViewState extends State<PinView> {
  List<TextEditingController> _controllers;
  List<FocusNode> _focusNodes;
  List<String> _pin;

  @override
  void initState() {
    super.initState();

    _pin = List<String>.generate(widget.count, (int index) => "");
    _focusNodes =
        List.generate(widget.count, (int index) => FocusNode()).toList();
    _controllers =
        List.generate(widget.count, (int index) => TextEditingController());

    _focusNodes = List.generate(widget.count, (int index) {
      FocusNode focusNode = FocusNode();

      focusNode.addListener(() {
        if (focusNode.hasFocus&&index != 0&&_pin[index-1] == "") {
          focusNode.unfocus();
          FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
        }
      });
      focusNode.onKey = (focusNode, event) {
        if (focusNode.hasFocus &&
            index != 0 &&_pin[index] == ""&&
            event.logicalKey == LogicalKeyboardKey.backspace) {
          focusNode.unfocus();
          FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
        }
        return KeyEventResult.ignored;
      };
      return focusNode;
    }).toList();
  }

  Widget _dash() {
    return Flexible(flex: 1, child: Text("-", style: widget.dashStyle));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pins = List<Widget>.generate(
        widget.count, (int index) => _singlePinView(index)).toList();

    for (int i in widget.dashPositions) {
      if (i <= widget.count) {
        List<int> smaller =
            widget.dashPositions.where((int d) => d < i).toList();
        pins.insert(i + smaller.length, _dash());
      }
    }

    if (widget.requestFocus != null ? widget.requestFocus : false)
      FocusScope.of(context).requestFocus(_focusNodes[0]);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: pins),
      ),
    );
  }

  Widget _singlePinView(int index) {
    return Flexible(
        flex: 3,
        child: Container(
            margin: widget.margin,
            child: TextField(
              enabled: widget.enabled,
              controller: _controllers[index],
              obscureText: widget.obscureText,
              autofocus: widget.autoFocusFirstField ? index == 0 : false,
              focusNode: _focusNodes[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: widget.style,
              decoration: widget.inputDecoration,
              textInputAction: TextInputAction.next,
              onChanged: (String val) {
                if (val.length == 1) {
                  _pin[index] = val;
                  if (index != _focusNodes.length - 1) {
                    _focusNodes[index].unfocus();
                    FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                  }
                } else if (val.length == 2) {
                  _controllers[index].text = val.substring(0, 1);
                  _pin[index] = val.substring(0, 1);
                  if ((index + 1) < _controllers.length) {
                    _controllers[index + 1].text = "";
                    _controllers[index + 1].text = val.substring(1);
                    _pin[index + 1] = val.substring(1);
                    FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                  }
                } else {
                  _pin[index] = "";
                  if (index != 0) {
                    _focusNodes[index].unfocus();
                    FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                  }
                }

                if (_pin.indexOf("") == -1) {
                  widget.submit(_pin.join());
                }
              },
            )));
  }
}
