# Quickshell Config

This directory contains configuration files for Quickshell.\
The main file is `shell.qml`, which defines the overall shell structure.\
Other files define specific components and behaviors.

## Structure

- `README.md`: This file, providing an overview of the configuration structure and conventions.
- `shell.qml`: Main shell configuration
- `Widgets` directory: Contains widget definitions such as status bars, panels, etc. A widget isn't necessarily a window, and may also define components used within other widgets or windows.
- `Stats` directory: Contains scripts and configurations for system statistics collection.

## Conventions

- Element with id will define the id in the opening line
- Id will be snake_case
- The order of statements inside an element is:
  - Properties
  - Simple values (single value)
  - Complex values (with nested elements)
  - Signal handlers
  - Child elements
- Groups of properties are separated by a single blank line
- Elements are separated by a single blank line
- Use 4 spaces for indentation
- Use double quotes for strings
- Use single quotes for characters
- Curly braces for blocks are on the same line as the statement that opens them
- No semicolons at the end of lines
- Element descriptions/comments are placed inside the element they describe at the top, with a blank line after
- Empty elements are written in single-line form (e.g., `Element { }`)
- Elements with only a single value set are written in single-line form (e.g., `Element { property: value }`)
