! Ajustar Arquitetura do Bottomsheet; Plano:

- BottomsheetContainer ser apenas o Container, deixando dragHandle title, desc e closeButton padronizado; (Mover o close para o topo, e ajustar o layout da header do bottomsheetcontainer);

- Criar o "ActionSheet", que usa dos estilos das actions, palletes e outras regras; Na construção, ele utiliza um BottomsheetContainer, porém, ActionSheet é feito para suportar actions apenas;

- BottomsheetContainer passa a suportar diferentes configurações de comportamento, como: Draggable, Full Screen, Scrollable & Custom Height
