import 'package:buzzle_game/modules/bloc/cubit/cubit.dart';
import 'package:buzzle_game/modules/bloc/states/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayBoard extends StatelessWidget {
  const PlayBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    //cubit.boardList.shuffle();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(10),
            itemCount: cubit.boardList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
              return (cubit.boardList[index] == 0)
                  ? SizedBox.shrink()
                  : InkWell(
                      onTap: () {
                        var tempIndex = index;
                        // if (index - 4 < 0 || index - 1 < 0) {
                        //   tempIndex = 1;
                        // }
                        if (cubit.boardList[index + 4 >= 16 ? 14 : index + 4] ==
                                0 ||
                            cubit.boardList[index - 4 < 0 ? 1 : index - 4] ==
                                0 ||
                            cubit.boardList[index - 1 < 0 ? 1 : index - 1] ==
                                0 ||
                            cubit.boardList[index + 1 >= 16 ? 14 : index + 1] ==
                                0) {
                          cubit.boardList[cubit.boardList.indexOf(0)] =
                              cubit.boardList[index];
                          cubit.boardList[index] = 0;
                          cubit.changestate();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(23),
                        ),
                        child: Center(
                          child: Text(
                            cubit.boardList[index].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
            },
          ),
        );
      },
    );
  }
}
