import "package:flutter/material.dart";
// import "package:flutter_first_app/extensions/theme_colors_extension.dart";

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final bool appBar;
  final bool showBack;
  final VoidCallback? onBack;
  // Default Scaffold
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const AppScaffold({
    super.key,
    required this.body,
    required this.title,
    this.appBar = true,
    this.showBack = false,
    this.onBack,
    // Default Scaffold
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      // backgroundColor: context.colors.background,
      appBar: appBar ? AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: showBack
        //     ? IconButton(
        //         icon: const Icon(Icons.arrow_back),
        //         onPressed: onBack ?? () => Navigator.pop(context),
        //       )
        //     : null,
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ) : null,
      body: SingleChildScrollView(child: body),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
