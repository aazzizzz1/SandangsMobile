import 'package:flutter/material.dart';
import 'package:sandangs/widget/main_button/list_button.dart';
import 'package:sandangs/widget/main_button/role_button.dart';

class MainButton extends StatelessWidget {
  const MainButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(ListButton().role.length, (index) => RoleCard(
            text: ListButton().role[index]["text"],
            icon: ListButton().role[index]["icon"],
            press: (){
              Navigator.push(
                (context),
                MaterialPageRoute(builder: (context) => ListButton().role[index]["route"]),
              );
              },
          ))
        ),
      ),
    );
  }
}
