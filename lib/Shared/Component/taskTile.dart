import 'package:flutter/material.dart';
import 'package:to_do_app/Bloc/cubit.dart';
import 'package:to_do_app/Constant/constant.dart';

class TaskTile extends StatelessWidget {
  final Map item;
  final int value = 0;
  final Color color;

  const TaskTile({
    Key? key,
    required this.item,
    required this.color,
  }) : super(
          key: key,
        );

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        right: 25,
        left: 25,
      ),
      child: Dismissible(
        key: Key(
          item['id'].toString(),
        ),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: AlignmentDirectional.centerEnd,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              20,
            ),
            color: Colors.red.shade400,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              0.0,
              0.0,
              10.0,
              0.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'Delete item',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 28,
                ),
              ],
            ),
          ),
        ),
        onDismissed: (
          direction,
        ) {
          AppBloc.get(context).DeleteItem(
            id: item['id'],
          );
          AppBloc.get(
            context,
          ).notifyHelper.displayNotification(
                Title: 'ToDo',
                body: '${item['title']} Deleted',
              );
          AppBloc.get(
            context,
          ).notifyHelper.cancelNotification(
                item,
              );
        },
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item['endtime']}',
                        style: myNewFont,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '${item['title']}',
                        style: myNewFont,
                      ),
                    ]),
                Transform.scale(
                  scale: 1.5,
                  child: Checkbox(
                    value: item['status'] == 'completed' ? true : false,
                    shape: const CircleBorder(),
                    side: MaterialStateBorderSide.resolveWith(
                      (
                        states,
                      ) =>
                          BorderSide(
                        width: 1.0,
                        color: Colors.grey.shade100,
                      ),
                    ),
                    splashRadius: 10,
                    onChanged: (
                      value,
                    ) {
                      if (value! == true) {
                        AppBloc.get(
                          context,
                        ).MoveDataBaseScreen(
                          status: item['status'] == 'completed'
                              ? 'unCompleted'
                              : 'completed',
                          id: item['id'],
                        );
                      } else {
                        AppBloc.get(context).MoveDataBaseScreen(
                          status: item['status'] == 'unCompleted'
                              ? 'completed'
                              : 'unCompleted',
                          id: item['id'],
                        );
                      }
                    },
                    checkColor: Colors.white,
                    activeColor: color,
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
