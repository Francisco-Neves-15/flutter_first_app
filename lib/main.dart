import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
// import "package:flutter/services.dart";

// Colors & Others
import "package:flutter_first_app/styles/app_metrics.dart" show AppMetrics;

// Styles
import "package:flutter_first_app/styles/app_theme.dart" show AppTheme;
import "package:flutter_first_app/styles/app_text_styles.dart" show AppTextStyles;

// Theme
import "package:flutter_first_app/theme/app_available_themes.dart" show AppAvailableThemeMode;
import "package:flutter_first_app/controllers/theme_controller.dart" show ThemeController;
import "package:flutter_first_app/styles/app_colors_theme.dart" show appLightColors, appDarkColors;

// Widget's
import "package:flutter_first_app/widgets/layout/app_scaffold.dart" show AppScaffold;
import "package:flutter_first_app/widgets/layout/app_container.dart" show AppContainer;
import "package:flutter_first_app/widgets/layout/headers/app_header.dart" show AppHeader;
import "package:flutter_first_app/widgets/ui/theme/theme_manager.dart" show ThemeManager;


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

    return AnimatedBuilder(
      animation: ThemeController.instance,

      builder: (context, _) {

        return MaterialApp(
          theme: AppTheme.build(appLightColors),
          darkTheme: AppTheme.build(appDarkColors),
          themeMode: ThemeController.instance.themeMode,

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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    // Required to react to the ThemeController

    // return AnimatedBuilder(
    //   animation: ThemeController.instance,
    //   builder: (context, _) {

    return ListenableBuilder(
     listenable: ThemeController.instance,
     builder: (context, _) {

        return AppScaffold(
            title: widget.title,
            useAppBar: false,
            body: AppContainer(
              autoPadding: true,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppMetrics.small,
                children: [
                  AppHeader(title: "Configurações"),
                  ThemeManager(),
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
                  Divider(),
                  Column(
                    spacing: 4,
                    children: [
                      Row(
                        spacing: 8, 
                        children: [
                          Expanded(child: ElevatedButton(
                            onPressed: () {},
                            child: const Text("Clique 1"),
                          )),
                        ]
                      ),
                      Row(
                        spacing: 8, 
                        children: [
                          Expanded(child: TextButton(
                            onPressed: () {},
                            child: const Text("Clique 2"),
                          )),
                          Expanded(child: OutlinedButton(
                            onPressed: () {},
                            child: const Text("Clique 3"),
                          )),
                        ]
                      )
                    ]
                  ),
                  Divider(),
                  // Text("Tema do App", style: Theme.of(context).textTheme.titleMedium),
                  // Text("mode ${ThemeController.instance.mode}", style: Theme.of(context).textTheme.titleSmall),
                  // Text("themeMode ${ThemeController.instance.themeMode}", style: Theme.of(context).textTheme.titleSmall),
                  // Text("resolvedTheme ${ThemeController.instance.resolvedTheme(context)}", style: Theme.of(context).textTheme.titleSmall),
                  // Text("> ${ThemeController.instance.labelDisplay(context)}", style: Theme.of(context).textTheme.titleSmall),
                  Column(
                    spacing: 8, 
                    // inserir no ThemeData
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () { ThemeController.instance.setTheme(AppAvailableThemeMode.auto); },
                        child: const Text("Detectar Tema"),
                      ),
                      ElevatedButton(
                        onPressed: () { ThemeController.instance.setTheme(AppAvailableThemeMode.light); },
                        child: const Text("Tema Claro"),
                      ),
                      ElevatedButton(
                        onPressed: () { ThemeController.instance.setTheme(AppAvailableThemeMode.dark); },
                        child: const Text("Tema Escuro"),
                      ),
                    ]
                  ),
                  Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkcTTTVv5agc4-0CfIq1mWbt6NxUox3HiD7Q&s",
                    loadingBuilder: (context, child, progress) {
                      return progress == null ? child : LinearProgressIndicator();
                    },
                    width: 200,
                    height: 200,
                    semanticLabel: "White Owl",
                  )
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              tooltip: "Increment",
              child: const Icon(Icons.add),
            ),
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
//     child: const Icon(Icons.add),
//   ),
// );
