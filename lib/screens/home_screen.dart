import "package:flutter/material.dart";
import "package:flutter_first_app/styles/app_icons.dart" show AppIcons;
// import "package:flutter_first_app/theme/app_colors.dart" show AppColors;
import "package:flutter_first_app/widgets/layout/overlay/app_overlay.dart";
import "package:flutter_first_app/widgets/ui/app_icon.dart" show AppIcon;
import "package:material_symbols_icons/symbols.dart" show Symbols;
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter/services.dart" show SystemNavigator;

// Colors & Others
import "package:flutter_first_app/styles/app_metrics.dart" show AppMetrics;

// Theme
import "package:flutter_first_app/controllers/theme_controller.dart" show ThemeController;
import "package:flutter_first_app/widgets/flutter-widgets-adaptations/tab_bar_tab.dart" show TabBarTab;

// Localization
import "package:flutter_first_app/extensions/localization_extension.dart" show L10nBuildContext;
import "package:flutter_first_app/controllers/lang_controller.dart" show LangController;

// Widget's
import "package:flutter_first_app/widgets/layout/app_scaffold.dart" show AppScaffold;
import "package:flutter_first_app/widgets/layout/app_container.dart" show AppContainer;
// import "package:flutter_first_app/widgets/layout/bottomsheets/bottom_sheet_container.dart" show BottomSheetContainer;
import "package:flutter_first_app/widgets/app/displayModeManager/_.dart" show DisplayModePresets, DisplayModeManagerSegmented, DisplayModeManagerBottomsheet;
import "package:flutter_first_app/widgets/ui/preferences/theme/theme_manager.dart" show ThemeManager;
import "package:flutter_first_app/widgets/ui/preferences/lang/lang_manager.dart" show LangManager;

// Navigation
import "package:flutter_first_app/controllers/auth_controller.dart" show AuthController;
import "package:flutter_first_app/screens/login_screen.dart" show LoginScreen;

// MaterialApp
// - “container global” do app
// - define tema, rotas, home, etc.

// StatelessWidget vs StatefulWidget

// StatelessWidget
// - não guarda estado interno
// - só desenha UI com base em dados externos

// Ex:
// - layout fixo
// - app root
// - telas simples

// page

// | Parte          | Função                |
// | -------------- | --------------------- |
// | StatefulWidget | configuração imutável |
// | State          | dados mutáveis        |

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  // const
  // - otimização de performance
  // - indica widget imutável

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

// test

enum ViewMode { list, grid }

enum AppHomeTab { home, tests, notifications, settings }

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AppHomeTab initialHomeTab = AppHomeTab.home;
  int _currentScreenIndex = 0;

  final ScrollController _mainScreenController = ScrollController();
  late final TabController homeTabController;

  ViewMode _viewMode = ViewMode.list;

  // Kept as a single State field (not recreated every build) so open/close
  // always agree on which instance is currently showing.
  OverlayEntry? _testOverlayEntry;

  void _openTestOverlay(BuildContext context) {
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) {
        return AppOverlay(
          safeArea: true,
          centralize: false,
          overlayEntry: entry,
          onDismiss: _closeTestOverlay,
          // ===== Scaffold E.g.
          // body: AppScaffold(
          //   body: Row(
          //     mainAxisAlignment: .start,
          //     crossAxisAlignment: .start,
          //     children: [
          //       IconButton(onPressed: () => screenOverlayContentTest1.remove(), icon: Icon(Symbols.close_rounded)),
          //       const Text("Meu conteúdo"),
          //     ],
          //   )
          // )
          // ===== Container E.g.
          body: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text("Meu conteúdo"),
          ),
        );
      },
    );

    _testOverlayEntry = entry;
    Overlay.of(context).insert(entry);
  }

  void _closeTestOverlay() {
    _testOverlayEntry?.remove();
    _testOverlayEntry = null;
  }

  Future<bool> _shouldLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Sair da conta?"),
        content: const Text("Deseja realmente sair?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text("Sair"),
          ),
        ],
      ),
    );
    return shouldLogout ?? false;
  }

  Future<void> _logout(BuildContext context) async {
    final allow = await _shouldLogout();
    
    if (!allow) return;
    
    AuthController.instance.logout();
    
    if (!context.mounted) return;

    Navigator.of(context).pushReplacement(MaterialPageRoute( builder: (_) => const LoginScreen()));
  }

  /// Home is the stack's root once Login/Splash got replaced away (see
  /// SplashScreen/LoginScreen), so there's nothing left to pop — the
  /// hardware/gesture back button would otherwise close the app instantly.
  /// `PopScope` intercepts that and asks for confirmation instead.
  Future<void> _confirmExit(BuildContext context) async {

    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Sair do app?"),
        content: const Text("Deseja realmente sair?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text("Sair"),
          ),
        ],
      ),
    );

    if (shouldExit == true) {
      SystemNavigator.pop();
    }

  }

  void callDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        // icon: Icon(Symbols.warning_rounded, size: 64),
        title: Text("Alerta!"),
        semanticLabel: "Teste",
        scrollable: true,
        content: const Text('Example Dialog'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    ).whenComplete(() {
      debugPrint("Modal dismissed");
    });
  }

  void callBottomSheet(BuildContext context) async {
    showModalBottomSheet<void>(
      context: context,
      elevation: 0,
      // builder: (_) => BottomSheetContainer(
      //   title: "Title",
      //   description: "Desc",
      //   child: Text("TEXTOOOOO")
      // )
      builder: (_) => Container(
        height: 250,
        color: Colors.grey,
        child: const Center(child: Text("Modal Scrollable BottomSheet")),
      ),
    ).whenComplete(() {
      debugPrint("Bottom sheet dismissed");
    });
  }

  void callScrollableBottomSheet(BuildContext context) async {
    showModalBottomSheet<void>(
      context: context,
      elevation: 0,
      builder: (_) => Container(
        height: 400,
        color: Colors.grey,
        child: ListView.builder(
          itemCount: 25,
          itemBuilder: (context, index) {
            return ListTile(title: Text("Item $index"));
          },
        ),
      ),
    );
  }

  void callFullScreenBottomSheet(BuildContext context) async {
    showModalBottomSheet<void>(
      context: context,
      elevation: 0,
      isScrollControlled: true,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 1.0,
        maxChildSize: 1.0,
        minChildSize: 0.5,
        builder: (_, fullscreenBottomsheetScroller) => Container(
          color: Colors.grey,
          child: Text("Asd"),
          // ListView.builder(
          //   controller: fullscreenBottomsheetScroller,
          //   itemCount: 50,
          //   itemBuilder: (context, index) {
          //     return ListTile(
          //       title: Text("Item $index"),
          //     );
          //   }
          // )
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    debugPrint(">>>> Init");
    _currentScreenIndex = initialHomeTab.index;
    _viewMode = ViewMode.list;

    homeTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    homeTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    final screenListenable =   Listenable.merge([
      ThemeController.instance,
      LangController.instance,
    ]);

    // Home Screen

    Widget homeScreenTabsHeader = ListenableBuilder(
      listenable: homeTabController,
      builder: (context, _) {
        return Row(
          children: [
            // Main Items
            Expanded(
              child: Align(
                alignment: .centerLeft,
                child: TabBar(
                  controller: homeTabController,

                  indicatorPadding: EdgeInsetsGeometry.symmetric(
                    horizontal: 12,
                  ),

                  padding: EdgeInsetsGeometry.only(
                    top: 0,
                    bottom: 0,
                    left: AppMetrics.small,
                    right: AppMetrics.small,
                  ),

                  isScrollable: true,
                  tabAlignment: TabAlignment.start,

                  tabs: [
                    TabBarTab(text: "Início"),
                    TabBarTab(text: "Discovery"),
                    TabBarTab(
                      child: Row(
                        crossAxisAlignment: .center,
                        mainAxisAlignment: .center,
                        children: [
                          Text(
                            "For You",
                            style: context.appTheme.textStyles.label,
                          ),
                          if (homeTabController.index == 2) ...[
                            Icon(
                              Symbols.keyboard_arrow_down_rounded,
                              size: 20,
                              fill: 1,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Separated
            IconButton(
              icon: Icon(Symbols.add_rounded, size: 24, fill: 1),
              onPressed: () => homeTabController.index = 0,
            ),
          ],
        );
      },
    );

    Widget homeScreenTabsBody = TabBarView(
      controller: homeTabController,
      children: [
        ListView(
          controller: _mainScreenController,
          children: [
            Expanded(child: Container(color: Colors.red, child: Column(crossAxisAlignment: .end, children: [
              Text("PaddingExclude is ON"),
              Text("Try to Scroll!"),
              ...List.generate(
                50,
                (index) => Text(
                  "$index Lorem ipsum dolor sit amet consectetur adipisicing elit.",
                ),
              ),
            ])))
          ],
        ),
        Container(color: Colors.green, child: Icon(Symbols.directions_transit)),
        Container(color: Colors.yellow, child: Icon(Symbols.directions_bike)),
      ],
    );

    // Test Screen
    Widget testScreen = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppMetrics.small,
      children: [
        Row(
          children: [
            Text('Widget "Icon", using "Icons."'),
            Icon(Icons.add_rounded),
          ],
        ),

        Row(
          children: [
            Text('Widget "Icon", using "Symbols."'),
            Icon(Symbols.add_rounded, size: 32),
          ],
        ),

        Row(
          children: [
            Text('Widget "Icon", using "AppIcons."'),
            Icon(AppIcons.add),
          ],
        ),

        Row(
          children: [
            Text('Widget "AppIcon", using "Icons."'),
            AppIcon(Icons.add_rounded),
          ],
        ),

        Row(
          children: [
            Text('Widget "AppIcon", using "Symbols."'),
            AppIcon(Symbols.add_rounded, size: 32),
          ],
        ),

        Row(
          children: [
            Text('Widget "AppIcon", using "AppIcons."'),
            AppIcon(AppIcons.add),
          ],
        ),

        Divider(),

        // Ungrouped key, used directly from the generated class.
        Text(l10n.raw.hello),

        // Namespaced access: "common*" and "pageHome*" arb keys regrouped by i18n.dart.
        Text(l10n.common.confirm),
        Text(l10n.pageHome.welcome),

        // Placeholder (interpolated) string.
        Text(l10n.raw.welcomeWithName("Ana", "Silva")),

        // ICU plural string.
        Text(l10n.raw.newMessages(0)),
        Text(l10n.raw.newMessages(1)),
        Text(l10n.raw.newMessages(5)),

        // Language switcher (in-session only, no persistence yet — mirrors ThemeManager).
        LangManager(showFlagOnList: true, showFlagOnLabel: true),

        Divider(),

        Row(
          spacing: 4,
          children: [
            LangManager(
              showFlagOnList: true,
              showFlagOnLabel: true,
              displayLayout: .icon,
            ),
            ThemeManager(displayLayout: .icon),
          ],
        ),

        Divider(),

        Text("screenWidth: $screenWidth"),
        Text("screenHeight: $screenHeight"),

        Divider(),

        ElevatedButton(
          onPressed: () => callBottomSheet(context),
          child: Text("Chamar Modal BottomSheet"),
        ),
        ElevatedButton(
          onPressed: () => callScrollableBottomSheet(context),
          child: Text("Chamar Scrollable Modal BottomSheet"),
        ),
        ElevatedButton(
          onPressed: () => callFullScreenBottomSheet(context),
          child: Text("Chamar FullScreen BottomSheet"),
        ),

        ElevatedButton(
          onPressed: () => callDialog(context),
          child: Text("Chamar Dialog"),
        ),

        ElevatedButton(
          onPressed: () => _openTestOverlay(context),
          child: Text("Chamar Modal (Overlay in Flutter)"),
        ),

        Divider(),

        Container(width: 44, height: 44, color: Color(0xFF3B5BDB)),
        Container(width: 44, height: 44, color: Color(0xFF4C6EF5)),
        Container(width: 44, height: 44, color: Color(0xFF748FFC)),

        Container(
          width: 320,
          height: 64,
          color: context.appTheme.colors.backgroundSecondary,
          child: Text("Card Text"),
        ),
        Container(
          width: 320,
          height: 64,
          color: context.appTheme.colors.backgroundSecondaryInverted,
          child: Text(
            "Card Text",
            style: context.appTheme.textStyles.body.copyWith(
              color: context.appTheme.colors.textInverted,
            ),
          ),
        ),

        Divider(),

        DisplayModeManagerSegmented<ViewMode>(
          selected: _viewMode,
          onChanged: (value) {
            setState(() {
              _viewMode = value;
            });
          },
          options: DisplayModePresets.fallback(
            square: ViewMode.list,
            circle: ViewMode.grid,
          ),
        ),

        DisplayModeManagerSegmented<ViewMode>(
          selected: _viewMode,
          onChanged: (value) {
            setState(() {
              _viewMode = value;
            });
          },
          options: DisplayModePresets.list(
            compact: ViewMode.list,
            wide: ViewMode.grid,
          ),
        ),

        DisplayModeManagerSegmented<ViewMode>(
          selected: _viewMode,
          onChanged: (value) {
            setState(() {
              _viewMode = value;
            });
          },
          options: DisplayModePresets.grid(
            compact: ViewMode.list,
            wide: ViewMode.grid,
          ),
        ),

        DisplayModeManagerSegmented<ViewMode>(
          selected: _viewMode,
          onChanged: (value) {
            setState(() {
              _viewMode = value;
            });
          },
          options: DisplayModePresets.listGrid(
            list: ViewMode.list,
            grid: ViewMode.grid,
          ),
        ),

        DisplayModeManagerSegmented<ViewMode>(
          selected: _viewMode,
          onChanged: (value) {
            setState(() {
              _viewMode = value;
            });
          },
          options: DisplayModePresets.allListGrid(
            listCompact: ViewMode.list,
            listWide: ViewMode.grid,
            gridCompact: ViewMode.list,
            gridWide: ViewMode.grid,
          ),
        ),

        Divider(),

        DisplayModeManagerBottomsheet<ViewMode>(
          selected: _viewMode,
          onChanged: (value) {
            setState(() {
              _viewMode = value;
            });
          },
          options: DisplayModePresets.listGrid(
            list: ViewMode.list,
            grid: ViewMode.grid,
          ),
          showSelectedLabel: false,
          showIndicator: false,
          indicatorPosition: .end,
        ),

        DisplayModeManagerBottomsheet<ViewMode>(
          selected: _viewMode,
          onChanged: (value) {
            setState(() {
              _viewMode = value;
            });
          },
          options: DisplayModePresets.allListGrid(
            listCompact: ViewMode.list,
            listWide: ViewMode.grid,
            gridCompact: ViewMode.list,
            gridWide: ViewMode.grid,
          ),
          showSelectedLabel: true,
          showIndicator: true,
        ),

        Divider(),

        ThemeManager(optionsLayout: .list),
        ThemeManager(optionsLayout: .segmented),

        Divider(),

        Text(
          'Sem style explícito (herda DefaultTextStyle + tema) →'
          'size=${Theme.of(context).textTheme.displayMedium?.fontSize}, '
          'font=${Theme.of(context).textTheme.displayMedium?.fontFamily}'
          'backgroundColor=${Theme.of(context).textTheme.displayMedium?.backgroundColor}'
          'background=${Theme.of(context).textTheme.displayMedium?.background}',
        ),
        Text("Display", style: context.appTheme.textStyles.display),
        Text("H1", style: context.appTheme.textStyles.h1),
        Text("H2", style: context.appTheme.textStyles.h2),
        Text("H3", style: context.appTheme.textStyles.h3),
        Text("Body", style: context.appTheme.textStyles.body),
        Text("Caption", style: context.appTheme.textStyles.caption),
        Text("Micro", style: context.appTheme.textStyles.micro),
        Text("Label", style: context.appTheme.textStyles.label),
        Text("Button Text", style: context.appTheme.textStyles.buttonText),
        Text("Button Small Text", style: context.appTheme.textStyles.buttonSmallText),
        Text("Body (Bold)", style: context.appTheme.textStyles.body.copyWith(fontWeight: FontWeight.bold)),
        Text("Body (Italic)", style: context.appTheme.textStyles.body.copyWith(fontStyle: FontStyle.italic)),
        Text("Cor direta do token", style: TextStyle(color: context.appTheme.colors.primary)),
        Divider(),
        Text(
          'See the props (it also works for: `context.appTheme.textStyles`):'
          'bodySmall -> '
          'size=${Theme.of(context).textTheme.bodySmall?.fontSize}, '
          'font=${Theme.of(context).textTheme.bodySmall?.fontFamily}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          'Highlighted Text',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            background: Paint()
              ..color = Colors.blue
              ..strokeWidth = 2.0
              ..style = PaintingStyle.stroke
              ..strokeJoin = StrokeJoin.round,
          ),
        ),
        // Divider(),
        // Column(
        //   spacing: 4,
        //   children: [
        //     Row(
        //       spacing: 8,
        //       children: [
        //         Expanded(child: ElevatedButton(
        //           onPressed: () {},
        //           child: const Text("Clique 1"),
        //         )),
        //       ]
        //     ),
        //     Row(
        //       spacing: 8,
        //       children: [
        //         Expanded(child: TextButton(
        //           onPressed: () {},
        //           child: const Text("Clique 2"),
        //         )),
        //         Expanded(child: OutlinedButton(
        //           onPressed: () {},
        //           child: const Text("Clique 3"),
        //         )),
        //       ]
        //     )
        //   ]
        // ),
        // Divider(),
        // Image.network(
        //   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkcTTTVv5agc4-0CfIq1mWbt6NxUox3HiD7Q&s",
        //   loadingBuilder: (context, child, progress) {
        //     return progress == null ? child : LinearProgressIndicator();
        //   },
        //   width: 200,
        //   height: 200,
        //   semanticLabel: "White Owl",
        // ),
      ],
    );

    // Bottom Navigation Bar
    Widget bottomNavigationBar = NavigationBar(
      labelBehavior: .alwaysShow,
      animationDuration: Duration(milliseconds: 2000),
      onDestinationSelected: (int index) {
        debugPrint("Change to page: $index");

        setState(() {
          if (true) {
            _currentScreenIndex = index;
          }
        });

        if (true) {
          _mainScreenController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }

        // switch (index) {
        //   case 3:
        //     callDialog(context);
        // }

      },
      selectedIndex: _currentScreenIndex,
      destinations: <Widget>[
        NavigationDestination(
          selectedIcon: Icon(
            Symbols.home_rounded,
            color: context.appTheme.colors.primary,
            fill: 1,
          ),
          icon: Icon(
            Symbols.home_rounded,
            color: context.appTheme.colors.primary,
            fill: 0,
          ),
          label: "Home",
          tooltip: "",
        ),
        NavigationDestination(
          selectedIcon: Badge(
            offset: Offset(16, -4),
            label: Text("2"),
            // isLabelVisible: _currentScreenIndex != 1,
            child: Icon(
              Symbols.concierge_rounded,
              color: context.appTheme.colors.primary,
              fill: 1,
            ),
          ),
          icon: Badge(
            offset: Offset(16, -4),
            label: Text("2"),
            // isLabelVisible: _currentScreenIndex != 1,
            child: Icon(
              Symbols.concierge_rounded,
              color: context.appTheme.colors.primary,
              fill: 0,
            ),
          ),
          label: "UI Tests",
          tooltip: "",
        ),
        NavigationDestination(
          selectedIcon: Badge(
            isLabelVisible: false,
            child: Icon(
              Symbols.notifications_rounded,
              color: context.appTheme.colors.primary,
              fill: 1,
            ),
          ),
          icon: Badge(
            isLabelVisible: true,
            backgroundColor: Color(0xFFFF0000),
            child: Icon(
              Symbols.notifications_rounded,
              color: context.appTheme.colors.primary,
              fill: 0,
            ),
          ),
          label: "Notifications",
          tooltip: "",
        ),
        NavigationDestination(
          selectedIcon: Icon(
            Symbols.settings_rounded,
            color: context.appTheme.colors.primary,
            fill: 1,
          ),
          icon: Icon(
            Symbols.settings_rounded,
            color: context.appTheme.colors.primary,
            fill: 0,
          ),
          label: "Settings",
          tooltip: "",
        ),
      ],
    );

    List<Widget> bottomNavigationBarTabs = [
      Column(
        spacing: AppMetrics.extraSmall,
        children: [
          homeScreenTabsHeader,
          Expanded(
            child: AppContainer(
              autoPadding: true,
              paddingExclude: [.top, .left],
              content: homeScreenTabsBody,
            ),
          ),
        ],
      ),
      ListView(
        controller: _mainScreenController,
        children: [AppContainer(autoPadding: true, content: testScreen)],
      ),
      Column(children: [Text("Notifications")]),
      Column(
        spacing: AppMetrics.base,
        children: [
          Text("Settings"),
          ElevatedButton(
            onPressed: () => _logout(context),
            child: const Text("Logout"),
          ),
        ],
      ),
    ];

    return PopScope(
      // `false` = never let the system pop Home off the stack by itself;
      // `onPopInvokedWithResult` decides what happens instead (see
      // `_confirmExit` and lib/navigation/README_NAVIGATION.md).
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        // `canPop: false` means this callback is the ONLY thing that runs
        // on a back attempt — nothing else (LocalHistoryEntry included)
        // gets a chance to react first. So if something else on screen
        // should consume "back" instead of the exit prompt, it has to be
        // checked here.
        if (_testOverlayEntry != null) {
          _closeTestOverlay();
          return;
        }

        _confirmExit(context);
      },
      // Required to react to the ThemeController
      // return AnimatedBuilder(
      //   animation: ThemeController.instance,
      //   builder: (context, _) {
      child: ListenableBuilder(
        listenable: screenListenable,
        builder: (context, _) {
          return AppScaffold(
            appBar: .header,
            appBarActions: [
              IconButton(
                onPressed: () => debugPrint("AAAAA"),
                icon: Icon(Symbols.lab_research),
              ),
            ],
            appBarLeading: [
              IconButton(
                onPressed: () => debugPrint("AAAAA"),
                icon: Icon(Symbols.lab_research),
              ),
            ],
            appBarTitle: widget.title,
            appBarLogo: true,
            // Menu
            // sideMenu: true,
            sideMenuTitle: "Meu Title!",
            sideMenuOrigin: .right,
            sideMenuAnchor: .origin,
            // Bottom Navigation
            bottomNavigationBar: bottomNavigationBar,
            // Body
            body: bottomNavigationBarTabs[_currentScreenIndex],
            // Floating Button
            floatingActionButton: _currentScreenIndex == 0
                ? FloatingActionButton(
                    onPressed: () {},
                    tooltip: "Increment",
                    child: const Icon(Symbols.add_rounded),
                  )
                : null,
          );
        },
      ),
    );
  }
}
