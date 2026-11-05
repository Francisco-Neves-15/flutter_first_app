# Flutter First App — TODO

> Reorganizado em 2026-11-04. Nada foi apagado, apenas agrupado por estado.
> ✅ = confirmei no código agora | (sem check) = estava marcado "FEITO" mas não verifiquei a fundo | 🟡 = parcial/precisa atenção | 🔲 = pendente

## ✅ Concluído (confirmado no código agora)

- AppTheme → **AppStyle**: classe e ficheiro renomeados (`lib/styles/app_style.dart`, `class AppStyle`). ⚠️ `lib/theme/README_THEME.md` ainda fala em `AppTheme.build(...)` — doc desatualizada, vale corrigir.
- AppMetrics → **AppSpacing**: `lib/styles/app_spacing.dart`, `class AppSpacing`.
- **ActionSheetBuilder**: existe e está implementado (`lib/widgets/layout/bottomsheets/action_sheet_builder.dart`), usa `BottomSheetButton` e suporta `showDividers`.
- **AppInputDialog bug1** (remover botão cancelar quando `requiredInput`): confirmado em `app_input_dialog.dart:257` — o botão só aparece `if (!widget.requiredInput)`.
- **AppButton**: opção `loading` (com `loadingLabel`, `loadingLocation`) e opção `disabled` já existem como parâmetros funcionais.
- **AppIconButton**: ficheiro existe e tem estrutura completa (type, variant, aspect, icon, style, loading, callbacks).
- **Dialogs type unificado**: o antigo `AppAlertDialogType` foi substituído por `AppDialogsTypes` (`_dialogs.dart`), já com `.warn` (não `.warning`).
- **Rename "warning" → "warn"**: feito nos **Dialogs** (`AppDialogsTypes.warn`).
- **Rename "warning" → "warn"**: feito nos **Botões** (`AppButtonVariant.warn`).

## 🟡 Parcial / Precisa de atenção
- **Loading/Disabled nos botões dos Dialogs** (Alert/Confirm/Input): o botão `AppButton` já suporta `loading`/`disabled`, mas os Dialogs **ainda não expõem** essas opções nas suas actions — confirmei que nenhum dos 3 dialogs passa `loading`/`disabled` para o `AppButton` interno. A nota antiga dizia "FEITO!!" mas isso não corresponde ao código atual — fica como pendente real.
- **Inputs/Textareas**: respondendo à tua pergunta — **não encontrei um widget dedicado nem estilo global**. O único campo de texto do app é o `TextField` solto dentro do `app_input_dialog.dart:279`, com `InputDecoration(hintText: ...)` simples, sem usar tema (`lib/styles/app_style.dart` não define `inputDecorationTheme`). Ou seja: ficou "solto" mesmo, não foi transformado em Widget nem estilizado via tema. Isto cobre os itens "definir estilo padrão para TextField" e "Criar estilos e Widgets pré-prontos para os Inputs" — ambos ainda pendentes.
- **Cores "link" e "creative"**: ainda estão comentadas em `lib/theme/app_colors.dart` (linhas ~29-30 e 56-58), não finalizadas.
- **AppInputDialog bug2** ("verificar casos de uso"): não verificado nesta passagem — fica pendente para revisão manual.

## 🔲 Pendente

### Dialogs / Inputs
- Construir e padronizar estilos "success", "deleting", "warn" etc. nos Dialogs.
- Actions para `AppConfirmDialog` e `AppInputDialog` (hoje só o Alert tem o full-width/custom actions mais trabalhado).
- Adicionar `confirmDisable` (ou `mainDisabled`/`secondaryDisabled`) no `AppInputDialog`.
- `AppInputDialog`: adicionar "Inputs Qtd" dinâmico, ou `customInputs: List<Widget>` deixando o tratamento para quem usa.
- Padronizar nomenclatura interna dos Dialogs (`main`/`secondary` em vez de `confirm`/`cancel`), se decidido manter actions customizadas.
- Avaliar se vale a pena manter "actions" customizadas em Confirm/Input, ou simplificar e deixar só o Alert mais flexível.
- Depois do Toast: avisos ao tentar fechar Dialogs `required`/`requiredInteraction`.

### Inputs/Textareas (estilo)
- Criar estilos e Widget(s) pré-prontos para inputs de texto, número, password, etc.
- Definir `inputDecorationTheme` padrão no `AppStyle`.
- Opção `disabled` para os inputs.
- Atualizar `app_input_dialog.dart` para usar esse novo widget/estilo em vez do `TextField` solto.

### Theme / Style
- Corrigir `README_THEME.md` para referenciar `AppStyle.build(...)` em vez de `AppTheme.build(...)`.
- Terminar cores "link" e "creative" (hoje comentadas em `app_colors.dart`).
- Estilo para as headers de `BottomDivider`.

### Outros
- Ícone do App e derivados (favicon, ícone mobile, splash screen padrão) — ainda não customizado (assets padrão do Flutter continuam em `android/.../mipmap-*`).
- Implementar Toasts.
- Widget `LoadingDots`: auto-coloca "..." e/ou anima os pontos.
- Detectar idioma do celular automaticamente (Flutter First App).

## ✅ Itens antigos marcados "FEITO" (mantidos como confiáveis, não re-verifiquei a fundo)

- BottomsheetContainer: container "puro" com dragHandle, title, desc e closeButton padronizados (close no topo).
- BottomsheetContainer: l10n para `dismissLabel`.
- Variações de layout para ThemeManager & LangManager (IconButton simples vs. ícones de idioma/tema).
- Actions do Alert com opção de preencher toda a largura disponível.
- Estilos pré-prontos (`ButtonStyle()`) para botões — Danger, Success, Disabled (ElevatedButton).
- AppButton (base).
- Reorganização de todo uso de ícones (Icon/Icons/Symbols) no app.
- Correção: bug no `AppButton` tipo `outlined` quando `loading`+`disabled` juntos.
- `AppIconButton`: AppButton passa a aceitar `icon` (ícone único) além de `child`.
- Opção `InvertDefaultActions` nos Dialogs (Confirm & Input).
- Persistência de tema e idioma em cache.
- Sistema de navegação (rotas nomeadas, detectáveis, side menu).
- Controle do botão "Voltar" em modais.
- AppBar (navigation & header) com suporte a "back".
- Menu lateral (side menu) via botão lateral.
- Botões de navegação ajustados por tela.
- Cores de background/backgroundSecondary/backgroundSurface ajustadas num monitor real.

---

## 📝 Notas de design (mantidas na íntegra)

### Navegação personalizada

A tela (rota) de "Configurações" possui diversas subrotas dentro:

```
--- Home
--- Configurações
 |- Tela de Pedidos
 |- Tela de Cupons
```

A rota configurações pode ser acessada por navegação, por exemplo no "Menu Lateral", que ao clicar navega até ela; Dentro da tela, o menu lateral ainda pode ser acessado, e neste caso, por eu querer navegar até aquela mas já estar naquela rota, clicar novamente no botão ela meio que dá um "reload" para garantir a tela carregada; E ao navegar para alguma subrota (que subrota é apenas o nome, mas, vindo do stack eu imagino que ficaria algo como: Home → Settgins → Pedidos), e neste caso, clicar no "voltar" nas subrotas dá um BACK ao invés de navegar novamente, evitando ficar assim: Home → Settgins → Pedidos → Settgins;

A ideia é o menu do app ter algumas condicionais ao tentar navegar, que ele consiga pegar as rota atual, pegar o stack de rotas e com isso evitar navegações duplas e outros problemas; Porém, isto vale também para o botão de "Voltar" que geralmente há em celulares, assim, eu obrigo o botão voltar funcionar da mesma forma que botão "Voltar" do topo do menu;

### Análise: BottomsheetContainer

BottomsheetContainer passa a suportar diferentes configurações de comportamento, como: Draggable, Full Screen, Scrollable & Custom Height.
