import 'package:emoraa/components/status_pages.dart';
import 'package:flutter/material.dart';

class HeaderStatusPage extends StatelessWidget {
  const HeaderStatusPage(
      {Key? key, required this.textTitle, required this.showMore, required this.textButton})
      : super(key: key);
  final String textTitle;
  final String textButton;
  final Function() showMore;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical:5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: <Widget>[
            StatusPages(
              textTitle: textTitle,
            ),
            const Spacer(),
            TextButton(
              onPressed: showMore,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 54, 152, 244)),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
              ),
              child: Text(textButton),
            )
          ],
        ),
      ),
    );
  }
}

