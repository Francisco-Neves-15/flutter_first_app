! Ajustar Arquitetura do Bottomsheet; Plano:

- FEITO > BottomsheetContainer ser apenas o Container, deixando dragHandle title, desc e closeButton padronizado; (Mover o close para o topo, e ajustar o layout da header do bottomsheetcontainer);

- FEITO > BottomsheetContainer criar l10n para dismissLabel;

- FEITO > Variações de Layout para ThemeManager & LangManager (adicionar opção para IconButton simples & icones "idiomas" e "tema")

# Nest Steps

- Persistencia do tema e idioma guardando no cache;

- Aplicar navegação entre telas (e "encontrar" uma forma de fazer a tela com overlay)

- Criar menu laterial, surgindo apartir do botão lateral

- Conseguir ajustar botões de navegação de acordo com a tela; Por exemplo:

---

Navegação personalizada;

A tela (rota) de "Configurações", possui diversas subrotas dentro;

```
--- Home
--- Configurações
 |- Tela de Pedidos
 |- Tela de Cupons
```

A rota configurações pode ser acessada por navegação, por exemplo no "Menu Lateral", que ao clicar navega até ela; Dentro da tela, o menu lateral ainda pode ser acessado, e neste caso, por eu querer navegar até aquela mas já estar naquela rota, clicar novamente no botão ela meio que dá um "reload" para garantir a tela carregada; E ao navegar para alguma subrota (que subrota é apenas o nome, mas, vindo do stack eu imagino que ficaria algo como: Home → Settgins → Pedidos), e neste caso, clicar no "voltar" nas subrotas dá um BACK ao invés de navegar novamente, evitando ficar assim: Home → Settgins → Pedidos → Settgins;

A ideia é o menu do app ter algumas condicionais ao tentar navegar, que ele consiga pegar as rota atual, pegar o stack de rotas e com isso evitar navegações duplas e outros problemas; Porém, isto vale também para o botão de "Voltar" que geralmente há em celulares, assim, eu obrigo o botão voltar funcionar da mesma forma que botão "Voltar" do topo do menu;

# Ajustes

- Ajustar cores background, backgroundSecondary, backgroundSurface em um monitor que mostre as cores reais (desktop)

# Verificar:
- Criar o "ActionSheet", que usa dos estilos das actions, palletes e outras regras; Na construção, ele utiliza um BottomsheetContainer, porém, ActionSheet é feito para suportar actions apenas;

# Analisar:
- BottomsheetContainer passa a suportar diferentes configurações de comportamento, como: Draggable, Full Screen, Scrollable & Custom Height
