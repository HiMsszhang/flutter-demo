import 'package:flutter/material.dart';
import 'package:molan_edu/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:molan_edu/utils/imports.dart';

class CommonSearch extends StatefulWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final bool autofocus;
  final ValueChanged<String> onSubmitted;
  final TextAlign textAlign;
  final Widget leading;
  final Widget action;
  final bool readOnly;
  final VoidCallback onTap;
  CommonSearch({
    Key key,
    this.hintText,
    this.onChanged,
    this.autofocus = false,
    this.onSubmitted,
    this.textAlign = TextAlign.left,
    this.leading,
    this.action,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  _CommonSearchState createState() => _CommonSearchState();
}

class _CommonSearchState extends State<CommonSearch> {
  String _inputText = "";
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController.fromValue(
      TextEditingValue(
        text: _inputText,
        selection: TextSelection.fromPosition(
          TextPosition(affinity: TextAffinity.downstream, offset: _inputText.length),
        ),
      ),
    );
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(64.w)),
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(163, 163, 163, 0.2), offset: Offset(0, 0), blurRadius: 30.w, spreadRadius: 0),
        ],
      ),
      constraints: BoxConstraints(maxHeight: 64.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          widget.leading ?? Container(),
          Expanded(
            child: TextField(
              style: Styles.normalFont(fontSize: 28.sp, color: Styles.colorText),
              controller: _controller,
              autofocus: widget.autofocus,
              textAlign: widget.textAlign,
              readOnly: widget.readOnly,
              onTap: () {
                if (!widget.readOnly) return;
                widget.onTap();
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: widget.hintText ?? S.current.inputPlaceholder,
                hintStyle: Styles.normalFont(color: Theme.of(context).disabledColor, fontSize: 28.sp),
                contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                suffixIcon: _inputText != ''
                    ? Padding(
                        padding: EdgeInsets.only(right: 40.w),
                        child: GestureDetector(
                          onTap: () {
                            _inputText = '';
                            widget.onChanged(_inputText);
                          },
                          child: Container(
                            width: 36.w,
                            height: 36.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(36.w),
                              color: Color.fromRGBO(67, 67, 67, .33),
                            ),
                            child: Icon(Icons.close, size: 24.w, color: Colors.white),
                          ),
                        ),
                      )
                    : Text(''),
                suffixIconConstraints: BoxConstraints(maxHeight: 56.w),
              ),
              onSubmitted: widget.onSubmitted,
              onChanged: (value) {
                _inputText = value;
                widget.onChanged(value);
                setState(() {});
              },
            ),
          ),
          widget.action ?? Container(),
        ],
      ),
    );
  }
}
