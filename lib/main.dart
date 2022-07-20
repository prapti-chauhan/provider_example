import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/theme_provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue),
          home: const MainScaffold(),
        ),
      ),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({Key? key}) : super(key: key);

  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _ThemedAppBar(
        title: const Text('Provider example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.colorize),
            onPressed: () => _showColorPicker(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) => Text(
                  'Text',
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                    color: themeProvider.mainColor,
                  ),
                ),
              ),
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) => Text(
                  'A B C D E F G H I J K L M N O P Q R S T U V W X Y Z',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: themeProvider.mainColor,fontSize: 15.5
                  ),
                ),
              ),
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) => Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: themeProvider.mainColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  void _showColorPicker(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titlePadding: const EdgeInsets.all(0),
        contentPadding: const EdgeInsets.all(0),
        content: Wrap(
          children: [
            ColorPicker(
              onColorChanged: (color) => themeProvider.changeThemeColor(color),
              pickerColor: themeProvider.mainColor,
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          )
        ],
      ),
    );
  }
}

class _ThemedAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  @override
  final Size preferredSize;

  _ThemedAppBar({
    Key? key,
    this.title,
    this.actions,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => AppBar(
        title: title,
        actions: actions,
        backgroundColor: themeProvider.mainColor,
      ),
    );
  }
}
