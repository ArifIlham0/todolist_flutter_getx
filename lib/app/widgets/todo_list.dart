import 'package:flutter/material.dart';
import 'package:todolist_get_new/app/widgets/export.dart';
import 'package:todolist_get_new/app/data/models/response/todo_res.dart';
import 'package:todolist_get_new/theme.dart';
import 'package:todolist_get_new/app/utils/export.dart';

class TodoList extends StatefulWidget {
  const TodoList({
    super.key,
    this.todos,
    this.isCompleted,
    this.onTap,
    this.onPressed,
    this.isSelected = false,
    this.onLongPress,
  });

  final Datum? todos;
  final bool? isCompleted;
  final Function()? onTap;
  final Function()? onPressed;
  final bool isSelected;
  final Function()? onLongPress;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp() {
    setState(() {
      _isPressed = false;
    });
    widget.onTap!();
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.isSelected);
    return AnimatedScale(
      scale: _isPressed ? 0.95 : 1.0,
      duration: const Duration(milliseconds: 100),
      child: GestureDetector(
        onTap: _onTapUp,
        onTapCancel: _onTapCancel,
        onTapDown: _onTapDown,
        onLongPress: () {
          widget.onLongPress!();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(right: 10.w),
            decoration: BoxDecoration(
              color: widget.isSelected ? kPurple : kGrey,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: widget.onPressed,
                  icon: Icon(
                    widget.isCompleted == true
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color: widget.isCompleted == true ? kPurple : kWhite,
                  ),
                ),
                WidthSpacer(width: 10.w),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeightSpacer(height: 5.h),
                      Text(
                        widget.todos!.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textStyles(14, kWhite, FontWeight.normal),
                      ),
                      Text(
                        widget.todos!.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textStyles(
                            14, kWhite.withOpacity(0.5), FontWeight.normal),
                      ),
                      HeightSpacer(height: 5.h),
                      Text(
                        formatDateTime(widget.todos!.time.toString()),
                        style: textStyles(12, kWhite, FontWeight.normal),
                      ),
                      HeightSpacer(height: 5.h),
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
