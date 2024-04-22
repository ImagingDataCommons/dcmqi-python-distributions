from __future__ import annotations

import importlib.metadata

import dcmqi_python_distributions  as m


def test_version():
    assert importlib.metadata.version("dcmqi_python_distributions ") == m.__version__
