import 'package:ecomikdeliveryapp/controller/support_chat_controller.dart';
import 'package:ecomikdeliveryapp/models/fake_data.dart';
import 'package:ecomikdeliveryapp/models/fake_models/chat_message_model.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_constants.dart';
import 'package:ecomikdeliveryapp/utils/constants/app_language_translations.dart';
import 'package:ecomikdeliveryapp/utils/extensions/string.dart';
import 'package:ecomikdeliveryapp/widgets/core_widgets.dart';
import 'package:ecomikdeliveryapp/widgets/screen_widgets/chat_deliveryman_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChatSupportScreen extends StatelessWidget {
  const ChatSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Bottom padding value, which is the parts of the display that are
    /// completely obscured by device's keyboard.
    final bottomInsetPaddingValue = MediaQuery.of(context).viewInsets.bottom;
    return GetBuilder<SupportChatScreenController>(
        init: SupportChatScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                extendBody: true,
                /* <-------- Appbar --------> */
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context,
                    titleWidget: Text(AppLanguageTranslation
                        .supportTicketTransKey.toCurrentLanguage)),
                /* <-------- Content --------> */
                body: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppGaps.screenPaddingValue),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      /* <---- Chat background image ----> */
                      image: DecorationImage(
                          alignment: Alignment.bottomCenter,
                          fit: BoxFit.scaleDown,
                          image: Image.asset(
                                  AppAssetImages
                                      .chatWithDeliveryManIllustration,
                                  width: 275)
                              .image)),
                  child: SafeArea(
                    bottom: true,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top extra spaces

                        AppGaps.hGap10,
                        /* <---- Chat with deliveryman ----> */
                        Expanded(
                            child: ListView.separated(
                          padding: const EdgeInsets.only(top: 17, bottom: 30),
                          separatorBuilder: (context, index) => AppGaps.hGap24,
                          itemCount: FakeData.deliveryManChats.length,
                          itemBuilder: (context, index) {
                            /// Per chat message data
                            final FakeChatMessageModel deliveryManChatMessage =
                                FakeData.deliveryManChats[index];
                            return ChatDeliveryManScreenWidgets
                                .getCustomDeliveryChatWidget(
                                    dateTime: deliveryManChatMessage.dateTime,
                                    isMyMessage:
                                        deliveryManChatMessage.isMyMessage,
                                    message: deliveryManChatMessage.message);
                          },
                        )),
                      ],
                    ),
                  ),
                ),
                /* <-------- Bottom bar --------> */
                bottomNavigationBar: Padding(
                  padding: AppGaps.bottomNavBarPadding.copyWith(
                      bottom: AppGaps.minimumBottomPaddingValue +
                          bottomInsetPaddingValue),
                  /* <---- Chat message text field ----> */
                  child: CustomTextFormField(
                    hintText: AppLanguageTranslation
                        .writeMessageTransKey.toCurrentLanguage,
                    prefixIcon: const SizedBox.shrink(),
                    suffixIconConstraints: const BoxConstraints(maxHeight: 48),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /* <---- Attachment icon button ----> */
                        CustomIconButtonWidget(
                          child: SvgPicture.asset(
                            AppAssetImages.attachmentSVGLogoLine,
                            height: 24,
                            width: 24,
                            color: AppColors.bodyTextColor,
                          ),
                          onTap: () {},
                        ),
                        AppGaps.wGap8,
                        /* <---- Camera icon button ----> */
                        CustomIconButtonWidget(
                          child: SvgPicture.asset(
                            AppAssetImages.cameraSVGLogoSolid,
                            height: 24,
                            width: 24,
                            color: AppColors.bodyTextColor,
                          ),
                          onTap: () {},
                        ),
                        AppGaps.wGap8,
                        /* <---- Send icon button ----> */
                        CustomIconButtonWidget(
                          backgroundColor: AppColors.primaryColor,
                          hasShadow: true,
                          child: Transform.scale(
                            scaleX: -1,
                            child: SvgPicture.asset(
                              AppAssetImages.arrowLeftSVGLogoLine,
                              color: Colors.white,
                              height: 16,
                              width: 16,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
