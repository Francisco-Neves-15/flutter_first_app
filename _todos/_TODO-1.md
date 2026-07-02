# TODO

### 30-06-26

---

Problema no Tema do App

`ThemeController.instance` não muda se: Estiver com o resolved e trocar para auto, porém, o auto que for resolvido é o mesmo que o resolved atual, o valor do `ThemeController.instance`; O mesmo acontece se, estiver em auto (com o resolved aplicado), ao aplicar para o mesmo resolved pelos btn's, o `ThemeController.instance` não muda;
Exemplo da falha:

Light Selecionado; Celular em Dark, ao mudar para auto, o app muda e os valores de `ThemeController.instance` seguem; Porém, se estiver em Light Selecionado; Celular em Dark, ao mudar para Dark, o app muda, porém os valores de `ThemeController.instance` não mudam, parecendo que o `ThemeController.instance` não escuta a troca; Esse mesmo fluxo acontece se for Dark Selecionado, invertando os valores.

outro fluxo:
Se for Dark Selecionado/ Celular em Dark, quando mudar para auto o `ThemeController.instance` não muda (deveria ir para auto), mas, se mudar para Light (o celular), ai sim atualiza, ou claro, também mudar Light no App; Esse mesmo Light acontece se for Dark Selecionado, invertando os valores.

Os valores no `ThemeController.instance` deveriam ser esses, de acordo com os Temas:

=== App: Light | Celular Light ===
${ThemeController.instance.mode}                   = light
${ThemeController.instance.themeMode}              = light
${ThemeController.instance.resolvedTheme(context)} = light
${ThemeController.instance.labelDisplay(context)}  = Light

=== App: Dark | Celular Dark ===
${ThemeController.instance.mode}                   = dark
${ThemeController.instance.themeMode}              = dark
${ThemeController.instance.resolvedTheme(context)} = dark
${ThemeController.instance.labelDisplay(context)}  = Dark

=== App: Auto | Celular Light ===
${ThemeController.instance.mode}                   = auto
${ThemeController.instance.themeMode}              = system
${ThemeController.instance.resolvedTheme(context)} = light
${ThemeController.instance.labelDisplay(context)}  = Autodetect (Light)

=== App: Auto | Celular Dark ===
${ThemeController.instance.mode}                   = auto
${ThemeController.instance.themeMode}              = system
${ThemeController.instance.resolvedTheme(context)} = dark
${ThemeController.instance.labelDisplay(context)}  = Autodetect (Dark)

O problema presente aqui, é que os valores não atualizam ao clique no `setTheme`, algo que ele deveria "disparar" um aviso para alterar todos os valores conforme;

### 01-07-26

---

Problema no `lib\styles\app_text_styles.dart`

Se aplico:
```dart
return ThemeData(
  fontFamily: "Urbanist",
)
```
Funciona perfeitamente em tudo

Se aplico no:
```dart
final textButtonTheme = TextButtonThemeData(
  style: ButtonStyle(
    foregroundColor: WidgetStatePropertyAll(colors.text),
    textStyle: WidgetStatePropertyAll(
      TextStyle(
        fontFamily: "DynaPuff",
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
    ),
  ),
);
```
e retorno, mesmo com o fontFamily aplicado no ThemeData ele respeita, ou seja, tudo fica com Urbanist mas o DynaPuff fica no button, exatamente como deveria;

Mas, absolutamente tudo que o uso dessa forma: `Text("Tema do App", style: Theme.of(context).textTheme.titleMedium)` não nem aplicado, fiz o teste antes mudando o textTheme.displayMedium para uns 300 de valor no fontSize e nada mudou no App, ou qualquer outro valor; Parece que o App simplesmente ignora;

A ideia era fazer essa ordem de importancia:
- ThemeData=fontFamily → ThemeData=TextButtonThemeData (e os outros) → `Theme.of(context).textTheme.???`

E aqui:
```dart
builder: (context, child) {
  return DefaultTextStyle(
      style: AppTextStyles.baseText,
      textAlign: TextAlign.left,
      child: child ?? const SizedBox.shrink(),
    );
},
```
Apesar de ser usado, fica aqui apenas por ser obrigatorio já que não carrega valor (preciso apenas do textAlign);

Qual meu erro de utilidade aqui? outro coisa, fiz algo que só descrobri depois era possivel, que era adicionar no extensions, ou seja, adicionar esses estilos no `context.colors.primary` igual o `lib\extensions\theme_colors_extension.dart` faz; Então, usando dessa forma: `Text("Texto", style: context.text.h1)` ou `Text("Texto", style: context.text.display)`, por exemplo; Isso é recomendado? sendo possivel ser aplicado?

As vezes, oq tenho hoje parece funcionar, mas as vezes tbm é só ignorado, queria garantir e verificar esse funcionalidade.
