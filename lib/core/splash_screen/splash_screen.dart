
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/text_styles.dart';
import '../../utils/router/router_variables.dart';
import 'cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SplashCubit>(context).loadSplash();
     return Scaffold(
       backgroundColor:colorBlue,
       body: BlocListener<SplashCubit,SplashState>(
         listener: (context,state){
             Navigator.pop(context);
             Navigator.pushNamed(context, dashboard);
         },
         child: body(),
       ),
     );
  }
  Widget body(){
     return   Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Center(
           child: Text("Beinex",style: extraLargeText,),
         ),
       ],
     );
  }
}