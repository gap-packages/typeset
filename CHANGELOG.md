# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

<br/>

## [v] - yyyy-mm-dd
### Added

### Fixed

## [v1.2.3] - 2025-07-03 (current release)
## Fixed
- Fixed test suite failing with the next major GAP release.

## [v1.2.2] - 2024-03-01 (current release)
## Fixed
- Excluded digraphs tests when the digraphs package is not loaded

## [v1.2.1] - 2024-02-20
## Fixed
- Fixed test suite failing when minimal dependencies are loaded
- Updated package status to deposited

## [v1.2.0] - 2024-02-05
### Added
- Added interactive demonstrations in Jupyter Notebooks, which can be run through a Binder Instance
- Added support for infinity and negative infinity using \infty LaTeX macro
- Added info logging for tikz usage in LaTeX and shell-escape requirements for pdflatex
- Added (explicit) support for lists, and an option to treat matrices as lists
- Downgraded info logging for ViewString fallback to make it more explicit that it is being used
- Added barebones MathML implementation to demonstrate the extensibility of the framework

### Fixed
- Fixed structure description handling for unary operations, and increased test cases
- Refactored CHANGES to CHANGELOG.md
- Refactored fallback method to use ViewString over String
- Refactored FFEs to use \times
- Refactored matrix handling to use \langle and \rangle for angled brackets

<br/>

## [v1.1] - 2022-12-05
### Added
- Added digraph integration to LaTeX generation with raw dot and dot2tex options
- Implemented rendering methods to allow users to view LaTeX output via MathJax, pdflatex, or Overleaf
- Wrote developer guides for users looking to implement the framework
- Added a CONTRIBUTING file to guide new contributors
- Added PR and Issue templates for easy access
- Opened the GitHub Discussions feature for community engagement

### Fixed
- Renamed package to 'typeset'
- Reworked permutation handling to include \left and \right for LaTeX output
- Overhauled documentation
- Refactored code to use global variables where appropiate

<br/>

## [v1.0] - 2022-11-11
### Added
- Implemented a general options handling to allow alternating sub-call options alongside customisation
- Created package homepage on GitHub Pages
- Added tests for basic capabilities
- Added LaTeX generator notation for fp, pc, perm and matrix groups
- Added LaTeX refactoring for structure description strings
- Added LaTeX generation for rationals, ffe elements, polynomials and character tables
- Created extensible framework for typesetting GAP objects
<br/>
