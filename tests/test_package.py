from __future__ import annotations

import importlib.metadata

import pytest

import dcmqi as m


def test_version():
    assert importlib.metadata.version("dcmqi") == m.__version__


def test_itkimage2segimage():
    with pytest.raises(SystemExit) as e:
        m.itkimage2segimage()
    assert e.value.code == 1


def test_segimage2itkimage():
    with pytest.raises(SystemExit) as e:
        m.segimage2itkimage()
    assert e.value.code == 1


def test_tid1500writer():
    with pytest.raises(SystemExit) as e:
        m.tid1500writer()
    assert e.value.code == 1


def test_tid1500reader():
    with pytest.raises(SystemExit) as e:
        m.tid1500reader()
    assert e.value.code == 1


def test_itkimage2paramap():
    with pytest.raises(SystemExit) as e:
        m.itkimage2paramap()
    assert e.value.code == 1


def test_paramap2itkimage():
    with pytest.raises(SystemExit) as e:
        m.paramap2itkimage()
    assert e.value.code == 1
