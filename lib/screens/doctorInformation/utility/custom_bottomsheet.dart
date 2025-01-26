import 'package:findmydoctor/stateManagement/getx_file.dart';
import 'package:findmydoctor/utility/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void customBottomSheet(context, nameController, ) {
  // final userData =Get.put(CustomStates(userToken: userToken));
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(12),
          decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          height: 400,
          child: Column(children: [
            customTextField(
                labelText: "Your Name",
                hintText: "",
                defaultValue:"" ,
                isEditable: false,
                controller: nameController),
            customTextField(
                labelText: "Your Name",
                hintText: "ritik",
                defaultValue: "",
                isEditable: false,
                controller: nameController),

          ]),
        );
      });
}
