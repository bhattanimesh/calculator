import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController valueController = TextEditingController(text: '0');
  int firstValue = 0;
  int secondValue = 0;
  String? operator;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0x3F6F6FF5),
      body: SafeArea(

        child: Container(
          padding: EdgeInsets.all(14),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(

                    child: TextField(

                      cursorColor: Color(0xFF4444AF),
                      controller: valueController,
                      keyboardType: TextInputType.none,
                      textAlign: TextAlign.end,
                         decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(32)),
                            borderSide:  BorderSide(color: Color(0xFD4B4BFA), width: 2.0)
                          ),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)),
                              borderSide:  BorderSide(color: Color(0xFD4B4BFA), width: 0.0)
                          ) ,
                          fillColor: Color(0x455B5BFC),
                          contentPadding: EdgeInsets.all(20)),
                    ),),
                  ),
                ),
              SizedBox(
                height:  (MediaQuery.of(context).size.height * 0.6) - 32,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        numberWidget(context, number: 1),
                        numberWidget(context, number: 2),
                        numberWidget(context,number: 3),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        numberWidget(context,number: 4),
                        numberWidget(context,number: 5),
                        numberWidget(context,number: 6),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        numberWidget(context,number: 7),
                        numberWidget(context,number: 8),
                        numberWidget(context,number: 9,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        numberWidget(context,number: 0),
                        numberWidget(context, action: "-"),
                        numberWidget(context,action: '*'),
                      ],
                    ),Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        numberWidget(context, action: "+"),
                        numberWidget(context,action: "/"),
                        numberWidget(context,action: '='),
                      ],
                    ),Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        numberWidget(context,action: "CLS"),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget numberWidget(BuildContext context, {int? number, String? action}){
    return GestureDetector(
      onTap: (){
        if(valueController.text == "0" && action == null){
          valueController.text = "$number";
        }else if(action == null){
          valueController.text = valueController.text + "$number";
        }else{
          switch(action){
            case '+':
              calculation();
              operator = '+';
              break;
            case '-':
              calculation();
              operator = '-';
              break;
            case '*':
              calculation();
              operator = '*';
              break;
            case '/':
              calculation();
              operator = '/';
              break;
            case 'CLS':
              calculation();
              operator = 'CLS';
              valueController.text = '0';
              break;
            case '=':
              calculation();
              valueController.text = "$firstValue";
          }
        }
        secondValue = int.tryParse(valueController.text) ?? 0;
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.25-16,
           decoration: BoxDecoration(

              color: Color(0x232323FF),
              //BoxShape shape = BoxShape.circle,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFD4B4BFA))
          ),
          child: Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${number ?? action}'),
          )),
        ),
      ),
    );
  }

  // function to Calculate
  void calculation() {
    print("-------------------------------------------");
    print("firstValue $firstValue");
    print("secondValue $secondValue");
    print("-------------------------------------------");

    // calculate value based on opeator, then reset value for second and operator
    if(firstValue != 0 && operator != null){
      switch(operator){
        case '+':
          firstValue = firstValue + secondValue;
          break;
        case '-':
          firstValue = firstValue - secondValue;
          break;
        case '*':
          firstValue = firstValue * secondValue;
          break;
        case '/':
          firstValue = (firstValue / secondValue) as int;
          break;
        case 'CLS':
          firstValue = 0;
          secondValue = 0;
          break;

      }
      secondValue = 0;
      operator = null;
    }else{
      firstValue = secondValue;
    }
    valueController.text = '';
  }
}