"""Generate checked scientific charts for Markdown-based Wikis.

Outputs: SVG/PNG for accurate scientific figures, Mermaid XY for compact charts.
Python >= 3.10, matplotlib. No hidden data fabrication or assumed units.
"""
from __future__ import annotations

import argparse
import csv
import json
import math
from pathlib import Path
from typing import Sequence

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np


def numeric_series(values: Sequence[float], *, label: str) -> tuple[float, ...]:
    """Reject empty, nonnumeric and nonfinite data before plotting."""
    if not values:
        raise ValueError(f"{label} must contain at least one value")
    try:
        numeric_values = tuple(float(value) for value in values)
    except (TypeError, ValueError) as exc:
        raise ValueError(f"{label} must be numerical") from exc
    if not all(math.isfinite(value) for value in numeric_values):
        raise ValueError(f"{label} contains a NaN or infinite value")
    return numeric_values


def csv_column(csv_path: Path, column: str) -> tuple[float, ...]:
    """Read a named CSV column with strict row/column error reporting."""
    if not csv_path.is_file():
        raise FileNotFoundError(csv_path)
    observations = []
    with csv_path.open(encoding="utf-8-sig", newline="") as stream:
        csv_rows = csv.DictReader(stream)
        if not csv_rows.fieldnames or column not in csv_rows.fieldnames:
            raise ValueError(f"CSV does not contain the column {column!r}")
        for row_number, row in enumerate(csv_rows, start=2):
            try:
                observations.append(float(row[column]))
            except (TypeError, ValueError) as exc:
                raise ValueError(f"Invalid {column!r} at CSV row {row_number}") from exc
    return numeric_series(observations, label=column)


def export_figure(figure, destination_stem: Path) -> tuple[Path, Path]:
    """Save vector and raster representations of exactly the same plot."""
    destination_stem.parent.mkdir(parents=True, exist_ok=True)
    svg_path = destination_stem.with_suffix(".svg")
    png_path = destination_stem.with_suffix(".png")
    try:
        figure.savefig(svg_path, bbox_inches="tight")
        figure.savefig(png_path, dpi=175, bbox_inches="tight")
    finally:
        plt.close(figure)
    return svg_path, png_path


def signal_figure(
    sample_positions: Sequence[float],
    measured_values: Sequence[float],
    *,
    x_unit: str,
    y_unit: str,
    x_label: str = "Time",
    y_label: str = "Temperature",
    title: str = "Measured signal",
):
    """Show discrete observations; never infer a continuous curve."""
    positions = numeric_series(sample_positions, label="sample positions")
    values = numeric_series(measured_values, label="signal values")
    if len(positions) != len(values):
        raise ValueError("Signal positions and values must have equal length")
    if len(set(positions)) != len(positions):
        raise ValueError("Repeated sample positions require an explicit aggregation policy")
    if sorted(positions) != list(positions):
        raise ValueError("Sample positions must be strictly increasing")
    figure, axes = plt.subplots(figsize=(8.4, 4.4), layout="constrained")
    extent = max(values) - min(values)
    padding = max(extent * 0.45, 0.20)
    guide_floor = min(values) - padding
    axes.vlines(positions, guide_floor, values, linestyles="dotted", linewidth=1, alpha=0.65)
    axes.scatter(positions, values, marker="o", s=70, label="Measured samples", zorder=3)
    axes.set_xlim(min(positions) - 0.25, max(positions) + 0.25)
    axes.set_ylim(guide_floor, max(values) + padding)
    axes.set_xticks(positions)
    axes.set_xlabel(f"{x_label} ({x_unit})")
    axes.set_ylabel(f"{y_label} ({y_unit})")
    axes.set_title(title)
    axes.grid(axis="y", alpha=0.22)
    axes.legend(frameon=False)
    return figure


def histogram_figure(
    measured_values: Sequence[float],
    *,
    bin_count: int,
    value_label: str,
    unit: str,
    title: str = "Observed distribution",
    density: bool = False,
):
    """Compute a true histogram from numerical samples, not an arbitrary bar chart."""
    values = numeric_series(measured_values, label="histogram values")
    if len(values) < 2:
        raise ValueError("A histogram needs at least two observations")
    if type(bin_count) is not int or not 1 <= bin_count <= 100:
        raise ValueError("bin_count must be an integer from 1 to 100")
    figure, axes = plt.subplots(figsize=(8.4, 4.4), layout="constrained")
    counts, bin_edges, _ = axes.hist(values, bins=bin_count, density=density, edgecolor="black", linewidth=.5)
    axes.set_xlabel(f"{value_label} ({unit})")
    axes.set_ylabel("Estimated density" if density else "Observations per bin")
    axes.set_title(title + f" (n={len(values)})")
    axes.grid(axis="y", alpha=0.22)
    if not density and int(sum(counts)) != len(values):
        plt.close(figure)
        raise AssertionError("Histogram counts do not recover sample size")
    return figure, {"sample_size":len(values), "bin_edges":[float(x) for x in bin_edges],
                    "bar_values":[float(c) for c in counts], "density":density}


def mermaid_xy(
    labels: Sequence[str], measured_values: Sequence[float], *,
    title: str, y_axis_title: str, shape: str = "line",
) -> str:
    """Export a compact Mermaid XY chart; never call bars a histogram unconditionally."""
    values = numeric_series(measured_values, label="Mermaid chart values")
    if not labels or len(labels) != len(values):
        raise ValueError("Mermaid labels and values must have equal nonzero lengths")
    if shape not in ("line", "bar"):
        raise ValueError("Mermaid XY supports line and bar shapes")
    def quoted_label(label: str) -> str:
        label = str(label)
        if any(character in label for character in ['"', '\\', '\n', '\r']):
            raise ValueError("Mermaid labels must not contain quotes, backslashes or newlines")
        return '"' + label + '"'
    label_list = ", ".join(quoted_label(label) for label in labels)
    value_list = ", ".join(f"{value:g}" for value in values)
    return "\n".join([
        "xychart-beta", f"    title {quoted_label(title)}",
        f"    x-axis [{label_list}]",
        f"    y-axis {quoted_label(y_axis_title)}",
        f"    {shape} [{value_list}]",
        "",
    ])


def render_from_csv(
    kind: str, csv_path: Path, destination_stem: Path,
    *, x_column: str | None, y_column: str, bins: int,
    x_unit: str, y_unit: str, title: str, density: bool = False,
    x_label: str | None = None, y_label: str | None = None,
):
    values = csv_column(csv_path, y_column)
    if kind == "signal":
        if not x_column:
            raise ValueError("Signal charts require --x-column")
        positions = csv_column(csv_path, x_column)
        figure = signal_figure(positions, values, x_unit=x_unit, y_unit=y_unit,
                               x_label=x_label or x_column, y_label=y_label or y_column, title=title)
        metadata = {"kind":kind, "count":len(values), "positions":list(positions),
                    "measurements":list(values), "synthetic":None}
        label_strings = [f"{position:g}" for position in positions]
        chart = mermaid_xy(label_strings, values, title=title, y_axis_title=f"{y_label or y_column} ({y_unit})")
        destination_stem.parent.mkdir(parents=True, exist_ok=True)
        destination_stem.with_suffix(".mmd").write_text(chart, encoding="utf-8")
    elif kind == "histogram":
        figure, metadata = histogram_figure(values, bin_count=bins,
                                           value_label=y_label or y_column, unit=y_unit,
                                           title=title, density=density)
        metadata["kind"] = kind
        # The bar chart only represents a histogram if these actual bins and counts are used.
        metadata["mermaid"] = "Use computed bin counts, bin labels, and specify equal-width bins; a bar chart alone is not a histogram."
    else:
        raise ValueError("kind must be signal or histogram")
    svg_path, png_path = export_figure(figure, destination_stem)
    destination_stem.with_suffix(".json").write_text(
        json.dumps({"source_csv":str(csv_path),"y_column":y_column,**metadata},indent=2),
        encoding="utf-8",
    )
    return svg_path, png_path


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Reproducible Wiki plots: signal / histogram")
    parser.add_argument("kind", choices=["signal", "histogram"])
    parser.add_argument("--csv", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True, help="Output base path (without extension)")
    parser.add_argument("--x-column")
    parser.add_argument("--y-column", required=True)
    parser.add_argument("--x-label")
    parser.add_argument("--y-label")
    parser.add_argument("--bins", type=int, default=8)
    parser.add_argument("--x-unit", default="min")
    parser.add_argument("--y-unit", default="°C")
    parser.add_argument("--title", default="Scientific figure")
    parser.add_argument("--density", action="store_true")
    args = parser.parse_args(argv)
    svg_path, png_path = render_from_csv(
        args.kind, args.csv, args.output, x_column=args.x_column, y_column=args.y_column,
        bins=args.bins, x_unit=args.x_unit, y_unit=args.y_unit, title=args.title,
        density=args.density, x_label=args.x_label, y_label=args.y_label,
    )
    print(json.dumps({"svg":str(svg_path),"png":str(png_path)}))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
