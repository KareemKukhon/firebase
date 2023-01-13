// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../router/router.dart';
// import '../../providers/admin_provider.dart';
// import '../components/slider_widget.dart';
// import 'add_new_slider.dart';

// class AllSliderScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('All Sliders'),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 AppRouter.appRouter.goToWidget(AddNewSliderScreen());
//               },
//               icon: Icon(Icons.add))
//         ],
//       ),
//       body: Consumer<AdminProvider>(
//         builder: (context, provider, u) {
//           return provider.allSliders == null
//               ? Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : provider.allSliders!.isEmpty
//                   ? Center(
//                       child: Text('No Sliders Found'),
//                     )
//                   : ListView.builder(
//                       itemCount: provider.allSliders!.length,
//                       itemBuilder: (context, index) {
//                         return SliderWidget(provider.allSliders![index]);
//                       });
//         },
//       ),
//     );
//   }
// }
