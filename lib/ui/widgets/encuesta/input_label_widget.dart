
import 'package:flutter_actividades/core/encuesta/colors.dart';
import 'package:flutter_actividades/core/encuesta/dimens.dart';
import 'package:flutter_actividades/core/encuesta/styles.dart';
import 'package:flutter_actividades/ui/utils/preferencias_usuario.dart';
import 'package:flutter/material.dart';

class InputLabelWidget extends StatelessWidget {

  final String hintText;
  final bool enabled;
  final int maxLength;
  final TextInputType textInputType;
  final bool isObscure;
  final String initialValue;
  final String label;
  final String error;
  final TextEditingController textEditingController;
  final bool isTextArea;
  final void Function(String) onChanged;
  final void Function() onTap;
  final void Function() onPressedIconOverlay;
  final IconData iconOverlay;
  final double textSize;

  InputLabelWidget({
      @required this.hintText,
      this.iconOverlay,
      this.onPressedIconOverlay,
      this.enabled=true,
      this.maxLength=20,
      this.textInputType=TextInputType.name,
      this.isObscure=false,
      this.initialValue,
      this.textEditingController,
      this.isTextArea=false,
      this.label,
      this.onChanged,
      this.error,
      this.onTap,
      this.textSize,
    }
  );
  
  @override
  Widget build(BuildContext context) {

    final Size size=MediaQuery.of(context).size;
    return Column(
      children: [
        if(label!=null)
        Container(
          alignment: Alignment.centerLeft,
          height: size.height*inputDimension*0.9,
          child: Text(label,
            style: primaryTextStyle(),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: isTextArea ? size.height*inputDimension*1.5 : size.height*inputDimension,
            width: size.width,
            
            decoration: BoxDecoration(),
            child: Stack(
              children: [
                TextFormField(
                  enabled: enabled,
                  initialValue: initialValue,
                  maxLength: maxLength,
                  keyboardType: textInputType,
                  obscureText: isObscure,
                  maxLines: isTextArea ? 5 : 1,
                  decoration: InputDecoration(
                    border: error==null ? inputBorder() : inputBorderError(),
                    enabledBorder: error==null ? inputBorder() : inputBorderError(),
                    disabledBorder: error==null ? inputBorder() : inputBorderError(),
                    focusedBorder: error==null ? inputBorder() : inputBorderError(),
                    filled: true,
                    fillColor: (PreferenciasUsuario().modoDark) ? cardColorDark : cardColor,
                    contentPadding: isTextArea ? contentPaddingTextArea : contentPaddingInputs,
                    counterText: '',
                    counterStyle: TextStyle(fontSize: 0),
                    hintText: hintText,
                    hintStyle: primaryHintStyle(fontSize: textSize),
                  ),
                  controller: textEditingController,
                  onChanged: onChanged,
                  textAlign: TextAlign.left,
                ),
                
                if(iconOverlay!=null)
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: onPressedIconOverlay, 
                  icon: Icon(iconOverlay, color: infoColor,)))
              ],
            )
          ),
        ),
      ],
    );
  }
}