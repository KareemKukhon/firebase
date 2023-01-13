import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();
  static AppRouter appRouter = AppRouter._();
  GlobalKey<NavigatorState> navkey = GlobalKey<NavigatorState>();

  showCustomDialoug(String title, String content) {
    showDialog(
        context: navkey.currentContext!,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () {
                    navkey.currentState!.pop();
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }

  showLoadingDialoug() {
    showDialog(
      barrierDismissible: false,
      context: navkey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Row(
            children: [
              CircularProgressIndicator(),
              Container(
                  margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
            ],
          ),
        );
      },
    );
  }

  hideDialog() {
    navkey.currentState!.pop();
  }

  NavigateToWidget(Widget widget) {
    Navigator.of(navkey.currentContext!).push(MaterialPageRoute(
      builder: (context) {
        return widget;
      },
    ));
  }

  NavigateWithReplacmentToWidget(Widget widget) {
    Navigator.of(navkey.currentContext!).pushReplacement(MaterialPageRoute(
      builder: (context) {
        return widget;
      },
    ));
  }

  goToWidgetAndReplace(Widget widget) {
    navkey.currentState!.pushReplacement(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  goToWidget(Widget widget) {
    navkey.currentState!.push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
}
