import 'package:tiranga/model/colorPredictionResult_provider.dart';
import 'package:tiranga/res/app_constant.dart';
import 'package:tiranga/res/provider/TermsConditionProvider.dart';
import 'package:tiranga/res/provider/aboutus_provider.dart';
import 'package:tiranga/res/provider/addacount_controller.dart';
import 'package:tiranga/res/provider/auth_provider.dart';
import 'package:tiranga/res/provider/betColorPrediction_provider.dart';
import 'package:tiranga/res/provider/betcolorpredictionTRX.dart';
import 'package:tiranga/res/provider/common_api.dart';
import 'package:tiranga/res/provider/contactus_provider.dart';
import 'package:tiranga/res/provider/feedback_provider.dart';
import 'package:tiranga/res/provider/giftcode_provider.dart';
import 'package:tiranga/res/provider/plinko_bet_provider.dart';
import 'package:tiranga/res/provider/privacypolicy_provider.dart';
import 'package:tiranga/res/provider/profile_provider.dart';
import 'package:tiranga/res/provider/slider_provider.dart';
import 'package:tiranga/res/provider/user_view_provider.dart';
import 'package:tiranga/utils/routes/routes.dart';
import 'package:tiranga/utils/routes/routes_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tiranga/view/home/mini/Aviator/AviatorProvider.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  runApp(const MyApp());

}

double height = 0.0;
double width = 0.0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width > 500 ? 500 : MediaQuery.of(context).size.width;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserAuthProvider()),
        ChangeNotifierProvider(create: (context) => AviatorWallet()),
        ChangeNotifierProvider(create: (context) => UserViewProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => SliderProvider()),
        ChangeNotifierProvider(create: (context) => AboutusProvider()),
        ChangeNotifierProvider(create: (context) => AddacountProvider()),
        ChangeNotifierProvider(create: (context) => GiftcardProvider()),
        ChangeNotifierProvider(create: (context) => ColorPredictionProvider()),
        ChangeNotifierProvider(create: (context) => BetColorResultProvider()),
        ChangeNotifierProvider(create: (context) => FeedbackProvider()),
        ChangeNotifierProvider(create: (context) => TermsConditionProvider()),
        ChangeNotifierProvider(create: (context) => PrivacyPolicyProvider()),
        ChangeNotifierProvider(create: (context) => ContactUsProvider()),
        ChangeNotifierProvider(create: (context) => BetColorResultProviderTRX()),
        ChangeNotifierProvider(create: (context) => PlinkoBetHistoryProvider()),
        ChangeNotifierProvider(create: (context) => MyModel()),
      ],
      child: Builder(
        builder: (context) {
          if (kIsWeb) {
            width = MediaQuery.of(context).size.width > 500
                ? 500
                : MediaQuery.of(context).size.width;
            return MaterialApp(
              navigatorKey: navigatorKey,
              builder: (context, child) {
                return Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: width,
                    ),
                    child: child,
                  ),
                );
              },
              title: AppConstants.appName,
              debugShowCheckedModeBanner: false,
              initialRoute: RoutesName.splashScreen,
              onGenerateRoute: (settings) {
                if (settings.name != null) {
                  return MaterialPageRoute(
                    builder: Routers.generateRoute(settings.name!),
                    settings: settings,
                  );
                }
                return null;
              },
            );
          } else {
            return MaterialApp(
              navigatorKey: navigatorKey,
              title: AppConstants.appName,
              debugShowCheckedModeBanner: false,
              initialRoute: RoutesName.splashScreen,
              onGenerateRoute: (settings) {
                if (settings.name != null) {
                  return MaterialPageRoute(
                    builder: Routers.generateRoute(settings.name!),
                    settings: settings,
                  );
                }
                return null;
              },
            );
          }
        },
      ),
    );
  }
}
