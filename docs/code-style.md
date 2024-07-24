# Code Style

## 1.Tools-based Assistance

- You need to use [gdtoolkit](https://github.com/Scony/godot-gdscript-toolkit) to format the code.You can copy `tools/pre-commit` to `.git/hooks` to do that automatically

## 2.Standards

- Please adhere to the [style guide](https://docs.godotengine.org/en/stable/tutorials/best_practices/project_organization.html#style-guide) proposed by the official Godot.

- For GDScript, follow the [GDScript Style Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html).

## 3.Notes

- Please avoid hardcoding scene paths or other resources directly in the code at all costs. We require that it should be possible to refactor at any time without causing any issues. The robustness of the code is an important factor we consider.
