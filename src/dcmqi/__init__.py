"""
Copyright (c) 2024 Leonard Nürnberg. All rights reserved.

dcmqi: Python distribution of the DCMQI library collection.
"""

from __future__ import annotations

import subprocess
import sys
from importlib.metadata import distribution
from pathlib import Path
from typing import Callable, NoReturn

from ._version import version as __version__


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


def _make_wrapper(name: str) -> Callable[[], NoReturn]:
    def _wrapper() -> NoReturn:
        raise SystemExit(_program(name, sys.argv[1:]))

    _wrapper.__name__ = name
    _wrapper.__qualname__ = name
    _wrapper.__doc__ = (
        f"Run the {name} executable with arguments passed to a Python script."
    )
    return _wrapper


def _discover_binaries() -> list[str]:
    """Return names of all executables installed in dcmqi/bin/."""
    files = distribution("dcmqi").files
    if files is None:
        return []
    binaries = []
    for _file in files:
        parts = Path(str(_file)).parts
        if len(parts) == 3 and parts[0] == "dcmqi" and parts[1] == "bin":
            # Strip platform suffix (.exe on Windows)
            name = Path(parts[2]).stem
            binaries.append(name)
    return sorted(binaries)


# Dynamically create wrapper functions for each installed binary
_binaries = _discover_binaries()
for _name in _binaries:
    globals()[_name] = _make_wrapper(_name)

__all__ = ["__version__", *_binaries]  # noqa: PLE0604
