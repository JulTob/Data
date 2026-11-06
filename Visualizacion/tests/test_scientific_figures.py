"""Acceptance checks for Plotographer's current plotting backend."""
import importlib.util
from pathlib import Path
import tempfile

import pytest

MODULE = Path(__file__).parents[1] / "scientific_figures.py"
spec = importlib.util.spec_from_file_location("scientific_figures", MODULE)
figures = importlib.util.module_from_spec(spec)
spec.loader.exec_module(figures)


def test_discrete_samples_and_mermaid_are_exact():
    with tempfile.TemporaryDirectory() as folder:
        csv_path = Path(folder, "temperatures.csv")
        csv_path.write_text("minute,temperature_c\n0,20.0\n1,20.3\n2,20.6\n", encoding="utf-8")
        stem = Path(folder, "signal")
        figures.render_from_csv("signal", csv_path, stem, x_column="minute",
                                y_column="temperature_c", bins=5,
                                x_unit="min", y_unit="°C", title="Room thermometer")
        source = stem.with_suffix(".mmd").read_text()
        assert "line [20, 20.3, 20.6]" in source
        assert 'x-axis ["0", "1", "2"]' in source
        assert stem.with_suffix(".png").is_file()
        assert stem.with_suffix(".svg").is_file()
        assert "Measured samples" not in source  # no invented trend data


def test_histogram_count_conservation():
    observations = [20.0, 20.1, 20.1, 20.2, 20.2, 20.2,
                    20.3, 20.4, 20.5, 20.7, 20.8, 20.8]
    figure, report = figures.histogram_figure(observations, bin_count=4,
                                             value_label="Temperature", unit="°C")
    assert sum(report["bar_values"]) == len(observations)
    assert len(report["bin_edges"]) == 5
    figures.plt.close(figure)


def test_refuse_unsupported_or_mismatched_inputs():
    with pytest.raises(ValueError):
        figures.mermaid_xy(["a"], [float("nan")], title="test", y_axis_title="value")
    with pytest.raises(ValueError):
        figures.signal_figure([0, 1], [1], x_unit="min", y_unit="°C")
    with pytest.raises(ValueError):
        figures.signal_figure([0, 0], [10, 11], x_unit="min", y_unit="°C")
    with pytest.raises(ValueError):
        figures.histogram_figure([1], bin_count=3, value_label="x", unit="u")
    with pytest.raises(ValueError):
        figures.mermaid_xy(["a"], [5], title="test", y_axis_title="x", shape="scatter")
