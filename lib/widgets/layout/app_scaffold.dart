import "package:flutter/material.dart";

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final bool appBar;
  final bool showBack;
  final VoidCallback? onBack;
  // SafeArea
  final bool safeArea;
  final bool scroll;
  // AppBar
  final Color? appBarBackgroundColor;
  final Color? appBarSurfaceTintColor;
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
    // SafeArea
    this.safeArea = true,
    this.scroll = true,
    // AppBar
    this.appBarBackgroundColor,
    this.appBarSurfaceTintColor,
    // Default Scaffold
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context) {

    Widget resolvedChild;
    if (safeArea && scroll) {
      resolvedChild = SafeArea(child: ListView(children: [body]));
    } else if (safeArea) {
      resolvedChild = SafeArea(child: body);
    } else if (scroll) {
      resolvedChild = ListView(children: [body]);
    } else {
      resolvedChild = body;
    }

    return Scaffold(
      // backgroundColor: context.colors.background,
      appBar: appBar ? AppBar(
        // leading: showBack
        //     ? IconButton(
        //         icon: const Icon(Icons.arrow_back),
        //         onPressed: onBack ?? () => Navigator.pop(context),
        //       )
        //     : null,
        leading: Image.asset("assets/images/easywatchlist-logo-black.png", width: 8, height: 8),
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ) : null,
      body: resolvedChild,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
