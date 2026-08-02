Adapting native Flutter widgets—specifically the built-in ones—to customize them or implement specific business logic;

For instance, `TabBar()` typically uses `Tab()` widgets for its `tabs` parameter, but since `Tab()` widgets lack `ThemeData` support for global styling, we use a custom widget instead.