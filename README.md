# DCMQI Python Distributions

[![Actions Status][actions-badge]][actions-link]

[![PyPI version][pypi-version]][pypi-link]
[![PyPI platforms][pypi-platforms]][pypi-link]

<!-- SPHINX-START -->

## Overview

`dcmqi` (DICOM (_dcm_) for Quantitative Imaging (_qi_)) is a collection of
libraries and command line tools with minimum dependencies to support
standardized communication of
[quantitative image analysis](http://journals.sagepub.com/doi/pdf/10.1177/0962280214537333)
research data using [DICOM standard(https://en.wikipedia.org/wiki/DICOM)].

This project provides the infrastructure for building the `dcmqi` Python wheels.
For more information about `dcmqi`, please refer to
https://github.com/QIICR/dcmqi.

The Python wheels provided here contain the official `itkimage2segimage`,
`segimage2itkimage`, `tid1500writer`, `tid1500reader`, `itkimage2paramap`, and
`paramap2itkimage` executable, which is sourced from the
[GitHub releases](https://github.com/QIICR/dcmqi/releases).

Once the wheel is installed, a convenient launcher executable is automatically
placed in the PATH for each of the above mentioned libraries. This launcher is
created during installation by pip, leveraging the `[project.scripts]`
configuration defined in the `pyproject.toml` file.

## Platforms

The following platforms are supported by the binary wheels:

| OS           | Arch               |
| ------------ | ------------------ |
| Windows      | 64-bit <br/> ARM64 |
| Linux Intel  | manylinux 64-bit   |
| macOS 10.10+ | Intel              |
| macOS 11+    | Apple Silicon      |

## License

This project is maintained by Leonard Nürnberg, Mass General Brigham. It is
covered by the OSI-approved MIT License.

`dcmqi` is distributed under the OSI-approved MIT License. For further details
regarding `dcmqi`, please visit https://github.com/QIICR/dcmqi.

<!-- prettier-ignore-start -->
[actions-badge]:            https://github.com/ImagingDataCommons/dcmqi-python-distributions/actions/workflows/ci.yml/badge.svg?branch=main
[actions-link]:             https://github.com/ImagingDataCommons/dcmqi-python-distributions/actions/workflows/ci.yml
[pypi-link]:                https://pypi.org/project/dcmqi/
[pypi-platforms]:           https://img.shields.io/pypi/pyversions/dcmqi
[pypi-version]:             https://img.shields.io/pypi/v/dcmqi
<!-- prettier-ignore-end -->
