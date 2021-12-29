import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/icon_content.dart';
import '../components/reusable_card.dart';
import '../constants.dart';
import 'results_page.dart';
import '../components/bottom_button.dart';
import '../components/round_icon_button.dart';
import 'package:bmi_calculator/calculator_brain.dart';

enum Gender{
  male,
  female,
}

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? selectedGender;
  int height = 180;
  int mass = 60;
  int age = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('BMI CALCULATOR')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: ReusableCard(
                        onPress: (){
                          setState(() {
                            selectedGender = Gender.male;
                          });
                        },
                        colour: selectedGender == Gender.male ? kActiveCardColor : kInactiveCardColor,
                        cardChild: IconContent(
                          cardIcon: FontAwesomeIcons.mars,
                          cardText: 'MALE',
                        ),
                      ),
                  ),
                  Expanded(
                      child: ReusableCard(
                        onPress: (){
                          setState(() {
                            selectedGender = Gender.female;
                          });
                        },
                        colour: selectedGender == Gender.female  ? kActiveCardColor : kInactiveCardColor,
                        cardChild: IconContent(
                          cardIcon: FontAwesomeIcons.venus,
                          cardText: 'FEMALE',
                        ),
                      ),
                  ),
                ],
              )
          ),
          Expanded(
              child: ReusableCard(
                  colour: kActiveCardColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'HEIGHT',
                        style: kLabelTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        textBaseline: TextBaseline.alphabetic,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Text(
                            height.toString(),
                            style: kNumberTextStyle,
                          ),
                          Text(
                            'cm',
                            style: kLabelTextStyle,
                          )
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.white,
                          inactiveTrackColor: Color(0xFF8D8E98),
                          overlayColor: Color(0x29EB1555),
                          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                          overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                          thumbColor: Color(0xFFEB1555),
                        ),
                        child: Expanded(
                          child: Slider(
                            value: height.toDouble(),
                            min: kSliderMin.toDouble(),
                            max: kSliderMax.toDouble(),
                            onChanged: (double newValue) {
                              setState(() {
                                height = newValue.round();
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
              )
          ),
          Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ReusableCard(
                      colour: kActiveCardColor,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'WEIGHT',
                            style: kLabelTextStyle,
                          ),
                          Text(
                            mass.toString(),
                            style: kNumberTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(
                                  onClick: (){
                                    setState(() {
                                      if(mass > 0) mass--;
                                    });
                                  },
                                  iconData: FontAwesomeIcons.minus
                              ),
                              SizedBox(width: 10.0),
                              RoundIconButton(
                                  onClick: (){
                                    setState(() {
                                      if(mass < 300) mass++;
                                    });
                                  },
                                  iconData: FontAwesomeIcons.plus
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: ReusableCard(
                        colour: kActiveCardColor,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'AGE',
                              style: kLabelTextStyle,
                            ),
                            Text(
                              age.toString(),
                              style: kNumberTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RoundIconButton(
                                    onClick: (){
                                      setState(() {
                                        if(age > 0) age--;
                                      });
                                    },
                                    iconData: FontAwesomeIcons.minus
                                ),
                                SizedBox(width: 10.0),
                                RoundIconButton(
                                    onClick: (){
                                      setState(() {
                                        if(age < 130) age++;
                                      });
                                    },
                                    iconData: FontAwesomeIcons.plus
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                  )
                ],
              )
          ),
          BottomButton(
            buttonTitle: 'CALCULATE',
            onTap: (){
              CalculatorBrain calc = CalculatorBrain(height: height, weight: mass);
              Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage(
                bmiResult: calc.calculateBMI(),
                resultText: calc.getResult(),
                interpretation: calc.getInterpretation(),
              )));
            },
          ),
        ],
      ),
    );
  }
}

