// // Context
// //
// //
// // statefull
// // Stateless
// // Provider
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class Mydemoprovider extends StatelessWidget {
//
//   //
//   @override
//   Widget build(BuildContext context) {
//
//     MyState mm =Provider.of<MyState>(context);
//     return Scaffold(
//       body: ChangeNotifierProvider(
//         create: (context) => MyState(),
//         child: Consumer<MyState>(
//           builder: (context, value, child) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("${value.cnt}"),
//                 IconButton(onPressed: () {
//
//                   value.myincremtn();
//                 }, icon: Icon(Icons.add))
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class MyState extends ChangeNotifier {
//   // obs = OBx
//   int cnt = 0;
//
//   myincremtn() {
//     cnt++;
//     notifyListeners();
//   }
// }
