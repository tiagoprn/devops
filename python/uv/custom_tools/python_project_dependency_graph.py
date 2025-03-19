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
    uv run dependency_graph.py --project-dir /path/to/project --namespace my_project --ignore auth,common,v0

Note:
    You need the following packages installed on your distro for it to work: `graphviz libgraphviz-dev` (on Ubuntu)

This script:
- Finds all `.py` files in the given `--project-dir`.
- Analyzes imports matching the `--namespace`.
- **Ignores directories listed in `--ignore` (recursively).**
- Generates an **editable SVG** where nodes can be moved manually in Inkscape.
"""

import logging
import os
import sys
import typer
import ast
import networkx as nx
import pygraphviz as pgv
from pathlib import Path
from typing import Set, List

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


def build_dependency_graph(
    root_dir: Path, namespace: str, ignore_dirs: List[str]
) -> nx.DiGraph:
    """Create a directed graph of internal module dependencies."""
    graph = nx.DiGraph()
    ignore_paths = {
        root_dir / d for d in ignore_dirs
    }  # Convert to full paths for comparison

    python_files = [
        f
        for f in root_dir.rglob("*.py")
        if not any(ignored in f.parents for ignored in ignore_paths)
    ]

    if not python_files:
        logging.error(
            f"❌ No Python files found under: {root_dir} (after ignoring {ignore_dirs})"
        )
        return graph

    logging.info(
        f"✅ Found {len(python_files)} Python files under: {root_dir}"
    )

    for filepath in python_files:
        module = (
            str(filepath.relative_to(root_dir))
            .replace("/", ".")
            .replace("\\", ".")
            .rstrip(".py")
        )
        if module.endswith("__init__"):
            module = module.rsplit(".", 1)[
                0
            ]  # Normalize __init__ module names

        imports = find_imports(filepath, namespace)
        if imports:
            logging.info(f"🔗 {module} imports: {', '.join(imports)}")

        for imp in imports:
            graph.add_edge(module, imp)

    return graph


def save_graphviz_svg(graph: nx.DiGraph, output_file: Path) -> None:
    """Generate an SVG with Graphviz (editable in Inkscape)."""
    A = nx.nx_agraph.to_agraph(graph)

    # Apply layout settings
    A.graph_attr.update(
        rankdir="TB",  # Top-to-bottom layout
        nodesep="1.0",  # Increase spacing between nodes
        ranksep="1.2",  # Increase spacing between levels
    )

    A.node_attr.update(
        fontsize="14",  # Bigger fonts for better readability
        shape="box",  # Boxed nodes for better visibility
        style="filled",  # Filled background for contrast
        fillcolor="lightblue",  # Light blue for modules
    )

    A.edge_attr.update(
        arrowsize="1.2",  # Larger arrowheads
        penwidth="1.5",  # Thicker edges for better visibility
    )

    A.layout(prog="dot")  # Use Graphviz 'dot' layout engine
    A.draw(output_file, format="svg")

    logging.info(f"✅ Improved dependency graph saved as: {output_file}")


@app.command()
def generate(
    project_dir: Path = typer.Option(
        ..., "--project-dir", help="Path to the Python project"
    ),
    namespace: str = typer.Option(
        ..., "--namespace", help="Namespace to track"
    ),
    ignore: str = typer.Option(
        "", "--ignore", help="Comma-separated list of subdirectories to ignore"
    ),
    output_file: Path = typer.Option(
        "dependency_graph.svg", "--output", help="Output SVG file"
    ),
):
    """Generate a dependency graph for the given Python project."""
    project_dir = project_dir.resolve()
    ignore_dirs = ignore.split(",") if ignore else []

    logging.info(f"📂 Scanning project at: {project_dir}")
    if ignore_dirs:
        logging.info(f"🚫 Ignoring directories: {ignore_dirs}")

    graph = build_dependency_graph(project_dir, namespace, ignore_dirs)

    if not graph.nodes:
        logging.error("❌ No dependencies found. The graph is empty.")
        return

    save_graphviz_svg(graph, output_file)


if __name__ == "__main__":
    app()
