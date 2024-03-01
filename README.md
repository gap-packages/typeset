[![Build Status](https://github.com/gap-packages/typeset/workflows/CI/badge.svg?branch=main)](https://github.com/gap-packages/typeset/actions?query=workflow%3ACI+branch%3Amain)
[![Code Coverage](https://codecov.io/github/gap-packages/typeset/coverage.svg?branch=main&token=)](https://codecov.io/gh/gap-packages/typeset)
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/gap-packages/typeset/HEAD)

# The typeset GAP package
This package implements a framework for automatic typesetting of common GAP objects, 
for the purpose of embedding them nicely into research papers. Currently, an example
implementation has been written specifically for [LaTeX](https://www.latex-project.org/).

The typeset package is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by the Free
Software Foundation; either version 2 of the License, or (at your option) any
later version. See the FSF's own site <https://www.gnu.org/licenses/gpl.html>
for the details.

## Installation
The installation of the package is standard: for details, see GAP reference
manual, chapter [GAP Packages](https://docs.gap-system.org/doc/ref/chap76_mj.html) 
(and if you don't have write access to the Gap installation, type "?GAP root directory"
within GAP to see another relevant part of the manual).

In essence, clone this repository to your GAP package directory. Then, you can load
the package as per normal.

## Documentation
Full information and documentation can be found in the manual, available
as a [PDF](doc/manual.pdf) or as HTML on the package homepage at

<https://gap-packages.github.io/typeset>

Added features for each version of the package are also tracked in the [changelog](CHANGELOG.md).

## Feature Demonstrations
The Binder badge at the top of this file will create a Binder session within which you can browse the 
Jupyter Notebook [demo/demo.ipynb](demo/demo.ipynb) containing some example uses of the package.

## Contributing
If you'd like to contribute to the development of this project, feel free to read
the [contributing guide](CONTRIBUTING.md). All help is greatly appreciated!

## Discussions
If you have any questions, or just want some off-topic discussion, check out the
discussions area of the repository:

  <https://github.com/gap-packages/typeset/discussions>

This is the place to go if you have any new ideas you want to flesh out before
committing to writing out an issue or are having any problems you think might not 
be a bug!

## Bug Reports and Feature Requests
Please submit bug reports and feature requests via the GitHub issue tracker:

  <https://github.com/gap-packages/typeset/issues>

# License
typeset is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by the
Free Software Foundation; either version 2 of the License, or (at your
option) any later version.

For details see the [LICENSE](LICENSE) file.
