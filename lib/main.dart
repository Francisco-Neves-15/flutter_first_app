import "package:flutter/material.dart";
import "package:material_symbols_icons/symbols.dart" show Symbols;
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
// import "package:flutter/services.dart";

// Colors & Others
import "package:flutter_first_app/styles/app_metrics.dart" show AppMetrics;

// Styles
import "package:flutter_first_app/styles/app_theme.dart" show AppTheme;
import "package:flutter_first_app/styles/app_text_styles.dart" show AppTextStyles;

// Theme
import "package:flutter_first_app/controllers/theme_controller.dart" show ThemeController;
import "package:flutter_first_app/theme/app_colors_theme.dart" show appLightColors, appDarkColors;
import "package:flutter_first_app/widgets/flutter-widgets-adaptations/tab_bar_tab.dart" show TabBarTab;

// Localization
import "package:flutter_first_app/localization/generated/app_localizations.dart" show AppLocalizations;
import "package:flutter_first_app/extensions/localization_extension.dart" show L10nBuildContext;
import "package:flutter_first_app/controllers/lang_controller.dart" show LangController;
import "package:flutter_first_app/config/app_config_locales.dart" show AppAvailableLocale, AppAvailableLocaleMapping;

// Widget's
import "package:flutter_first_app/widgets/layout/app_scaffold.dart" show AppScaffold;
import "package:flutter_first_app/widgets/layout/app_container.dart" show AppContainer;
import "package:flutter_first_app/widgets/layout/bottomsheets/bottom_sheet_container.dart" show BottomSheetContainer;
import "package:flutter_first_app/widgets/ui/control/displayModeManager/_.dart" show DisplayModePresets, DisplayModeManagerSegmented, DisplayModeManagerBottomsheet;
import "package:flutter_first_app/widgets/ui/preferences/theme/theme_manager.dart" show ThemeManager;
import "package:flutter_first_app/widgets/ui/preferences/lang/lang_manager.dart" show LangManager;

void main() {
  runApp(const MyApp());
}
// - main() → ponto de 
// - runApp() → injeta a árvore de widgetentradas na tela
// - tudo no Flutter é um Widget


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ListenableBuilder(
      listenable: Listenable.merge([ThemeController.instance, LangController.instance]),

      builder: (context, _) {

        return MaterialApp(

          // Theme
          theme: AppTheme.build(appLightColors),
          darkTheme: AppTheme.build(appDarkColors),
          themeMode: ThemeController.instance.themeMode,

          // Localization
          locale: LangController.instance.locale,
          supportedLocales: AppAvailableLocale.values.map((value) => value.locale),
          localizationsDelegates: AppLocalizations.localizationsDelegates,

          // Wrapper global (como um layout provider no React).
          // Precisa ficar DENTRO do MaterialApp — fora dele o Theme ignora tudo.
          builder: (context, child) {
            return (
              DefaultTextStyle(
                style: AppTextStyles.baseText,
                textAlign: TextAlign.left,
                child: child ?? const SizedBox.shrink(),
              )
            );
          },

          home: const MyHomePage(
            title: "WatchList",
          ),

        );
      }
    );
  }
}

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

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, required this.title});
  // const
  // - otimização de performance
  // - indica widget imutável

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// test

enum ViewMode {
  list,
  grid,
}

enum AppHomeTab {
  home,
  tests,
  notifications,
  settings,
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  AppHomeTab initialHomeTab = AppHomeTab.home;
  int _currentScreenIndex = 0;

  final ScrollController _mainScreenController = ScrollController();
  late final TabController homeTabController;

  ViewMode _viewMode = ViewMode.list;

  void callDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        // icon: Icon(Symbols.warning_rounded, size: 64),
        title: Text( "Alerta!"),
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
        child: const Center(
          child: Text("Modal Scrollable BottomSheet"),
        ),
      )
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
            return ListTile(
              title: Text("Item $index"),
            );
          }
        )
      )
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
        child: Text("Asd")
        // ListView.builder(
        //   controller: fullscreenBottomsheetScroller,
        //   itemCount: 50,
        //   itemBuilder: (context, index) {
        //     return ListTile(
        //       title: Text("Item $index"),
        //     );
        //   }
        // )
      )
      )
    );
  }

  @override
  void initState() {
    super.initState();

    debugPrint(">>>> Init");
    _currentScreenIndex = initialHomeTab.index;
    _viewMode = ViewMode.list;

    homeTabController = TabController(
      length: 3,
      vsync: this,
    );

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

    // Home Screen

    Widget homeScreenTabsHeader = ListenableBuilder(
     listenable: homeTabController,
     builder: (context, _) {

        return Row(children: [
          // Main Items
          Expanded(child: Align(
            alignment: .centerLeft,
            child: TabBar(
              controller: homeTabController,

              indicatorPadding: EdgeInsetsGeometry.symmetric(horizontal: 12),

              padding: EdgeInsetsGeometry.only(
                top: 0,
                bottom: 0,
                left: AppMetrics.small,
                right: AppMetrics.small
              ),

              isScrollable: true,
              tabAlignment: TabAlignment.start,

              tabs: [
                TabBarTab(
                  text: "Início",
                ),
                TabBarTab(
                  text: "Discovery",
                ),
                TabBarTab(
                  child: Row(
                    crossAxisAlignment: .center,
                    mainAxisAlignment: .center,
                    children: [
                      Text("For You", style: context.appTheme.textStyles.label),
                      if (homeTabController.index == 2) ...[Icon(Symbols.keyboard_arrow_down_rounded, size: 20, fill: 1)]
                    ],
                  )
                )
              ],
            )
          )),
          // Separated
          IconButton(
            icon: Icon(Symbols.add_rounded, size: 24, fill: 1),
            onPressed: () => homeTabController.index = 0,
          )
          ]
        );
      }
    );

    Widget homeScreenTabsBody = TabBarView(
      controller: homeTabController,
      children: [
        ListView(
          controller: _mainScreenController,
          children: [
            Text("Lorem ipsum dolor sit amet consectetur adipisicing elit. Itaque veniam beatae inventore temporibus optio officiis, nulla nobis illum, recusandae ex accusamus molestias ipsum asperiores. Vero quasi dolores inventore nostrum ut ad laborum voluptate aliquid voluptatem, error repellat molestias minus illum consequuntur, nisi facere ab consectetur mollitia ex aliquam autem eum. Quas exercitationem et eum consequatur veritatis? Officiis, minima iste. Temporibus, harum quibusdam corrupti consequuntur eius facilis perferendis amet. Assumenda unde repellat autem officia error praesentium deleniti pariatur cupiditate nihil reiciendis id laboriosam delectus vitae, harum illo, iusto beatae aut accusantium, vel saepe eligendi similique architecto quisquam? Itaque eius enim similique distinctio eos impedit pariatur est, ullam suscipit aliquid aut totam dolorum quidem hic! Quis sequi autem est provident animi dolore ex iste! Repellat amet numquam, vero, in deserunt accusantium consequuntur odit dolor provident fugit debitis natus facilis laboriosam alias? Architecto quam nihil numquam dolorum mollitia commodi velit cumque doloremque eligendi sint aspernatur dolor, atque qui impedit? Quo amet, cupiditate mollitia quibusdam blanditiis harum reprehenderit cumque ipsum nisi ipsa commodi quisquam esse animi, dolores quam ut assumenda. Dolores iste illum commodi sapiente nulla culpa eaque dolore quidem sed quaerat, asperiores sunt, temporibus aspernatur illo fugit eius id voluptatum dicta cupiditate laboriosam similique. Iusto, dolor. Distinctio debitis molestiae nobis ipsa consequatur! Inventore aperiam culpa exercitationem et explicabo hic ipsum nulla autem dolore. Id deserunt quidem excepturi laborum vero officiis perspiciatis, ratione nostrum iure tenetur, ducimus nulla blanditiis praesentium odio modi inventore voluptatem accusantium! Laboriosam quis tempora, aspernatur, similique accusamus dolorem est sit distinctio quisquam facilis et praesentium illum possimus veritatis laborum aperiam dicta quas modi placeat? Magnam tempore culpa pariatur temporibus ab molestias dolorem expedita fugit? Ipsa cumque laboriosam hic saepe aut beatae. Alias corporis veniam magnam animi hic, nisi reiciendis officia odio aliquid id veritatis! Magnam nihil laborum neque inventore, accusantium aspernatur quam tempora veniam eveniet rem accusamus eum quaerat ut quidem illum ipsum aperiam est suscipit sit itaque! Excepturi aperiam dolorem minima laboriosam vel sed perferendis modi laudantium ratione omnis repellat, error dignissimos culpa molestias tempore ut cumque amet nisi, magnam a vero eius unde, exercitationem ea! Animi laudantium a possimus repellendus architecto blanditiis praesentium placeat sit perspiciatis deleniti incidunt, assumenda totam ipsam, delectus recusandae hic velit quas corrupti ullam ex, dicta in quisquam provident consectetur? Assumenda itaque at esse quidem eum maiores voluptatibus, odit laboriosam accusantium molestiae fugiat dolores quod earum illum id amet porro rerum nobis odio enim dolorem ad repellendus distinctio. Tenetur enim mollitia, perspiciatis numquam vel blanditiis odio quam, dolorum eum voluptatem id totam excepturi sunt quo. Reiciendis a in quidem ipsum, doloribus nesciunt accusantium soluta, sequi voluptatem aliquam natus rerum fugit eius corporis delectus. Deserunt sequi minus, ad cum reprehenderit adipisci quas excepturi nihil facere nulla veniam mollitia a velit nam! Sunt est eos incidunt sint impedit aliquam consequuntur at maiores! Quidem amet quia nihil vero quae perspiciatis quam exercitationem, optio voluptatem velit accusantium illo aspernatur eaque animi quo, assumenda, fugit ad perferendis fuga est! Velit quis, accusantium facilis libero provident quidem hic beatae? In blanditiis autem dolore similique ex odit hic non id nam asperiores amet esse, deleniti ducimus iste modi facilis officia corporis rem ullam quas expedita praesentium. Ullam possimus porro cumque aut commodi architecto facilis quo corrupti reiciendis pariatur accusamus fugiat nulla corporis explicabo, voluptatum ipsum magnam. Quibusdam quia laboriosam a dolores. At et temporibus placeat autem esse, vel culpa! Delectus error id ea, tempora eos quae et. Illum, iste repellat corrupti eius vero architecto rem culpa, iure ut laboriosam consequatur. Possimus autem iste consectetur aut quo ullam repellat commodi sapiente eaque praesentium perferendis assumenda exercitationem porro temporibus, vero accusantium rerum? Ducimus natus ut itaque harum laboriosam nesciunt eum delectus. Illo aperiam cumque consequatur nisi, minus necessitatibus dolore dolores totam, omnis, ducimus cupiditate dolor assumenda repellendus praesentium molestiae. Officiis natus facere iste, maiores autem consequuntur architecto quaerat totam praesentium impedit veniam voluptatem laudantium blanditiis aliquam eaque, nostrum molestias placeat quod commodi. Eius, adipisci! Ducimus consequatur magnam nulla debitis commodi ipsum pariatur illum deleniti error sit dolorem vitae esse quidem, eos iusto corrupti cum consequuntur cumque non nobis amet facere dolor. Voluptatibus dolor facilis, ullam magnam ut repellat quia delectus dolores consectetur laborum quam vero pariatur expedita labore natus minus voluptas nesciunt omnis nisi provident sapiente iusto sunt dolorem unde? Ducimus vel aspernatur esse iusto quam suscipit, atque magni, cupiditate sequi quis autem illo, doloribus non voluptatum. Eos fuga earum quas est suscipit aliquid consectetur voluptatum corrupti ipsum hic corporis id soluta veniam, in esse! Soluta repudiandae similique repellendus voluptates molestiae laborum aliquam, fugit possimus nostrum eum distinctio delectus iusto aperiam repellat exercitationem saepe nulla dolorem impedit ea. Illo, minima! A fugiat consequatur provident hic perspiciatis exercitationem illo. Distinctio libero, numquam tenetur impedit animi eum. Illum explicabo corporis totam minima. Inventore debitis nemo repellendus autem. Corrupti, fugit, animi dolore a facilis voluptatibus ab quibusdam earum optio praesentium quos tempora nemo accusantium quae ut exercitationem amet sint nostrum perferendis error unde iste quas repudiandae sunt! Saepe doloremque ipsam non magnam labore maiores fuga, voluptates odio dicta ipsa sapiente atque nihil, ab nisi ad alias maxime corrupti. Alias excepturi eligendi eum debitis error ea nam ex, natus voluptatum iste, molestias doloribus! Deserunt ratione modi soluta similique accusamus quaerat asperiores, a earum, saepe architecto vitae consequuntur pariatur exercitationem, itaque sit rem voluptatum reiciendis. Repellendus voluptatum cum veritatis architecto totam ipsum, minima animi unde asperiores quam ipsam! Ullam culpa soluta, dignissimos provident odit sint libero ea itaque amet eveniet at impedit doloribus ad debitis esse. Pariatur, iure earum nulla qui eveniet sunt soluta, harum commodi at, ullam rem quae laborum cum minus reiciendis magnam adipisci necessitatibus ipsa vel nemo. Voluptatum fugiat error quasi id ullam explicabo earum excepturi accusamus autem nisi magnam nulla illo distinctio adipisci labore inventore ipsam at illum reiciendis repellat, aut itaque. Unde est molestias reiciendis dolore ex delectus voluptatibus vel enim vitae eius? Culpa animi nisi excepturi eaque libero doloremque, vel aspernatur reiciendis temporibus ducimus repellendus ratione eum harum quaerat pariatur nesciunt rerum! Fugiat provident pariatur id, eius explicabo reprehenderit corrupti quod aliquam!")
          ]
        ),
        Container(
          color: Colors.green,
          child: Icon(Symbols.directions_transit),
        ),
        Container(
          color: Colors.yellow,
          child: Icon(Symbols.directions_bike),
        ),
      ],
    );

    // Test Screen
    Widget testScreen = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppMetrics.small,
      children: [

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
            LangManager(showFlagOnList: true, showFlagOnLabel: true, displayLayout: .icon),
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

        Divider(),

        Container(width: 44, height: 44, color: Color(0xFF3B5BDB)),
        Container(width: 44, height: 44, color: Color(0xFF4C6EF5)),
        Container(width: 44, height: 44, color: Color(0xFF748FFC)),

        Container(width: 320, height: 64, color: context.appTheme.colors.backgroundSecondary, child: Text("Card Text"),),
        Container(width: 320, height: 64, color: context.appTheme.colors.backgroundSecondaryInverted, child: Text("Card Text", style: context.appTheme.textStyles.body.copyWith(color: context.appTheme.colors.textInverted)),),

        Divider(),

        DisplayModeManagerSegmented<ViewMode>(
          selected: _viewMode,
          onChanged: (value) { setState(() { _viewMode = value; }); },
          options: DisplayModePresets.fallback(square: ViewMode.list, circle: ViewMode.grid),
        ),

        DisplayModeManagerSegmented<ViewMode>(
          selected: _viewMode,
          onChanged: (value) { setState(() { _viewMode = value; }); },
          options: DisplayModePresets.list(compact: ViewMode.list, wide: ViewMode.grid),
        ),

        DisplayModeManagerSegmented<ViewMode>(
          selected: _viewMode,
          onChanged: (value) { setState(() { _viewMode = value; }); },
          options: DisplayModePresets.grid(compact: ViewMode.list, wide: ViewMode.grid),
        ),

        DisplayModeManagerSegmented<ViewMode>(
          selected: _viewMode,
          onChanged: (value) { setState(() { _viewMode = value; }); },
          options: DisplayModePresets.listGrid(list: ViewMode.list, grid: ViewMode.grid),
        ),

        DisplayModeManagerSegmented<ViewMode>(
          selected: _viewMode,
          onChanged: (value) { setState(() { _viewMode = value; }); },
          options: DisplayModePresets.allListGrid(listCompact: ViewMode.list, listWide: ViewMode.grid, gridCompact: ViewMode.list, gridWide: ViewMode.grid),
        ),

        Divider(),

        DisplayModeManagerBottomsheet<ViewMode>(
          selected: _viewMode,
          onChanged: (value) { setState(() { _viewMode = value; }); },
          options: DisplayModePresets.listGrid(list: ViewMode.list, grid: ViewMode.grid),
          showSelectedLabel: false,
          showIndicator: false,
          indicatorPosition: .end,
        ),

        DisplayModeManagerBottomsheet<ViewMode>(
          selected: _viewMode,
          onChanged: (value) { setState(() { _viewMode = value; }); },
          options: DisplayModePresets.allListGrid(listCompact: ViewMode.list, listWide: ViewMode.grid, gridCompact: ViewMode.list, gridWide: ViewMode.grid),
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
        Text(
          "Cor direta do token",
          style: TextStyle(color: context.appTheme.colors.primary),
        ),
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
          if (index != 3) {
            _currentScreenIndex = index;
          }
        });

        if (index != 3) {
          _mainScreenController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }

        switch (index) {
          case 3:
            callDialog(context);
        }

      },
      selectedIndex: _currentScreenIndex,
      destinations: <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Symbols.home_rounded, color: context.appTheme.colors.primary, fill: 1),
          icon: Icon(Symbols.home_rounded, color: context.appTheme.colors.primary, fill: 0),
          label: "Home",
          tooltip: "",
        ),
        NavigationDestination(
          selectedIcon: Badge(
            offset: Offset(16, -4),
            label: Text("2"),
            // isLabelVisible: _currentScreenIndex != 1,
            child: Icon(Symbols.concierge_rounded, color: context.appTheme.colors.primary, fill: 1),
          ),
          icon: Badge(
            offset: Offset(16, -4),
            label: Text("2"),
            // isLabelVisible: _currentScreenIndex != 1,
            child: Icon(Symbols.concierge_rounded, color: context.appTheme.colors.primary, fill: 0),
          ),
          label: "UI Tests",
          tooltip: "",
        ),
        NavigationDestination(
          selectedIcon: Badge(
            isLabelVisible: false,
            child: Icon(Symbols.notifications_rounded, color: context.appTheme.colors.primary, fill: 1),
          ),
          icon: Badge(
            isLabelVisible: true, 
            backgroundColor: Color(0xFFFF0000),
            child: Icon(Symbols.notifications_rounded, color: context.appTheme.colors.primary, fill: 0),
          ),
          label: "Notifications",
          tooltip: "",
        ),
        NavigationDestination(
          selectedIcon: Icon(Symbols.settings_rounded, color: context.appTheme.colors.primary, fill: 1),
          icon: Icon(Symbols.settings_rounded, color: context.appTheme.colors.primary, fill: 0),
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
          Expanded(child: 
            AppContainer(
              autoPadding: true,
              paddingExclude: [.top, .left],
              content: homeScreenTabsBody
            )
          )
        ]
      ),
      ListView(
        controller: _mainScreenController,
        children: [
          AppContainer(
            autoPadding: true,
            content: testScreen
          )
        ]
      ),
      Column(children: [
        Text("Notifications")
      ]),
      Column(children: [
        Text("Settings")
      ]),
    ];

    // Required to react to the ThemeController
    // return AnimatedBuilder(
    //   animation: ThemeController.instance,
    //   builder: (context, _) {
    return ListenableBuilder(
     listenable: Listenable.merge([ThemeController.instance, LangController.instance]),
     builder: (context, _) {

        return AppScaffold(
          appBar: .header,
          appBarActions: [
            IconButton(onPressed: () => debugPrint("AAAAA"), icon: Icon(Symbols.lab_research))
          ],
          appBarTitle: widget.title,
          // Menu
          menuButton: true,
          // menuButtonLocation: .actions,
          // menuButtonPosition: .end,
          // BottomNavigationBar: ,
          bottomNavigationBar: bottomNavigationBar,
          // Body
          body: bottomNavigationBarTabs[_currentScreenIndex],
          // Floating Button
          floatingActionButton: _currentScreenIndex == 0 ? FloatingActionButton(
            onPressed: () {},
            tooltip: "Increment",
            child: const Icon(Symbols.add_rounded),
          ) : null,
        );

      }
    );
  }
}

// int _counter = 0;
// void _incrementCounter() {
//   setState(() {
//     _counter++;
//   });
// }

// Scaffold(
//   appBar: AppBar(
//     backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//     title: Text(widget.title),
//   ),
//   body: Center(
//     child: Column(
//       mainAxisAlignment: .center,
//       children: [
//         const Text("You have pushed the button this many times:"),
//         Text(
//           "$_counter",
//           style: Theme.of(context).textTheme.headlineMedium,
//         ),
//       ],
//     ),
//   ),
//   floatingActionButton: FloatingActionButton(
//     onPressed: _incrementCounter,
//     tooltip: "Increment",
//     child: const Icon(Symbols.add_rounded),
//   ),
// );
