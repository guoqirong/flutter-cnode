import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnode/model/user/user_model.dart';
import 'package:flutter_cnode/utils/string_util.dart';
import 'package:flutter_cnode/utils/toast_util.dart';
import 'package:flutter_cnode/widget/form_widget.dart';

class LoginFormPage extends StatefulWidget {
  LoginFormPage({Key key}) : super(key: key);

  @override
  _LoginFormPageState createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  UserModel model = UserModel();
  String accessToken;
  bool isSubmit = false;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('token登录'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  ShareDataWidget(
                    data: accessToken??'',
                    child: TextFormFieldValue(
                      label: '登录标识accessToken',
                      maxLines: 1,
                      data: accessToken??'',
                      onSaved: (val) {
                        setState(() {
                          if (!StringUtil.isEmpty(val)) {
                            accessToken = val;
                          } else {
                            accessToken = '';
                          }
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return '不能为空';
                        }
                        return null;
                      }
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: ScreenUtil.getScaleH(context, 42),
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      disabledColor: Colors.lightBlueAccent,
                      disabledTextColor: Colors.grey[200],
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          isSubmit ? Container(
                            height: ScreenUtil.getScaleH(context, 24),
                            width: ScreenUtil.getScaleW(context, 24),
                            margin: EdgeInsets.only(right: 10),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(Colors.grey[200]),
                            ),
                          ) : SizedBox(),
                          Text(
                            '登录',
                            style: TextStyle(
                              fontSize: ScreenUtil.getScaleSp(context, 16),
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      onPressed: !isSubmit ? () async {
                        setState(() {
                          isSubmit = true;
                        });
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          if (accessToken.isNotEmpty) {
                            var data = await model.findAccesstoken(token: accessToken);
                            if (data['success']) {
                              Navigator.pop(context, accessToken);
                            } else {
                              ToastUtil.show(data['error_msg'], duration: 2000);
                              setState(() {
                                isSubmit = false;
                              });
                            }
                          } else {
                            setState(() {
                              isSubmit = false;
                            });
                          }
                        } else {
                          setState(() {
                            isSubmit = false;
                          });
                        }
                      } : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}