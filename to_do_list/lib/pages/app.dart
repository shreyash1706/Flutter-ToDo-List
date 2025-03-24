import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/logic/streak_logic.dart';
import 'package:to_do_list/pages/home.dart';
import 'package:to_do_list/pages/calendar.dart';
import 'package:to_do_list/pages/profile.dart';
import 'package:firebase_core/firebase_core.dart';

// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   StreakLogic streakLogic =StreakLogic();
//   await streakLogic.getCounter();
//   await streakLogic.getMaxCounter();
//   runApp(ChangeNotifierProvider(
//     create: (context) => streakLogic,
//     child: MyApp()));
// }



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex=0;
  int index=0;
  final screens= [
    home(),
    const Calendar(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(indicatorColor: Colors.blue.shade200,),
        child: NavigationBar(
          backgroundColor: const Color.fromARGB(255,18,26,38),
          height: mediaQuery.height*0.09,
          selectedIndex: index,
          animationDuration: const Duration(seconds: 1),
          onDestinationSelected: (index)=> 
            setState(() {
              this.index=index;
            }
            ),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.list_alt_rounded,color: Colors.white,), label: 'Tasks'),
            NavigationDestination(icon: Icon(Icons.calendar_month_rounded,color: Colors.white,), label: 'Calendar'),
            NavigationDestination(icon: Icon(Icons.person_sharp,color: Colors.white,), label: 'Profile'),
      
          ],
        ),
      ),
    );
}
}
