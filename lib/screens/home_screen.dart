import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easytodo/providers/todos_provider.dart';
import 'package:easytodo/widgets/appbar.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:smooth_widgets/widgets/buttons/icon_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TodosProvider>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: TodoAppbar(),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.black.withOpacity(0.03),
            ),
            color: Color(0xffFEFEFE),
            borderRadius: BorderRadius.circular(50),
          ),
          child: context.watch<TodosProvider>().tasks.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/not_found.svg",
                        width: 250,
                      ),
                      SizedBox(height: 25),
                      Text(
                        "هنوز هیچ تسکی اینجا نیست!",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(
                            parent: ClampingScrollPhysics(),
                          ),
                          children: [
                            SizedBox(height: 20),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: Colors.black.withOpacity(0.03),
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("تعداد تسک ها"),
                                  Text(
                                      "${context.watch<TodosProvider>().tasks.length}"),
                                ],
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  context.watch<TodosProvider>().tasks.length,
                              itemBuilder: (context, index) {
                                final task =
                                    context.watch<TodosProvider>().tasks[index];

                                return GestureDetector(
                                  onTap: () {
                                    provider.toggleTask(task);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color: Colors.black.withOpacity(0.03),
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SmoothIconButton(
                                          icon: task.isDone
                                              ? Ionicons.checkmark_outline
                                              : Ionicons.square_outline,
                                          onPressed: () {
                                            //
                                          },
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Text(
                                              task.title,
                                              style: TextStyle(
                                                fontSize: 18,
                                                height: 1.8,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SmoothIconButton(
                                          icon: IconlyLight.delete,
                                          onPressed: () {
                                            provider.deleteTask(task);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
