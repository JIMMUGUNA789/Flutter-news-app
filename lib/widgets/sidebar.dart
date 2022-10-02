
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/helpers/updated_data.dart';
import 'package:newsapp/utils/utils.dart';
import 'package:newsapp/widgets/drop_down.dart';

Drawer sideDrawer(NewsController newsController) {
  return Drawer(
    backgroundColor:Colors.white,
    child: ListView(
      children: <Widget>[
        GetBuilder<NewsController>(
          builder: (controller) {
            return Container(
              
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              padding: const EdgeInsets.symmetric(
                  horizontal: 18, vertical:18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text("NewsToday Filter",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),),
                  ),
                  controller.cName.isNotEmpty
                      ? Text(
                          "Country: ${controller.cName.value.toUpperCase()}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        )
                      : const SizedBox.shrink(),
                  SizedBox(height: 5.0),
                  controller.category.isNotEmpty
                      ? Text(
                          "Category: ${controller.category.value.capitalizeFirst}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        )
                      : const SizedBox.shrink(),
                  SizedBox(height: 5.0,),
                  controller.channel.isNotEmpty
                      ? Text(
                          "Category: ${controller.channel.value.capitalizeFirst}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            );
          },
          init: NewsController(),
        ),

        /// For Selecting the Country
        ExpansionTile(
          collapsedTextColor: Colors.blue,
          collapsedIconColor: Colors.blue,
          iconColor: Colors.blue,
          textColor: Colors.blue,
          title: const Text("Select Country"),
          children: <Widget>[
            for (int i = 0; i < listOfCountry.length; i++)
              drawerDropDown(
                onCalled: () {
                  newsController.country.value = listOfCountry[i]['code']!;
                  newsController.cName.value =
                      listOfCountry[i]['name']!.toUpperCase();
                  newsController.getAllNews();
                  newsController.getBreakingNews();
                },
                name: listOfCountry[i]['name']!.toUpperCase(),
              ),
          ],
        ),

        /// For Selecting the Category
        ExpansionTile(
          collapsedTextColor: Colors.blue,
          collapsedIconColor: Colors.blue,
          iconColor:Colors.blue,
          textColor:Colors.blue,
          title: const Text("Select Category"),
          children: [
            for (int i = 0; i < listOfCategory.length; i++)
              drawerDropDown(
                  onCalled: () {
                    newsController.category.value = listOfCategory[i]['code']!;
                    newsController.getAllNews();
                  },
                  name: listOfCategory[i]['name']!.toUpperCase())
          ],
        ),

        /// For Selecting the Channel
        ExpansionTile(
          collapsedTextColor: Colors.blue,
          collapsedIconColor: Colors.blue,
          iconColor:Colors.blue,
          textColor: Colors.blue,
          title: const Text("Select Channel"),
          children: [
            for (int i = 0; i < listOfNewsChannel.length; i++)
              drawerDropDown(
                onCalled: () {
                  newsController.channel.value = listOfNewsChannel[i]['code']!;
                  newsController.getAllNews(
                      channel: listOfNewsChannel[i]['code']);
                  newsController.cName.value = '';
                  newsController.category.value = '';
                  newsController.update();
                },
                name: listOfNewsChannel[i]['name']!.toUpperCase(),
              ),
          ],
        ),
        const Divider(),
        ListTile(
            trailing: const Icon(
              Icons.done_sharp,
              size: 28,
              color: Colors.black,
            ),
            title: const Text(
              "Done",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            onTap: () => Get.back()),
      ],
    ),
  );
}