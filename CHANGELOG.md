# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

<br/>

## [Unreleased]
### Added
- Added support for infinity and negative infinity using \infty LaTeX macro
- Added info logging for tikz usage in LaTeX and shell-escape requirements for pdflatex

### Fixed
- Fixed structure description handling for unary operations, and increased test cases
- Refactored CHANGES to CHANGELOG.md
- Refactored fallback method to use ViewString over String
- Refactored FFEs to use \times
- Refactored matrix handling to use \langle and \rangle for angled brackets

<br/>

## [v1.1] - 2022-12-05 (current release)
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
