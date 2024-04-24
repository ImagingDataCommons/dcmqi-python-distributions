from __future__ import annotations

import subprocess
import sys
import sysconfig
from pathlib import Path

import pytest

if sys.version_info < (3, 10):
    from importlib_metadata import distribution
else:
    from importlib.metadata import distribution

import dcmqi

from . import push_argv

all_tools = pytest.mark.parametrize(
    "tool",
    [
        "itkimage2segimage",
        "segimage2itkimage",
        "tid1500writer",
        "tid1500reader",
        "itkimage2paramap",
        "paramap2itkimage",
    ],
)

all_tools_version = pytest.mark.parametrize(
    "tool,expected_version",
    [
        ("itkimage2segimage", "1.0"),
        ("segimage2itkimage", "1.0"),
        ("tid1500writer", "1.0"),
        ("tid1500reader", "1.0"),
        ("itkimage2paramap", "1.0"),
        ("paramap2itkimage", "1.0"),
    ],
)


def _get_scripts():
    dist = distribution("dcmqi")
    scripts_paths = [
        Path(sysconfig.get_path("scripts", scheme)).resolve()
        for scheme in sysconfig.get_scheme_names()
    ]
    scripts = []
    for file in dist.files:
        if file.locate().parent.resolve(strict=True) in scripts_paths:
            scripts.append(file.locate().resolve(strict=True))
    return scripts


@all_tools_version
def test_package_script(tool, expected_version):
    """
    Example of the output for tid1500writer (analogous for the other tools):

    tid1500writer --version
    dcmqi repository URL: https://github.com/QIICR/dcmqi revision: 1922a09 tag: v1.3.1

    /home/leonard/miniconda3/envs/dcmqi_pypi_test/lib/python3.8/site-packages/dcmqi/bin/tid1500writer  version: 1.0
    """
    scripts = [script for script in _get_scripts() if script.stem == tool]
    assert len(scripts) == 1
    output = subprocess.check_output([str(scripts[0]), "--version"]).decode("ascii")
    assert output.splitlines()[2].split("  ")[1] == f"version: {expected_version}"


@all_tools
def test_module(tool):
    func = getattr(dcmqi, tool)
    args = [f"{tool}.py", "--version"]
    with push_argv(args), pytest.raises(SystemExit) as excinfo:
        func()
    assert excinfo.value.code == 0
