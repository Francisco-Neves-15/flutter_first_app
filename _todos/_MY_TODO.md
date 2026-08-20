! Ajustar Arquitetura do Bottomsheet; Plano:

- FEITO > BottomsheetContainer ser apenas o Container, deixando dragHandle title, desc e closeButton padronizado; (Mover o close para o topo, e ajustar o layout da header do bottomsheetcontainer);

- FEITO > BottomsheetContainer criar l10n para dismissLabel;

- FEITO > Variações de Layout para ThemeManager & LangManager (adicionar opção para IconButton simples & icones "idiomas" e "tema")

Verificar:
- Criar o "ActionSheet", que usa dos estilos das actions, palletes e outras regras; Na construção, ele utiliza um BottomsheetContainer, porém, ActionSheet é feito para suportar actions apenas;

Analisar:
- BottomsheetContainer passa a suportar diferentes configurações de comportamento, como: Draggable, Full Screen, Scrollable & Custom Height
