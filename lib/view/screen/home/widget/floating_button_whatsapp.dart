import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

Widget? whatsappFloatingButtonWidget(context) {
  
  final String? phone = '${Provider.of<SplashProvider>(context, listen: false).configModel?.companyPhone?.replaceAll("+", '').replaceAll(RegExp(r'[^\d+]'), '').trim()}';
  //'+01289603131';//'${Provider.of<SplashProvider>(context, listen: false).configModel?.companyPhone?.replaceAll("+", '')}';

  if (phone?.isEmpty ?? true) return null;

  return FloatingActionButton(
    onPressed: () async {
      final Uri whatsappUrl = Uri.parse("https://wa.me/$phone");

      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content:Text(getTranslated('cannot_open_whatsapp', context)!)),
        );
      }
    },
    backgroundColor: const Color(0xff289811),
    child: Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      child: Image.asset(Images.whatsapp),
    ),
  );
}
