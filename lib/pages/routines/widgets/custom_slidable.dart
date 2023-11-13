import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:soccer/pages/routines/models/exercise_model.dart';
import 'package:soccer/pages/routines/widgets/dialogs/alerts.dart';

import '../provider/provider_my_routines.dart';
import 'dialogs/alert_edit_weigth_size.dart';

class CustomSlidable extends StatefulWidget {
  final ExerciseModel exercise;
  final ProviderMyRoutines provider;
  final bool disabledSlider;

  const CustomSlidable(
      {Key? key,
      required this.exercise,
      required this.provider,
      this.disabledSlider = false})
      : super(key: key);

  @override
  CustomSlidableState createState() => CustomSlidableState();
}

class CustomSlidableState extends State<CustomSlidable> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _generateSlider();

  Widget _containerFlex({required Widget child}) => Flexible(
        flex: 1,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: child,
        ),
      );

  Widget _generateSlider() {
    return GestureDetector(
      onTap: () => Alerts.example(context: context, exercise: widget.exercise),
      child: Column(
        children: [
          Slidable(
            key: const ValueKey(0),
            enabled: !widget.disabledSlider,
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              dragDismissible: widget.disabledSlider,
              children: widget.disabledSlider
                  ? []
                  : [
                      SlidableAction(
                        onPressed: (context) {
                          widget.provider
                              .deleteExercise(exercise: widget.exercise);

                          widget.provider
                              .afterrDeleteExercise(exercise: widget.exercise);
                          //Navigator.pop(context);
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                content: AlertEditWeigthSize(
                                    exercise: widget.exercise),
                                actions: <Widget>[
                                  Center(
                                    child: ElevatedButton(
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40.0),
                                        child: Text('Guardar'),
                                      ),
                                      onPressed: () {
                                        /*
                                  widget.provider
                                      .editExercise(exercise: widget.exercise);
                                  */
                                        widget.provider.afterEditExercise(
                                            exercise: widget.exercise);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                          /*
                    setState(() {
                      widget.exercise.rep = 10;
                    });
                    */
                        },
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                      )
                    ],
            ),
            child: SizedBox(
              height: 60.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _containerFlex(
                      child: Text(
                    widget.exercise.name,
                    textAlign: TextAlign.center,
                  )),
                  _containerFlex(
                      child: Text(
                    widget.exercise.rep.toString(),
                    textAlign: TextAlign.center,
                  )),
                  _containerFlex(
                      child: Text(
                    _getWeigth(
                      weigth: widget.exercise.weigth.toString(),
                      type: widget.exercise.type,
                    ),
                    textAlign: TextAlign.center,
                  ))
                ],
              ),
            ),
          ),
          const Divider(color: Colors.grey, thickness: 0.5, height: 1.0),
        ],
      ),
    );
  }

  String _getWeigth({required String weigth, required int type}) =>
      '$weigth ${type == 0 ? 'Lbs' : 'Kg'}';
}
