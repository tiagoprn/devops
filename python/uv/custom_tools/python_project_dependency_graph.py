# /// script
# requires-python = ">=3.12"
# dependencies = [
#   "typer",
#   "pygraphviz",
#   "networkx",
#   "matplotlib"
# ]
# ///

"""
Self-contained UV script to generate a Python module dependency graph.

Usage:
    uv run dependency_graph.py --project-dir /path/to/my_project --namespace my_project

This script:
- Finds all `.py` files in the given `--project-dir`.
- Analyzes imports matching the `--namespace`.
- Generates an **editable SVG** where nodes can be moved manually in Inkscape.
"""

import logging
import os
import sys
import typer
import ast
import networkx as nx
import matplotlib.pyplot as plt
import pygraphviz as pgv
from pathlib import Path
from typing import Set

# Logging Configuration
CURRENT_SCRIPT_NAME = os.path.splitext(os.path.basename(__file__))[0]
LOG_FORMAT = (
    "[%(asctime)s PID %(process)s "
    "%(filename)s:%(lineno)s - %(funcName)s()] "
    "%(levelname)s -> \n"
    "%(message)s\n"
)
logging.basicConfig(
    format=LOG_FORMAT,
    level=logging.INFO,
    handlers=[
        logging.FileHandler(f"{CURRENT_SCRIPT_NAME}.log"),
        logging.StreamHandler(sys.stdout),
    ],
)

app = typer.Typer()


def find_imports(filepath: Path, namespace: str) -> Set[str]:
    """Parse a Python file and extract internal module imports matching the given namespace."""
    with filepath.open("r", encoding="utf-8") as file:
        tree = ast.parse(file.read(), filename=str(filepath))

    imports = set()
    for node in ast.walk(tree):
        if isinstance(node, ast.Import):
            for alias in node.names:
                if alias.name.startswith(namespace):
                    imports.add(alias.name)
        elif isinstance(node, ast.ImportFrom):
            if node.module and node.module.startswith(namespace):
                imports.add(node.module)

    return imports


def build_dependency_graph(root_dir: Path, namespace: str) -> nx.DiGraph:
    """Create a directed graph of internal module dependencies."""
    graph = nx.DiGraph()
    python_files = list(root_dir.rglob("*.py"))

    if not python_files:
        logging.error(f"❌ No Python files found under: {root_dir}")
        return graph

    logging.info(f"✅ Found {len(python_files)} Python files under: {root_dir}")

    for filepath in python_files:
        module = (
            str(filepath.relative_to(root_dir))
            .replace("/", ".")
            .replace("\\", ".")
            .rstrip(".py")
        )
        if module.endswith("__init__"):
            module = module.rsplit(".", 1)[0]

        imports = find_imports(filepath, namespace)
        if imports:
            logging.info(f"🔗 {module} imports: {', '.join(imports)}")

        for imp in imports:
            graph.add_edge(module, imp)

    return graph


def save_graphviz_svg(graph: nx.DiGraph, output_file: Path) -> None:
    """Generate an SVG with Graphviz (editable in Inkscape)."""
    A = nx.nx_agraph.to_agraph(graph)
    A.layout(prog="dot")  # Use Graphviz's 'dot' layout engine
    A.draw(output_file, format="svg")
    logging.info(f"✅ Editable dependency graph saved as: {output_file}")


@app.command()
def generate(
    project_dir: Path = typer.Option(..., "--project-dir", help="Path to the Python project"),
    namespace: str = typer.Option(..., "--namespace", help="Namespace to track"),
    output_file: Path = typer.Option("dependency_graph.svg", "--output", help="Output SVG file"),
):
    """Generate a dependency graph for the given Python project."""
    project_dir = project_dir.resolve()

    logging.info(f"📂 Scanning project at: {project_dir}")
    graph = build_dependency_graph(project_dir, namespace)

    if not graph.nodes:
        logging.error("❌ No dependencies found. The graph is empty.")
        return

    save_graphviz_svg(graph, output_file)


if __name__ == "__main__":
    app()
