# Code Style

## 1.工具辅助

- 你需要使用[gdtoolkit](https://github.com/Scony/godot-gdscript-toolkit)进行格式化，你可以通过将`tools/pre-commit`复制到`.git/hooks`来自动执行这个过程

## 2.规范

- 请遵循Godot官方提出的[风格指南](https://docs.godotengine.org/zh-cn/4.x/tutorials/best_practices/project_organization.html#style-guide)

- 对于gdscript，请遵循[GDScript风格指南](https://docs.godotengine.org/zh-cn/4.x/tutorials/scripting/gdscript/gdscript_styleguide.html)

## 3.注意

- 请一定不要直接在代码中出现硬编码的场景路径等资源，我们要求做到，可以随时重构而不导致任何问题发生，代码的健壮性是我们考虑的重要因素
