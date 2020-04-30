import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldValue extends StatefulWidget {
  final String label;
  final String data;
  final int maxLines;
  final TextInputType keyboardType;
  final bool isStart;
  final List<TextInputFormatter> inputFormatters;
  final FormFieldValidator<String> validator;
  final onSaved;
  TextFormFieldValue({Key key, this.label, this.validator, this.inputFormatters, this.isStart:false, this.keyboardType, this.maxLines, this.data, this.onSaved}):super(key: key);
  @override
  _TextFormFieldValueState createState() => _TextFormFieldValueState();
}

class _TextFormFieldValueState extends State<TextFormFieldValue> {
  TextEditingController controllerTextFormFieldValue = new TextEditingController();
  bool _isShowDelete;

  @override
  void initState() {
    super.initState();
    setState(() {
      controllerTextFormFieldValue.text = widget.data;
      _isShowDelete = true;
    });
    /// 获取初始化值
    _isShowDelete = controllerTextFormFieldValue.text.isNotEmpty;
    /// 监听输入改变  
    controllerTextFormFieldValue.addListener((){
      widget.onSaved(controllerTextFormFieldValue.text);
      setState(() {
        _isShowDelete = controllerTextFormFieldValue.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ShareDataWidget.of(context).data.isEmpty && controllerTextFormFieldValue.text != '') {
      Future.delayed(Duration(milliseconds: 50), () {
        setState(() {
          controllerTextFormFieldValue.text = '';
          _isShowDelete = false;
        });
      });
    }
    return Stack(
      alignment: Alignment.centerLeft,
      fit: StackFit.loose, //未定位widget占满Stack整个空间
      children: <Widget>[
        TextFormField(
          controller: controllerTextFormFieldValue,
          inputFormatters: widget.inputFormatters,
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          decoration: new InputDecoration(
            contentPadding: EdgeInsets.only(top: 10, right: 40, bottom: 10, left: 0),
            labelText: widget.label,
          ),
          onSaved: (val) {
            widget.onSaved(val);
          },
          validator: (val) {
            return widget.validator != null ? widget.validator(controllerTextFormFieldValue.text) : null;
          }
        ),
        Positioned(
          right: 0.0,
          child: _isShowDelete ? IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              widget.onSaved('');
            },
          ) : SizedBox(),
        ),
        Positioned(
          right: 0.0,
          child: widget.isStart ? Icon(
            Icons.star,
            color: Colors.red,
            size: 10,
          ) : SizedBox(),
        ),
      ],
    );
  }
}

class ShareDataWidget extends InheritedWidget {
  ShareDataWidget({
    @required this.data,
    Widget child
  }) :super(child: child);

  final data; //需要在子树中共享的数据，保存点击次数

  static ShareDataWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ShareDataWidget);
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget  
  @override
  bool updateShouldNotify(ShareDataWidget old) {
    //如果返回true，则子树中依赖(build函数中有调用)本widget
    //的子widget的`state.didChangeDependencies`会被调用
    return old.data != data;
  }
}