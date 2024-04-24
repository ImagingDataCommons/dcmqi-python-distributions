"""
Copyright (c) 2024 Leonard Nürnberg. All rights reserved.

dcmqi: Python distribution of the DCMQI library collection.
"""

from __future__ import annotations

import subprocess
import sys
from importlib.metadata import distribution
from pathlib import Path
from typing import NoReturn

from ._version import version as __version__

__all__ = [
    "__version__",
    "itkimage2segimage",
    "segimage2itkimage",
    "tid1500writer",
    "tid1500reader",
    "itkimage2paramap",
    "paramap2itkimage",
]


DCMQI_BIN_DIR: Path = Path(__file__).parent


def _lookup(name: str) -> Path:
    executable_path = f"dcmqi/bin/{name}"
    files = distribution("dcmqi").files
    if files is not None:
        for _file in files:
            if str(_file).startswith(executable_path):
                return Path(_file.locate()).resolve(strict=True)
    msg = f"Failed to lookup '{executable_path}` directory."
    raise FileNotFoundError(msg)


def _program(name: str, args: list[str]) -> int:
    return subprocess.call([_lookup(name), *args], close_fds=False)


def itkimage2segimage() -> NoReturn:
    """Run the itkimage2segimage executable with arguments passed to a Python script."""
    raise SystemExit(_program("itkimage2segimage", sys.argv[1:]))


def segimage2itkimage() -> NoReturn:
    """Run the segimage2itkimage executable with arguments passed to a Python script."""
    raise SystemExit(_program("segimage2itkimage", sys.argv[1:]))


def tid1500writer() -> NoReturn:
    """Run the tid1500writer executable with arguments passed to a Python script."""
    raise SystemExit(_program("tid1500writer", sys.argv[1:]))


def tid1500reader() -> NoReturn:
    """Run the tid1500reader executable with arguments passed to a Python script."""
    raise SystemExit(_program("tid1500reader", sys.argv[1:]))


def itkimage2paramap() -> NoReturn:
    """Run the itkimage2paramap executable with arguments passed to a Python script."""
    raise SystemExit(_program("itkimage2paramap", sys.argv[1:]))


def paramap2itkimage() -> NoReturn:
    """Run the paramap2itkimage executable with arguments passed to a Python script."""
    raise SystemExit(_program("paramap2itkimage", sys.argv[1:]))
