import 'package:ecomikdeliveryapp/controller/chat_recipients_screen_controller.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_page_names.dart';
import 'package:ecomikdeliveryapp/utils/helpers/language_helper.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRecipientsScreen extends StatelessWidget {
  const ChatRecipientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatRecipientsScreenController>(
      global: false,
      init: ChatRecipientsScreenController(),
      builder: (controller) => DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: Image.asset(AppAssetImages.backgroundFullPng).image,
                fit: BoxFit.fill)),
        child: Scaffold(
          // / <-------- Appbar --------> /
          appBar: CoreWidgets.appBarWidget(
              screenContext: context,
              titleWidget: Text(LanguageHelper.currentLanguageText(
                  LanguageHelper.messageTransKey))),
          // / <-------- Content --------> /
          body: CustomScaffoldBodyWidget(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          final chatUser = controller.chatUsers[index];
                          return CustomListTileWidget(
                            child: Row(
                              children: [
                                NoImageAvatarWidget(
                                    firstName: chatUser.firstName,
                                    lastName: chatUser.lastName),
                                AppGaps.wGap15,
                                Expanded(
                                    child: Text(
                                        '${chatUser.firstName} ${chatUser.lastName}'))
                              ],
                            ),
                            onTap: () {
                              Get.toNamed(AppPageNames.chatScreen,
                                  arguments: chatUser);
                            },
                          );
                        },
                        separatorBuilder: (context, index) => AppGaps.hGap12,
                        itemCount: controller.chatUsers.length),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
