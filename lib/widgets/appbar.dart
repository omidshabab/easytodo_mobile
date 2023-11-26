import 'package:flutter/material.dart';
import 'package:todo_app/constants/config.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/todos_provider.dart';
import 'package:todo_app/utils/validate_empty.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smooth_widgets/widgets/buttons/icon_button.dart';
import 'package:smooth_widgets/widgets/buttons/text_button.dart';
import 'package:smooth_widgets/widgets/modals/modal.dart';
import 'package:smooth_widgets/widgets/textfields/textfield.dart';
import 'package:provider/provider.dart';

class TodoAppbar extends StatelessWidget {
  const TodoAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TodosProvider>();
    return Padding(
      padding: EdgeInsets.only(top: 55, bottom: 10, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            appName,
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          SmoothIconButton(
            icon: Ionicons.add_outline,
            onPressed: () {
              smoothModal(
                StatefulBuilder(
                  builder: (BuildContext context, setState) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Form(
                        key: provider.taskFormKey,
                        child: Column(
                          children: [
                            SmoothTextField(
                              hintText:
                                  "هر چی دلت می خواد انجام بدی رو وارد کن!",
                              prefixIcon: IconlyLight.paper,
                              validator: validateEmpty,
                              textfieldController: provider.textfieldController,
                              onChanged: (value) => {
                                provider.taskTextfieldValue = value,
                                setState(() => {})
                              },
                            ),
                            SizedBox(height: 15),
                            SmoothTextButton(
                              title: "تسکم رو ثبت کن",
                              backgroundColor: Colors.transparent,
                              isActive: true,
                              onPressed: () async {
                                if (provider.taskFormKey.currentState!
                                    .validate()) {
                                  final task = TaskModel()
                                    ..title = provider.taskTextfieldValue;

                                  provider.addTask(task);

                                  provider.textfieldController.clear();
                                  provider.taskTextfieldValue = "";

                                  Get.back();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                context,
              );
            },
          ),
        ],
      ),
    );
  }
}
