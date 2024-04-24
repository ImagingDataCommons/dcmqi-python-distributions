from __future__ import annotations

import importlib.metadata

import dcmqi as m


def test_version():
    assert importlib.metadata.version("dcmqi") == m.__version__
