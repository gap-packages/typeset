# Welcome to the typeset GAP package contributing guide <!-- omit in toc -->

Thank you for investing your time in contributing to this package! :sparkles:

In this guide you will get an overview of the contribution workflow from opening an issue, creating a PR, reviewing, and merging the PR.

Use the table of contents icon on the top left corner of this document to get to a specific section of this guide quickly.

## New Contributor Guide

Welcome! To get an overview of the package, read the [README](README.md). Here are some resources to help you get started with open source contributions:

- [Finding ways to contribute to open source on GitHub](https://docs.github.com/en/get-started/exploring-projects-on-github/finding-ways-to-contribute-to-open-source-on-github)
- [Set up Git](https://docs.github.com/en/get-started/quickstart/set-up-git)
- [GitHub flow](https://docs.github.com/en/get-started/quickstart/github-flow)
- [Collaborating with pull requests](https://docs.github.com/en/github/collaborating-with-pull-requests)


## Getting started

### Issues

#### Create a new issue

If you spot a problem or find something you want to add, [search if an issue already exists](https://docs.github.com/en/github/searching-for-information-on-github/searching-on-github/searching-issues-and-pull-requests#search-by-the-title-body-or-comments). If a related issue doesn't exist, you can open a [new issue](https://github.com/gap-packages/typeset/issues/new). 

#### Solve an issue

Scan through the [existing issues](https://github.com/gap-packages/typeset/issues) to find one that interests you. You can narrow down the search using `labels` as filters. See [Labels](https://github.com/gap-packages/typeset/labels) for more information. As a general rule, we don’t assign issues to anyone. If you find an issue to work on, you are welcome to open a PR with a fix.

### Types of Contributions

If you are looking to implement or extend the `typeset` framework, there are two main contribution paths you can take - creating a new package dependent on `typeset`, or via a [pull request](#pull-request) on this package repository. Steps for creating a new package can be found on the main [GAP documentation](https://docs.gap-system.org/doc/ref/chap76_mj.html), or through usage of the [PackageMaker](https://github.com/gap-system/PackageMaker) GAP package. 

Creating a new package may be ideal for developers who want to implement several different things at once, whereas pull requests are likely more suited for developers whose sole goal is typesetting.

#### Supporting a new typesetting language

To implement the `typeset` framework for a new typesetting language, there are a small number of steps that should make the process as smooth as possible. 

First, it is best to create a new directory named after the language within the `gap` sub-directory of this package - just to keep things organised!

Within this directory, you'll want to have at least two files, a _lang_.gd and a _lang_.gi. These files will follow the typical layout for GAP declaration and implementation files, and will contain the language-specific functions for your new implementation.

Once your files have been created, the next step will be implementing the operation to generate template strings for your language. As described in the [documentation](http://gap-packages.github.io/typeset/doc/chap1_mj.html), the framework works by calling language-specific functions to generate language-specific template strings followed by populating them with a language-agnostic list of semantic features pertaining to the GAP object being typeset. 

Therefore, you'll want to implement a method of the name Gen<em>Lang</em>Tmpl (only the first letter of the language should be capitalised) for any and all of the types you're looking to typeset. It may also be a good idea to have a default fallback to the core GAP method `String`, as many objects may not even need any specific changes to get them typeset!

Beyond this template string generation, there may be a small number of other language-specific helper methods that will need to be created (e.g. `CtblLegendLatex` for character tables in LaTeX). This does depend heavily on the types of GAP objects you're looking to typeset and for most cases following what has been done in the LaTeX implementation of this framework should suffice.

With this, you should now have a working implementation of the `typeset` framework, congrats! :tada:

Now, before you can get all your changes committed, make sure to document your code and methods cleanly, and add tests to ensure everything you've written works as expected. 

Documentation is fairly standard for GAP, and should at minimum include comments above declarations within .gd files, and some section header comments in your .gi files.

Make sure to add any new directories to [makedoc.g](makedoc.g) under the `scan_dirs` record value or else it won't get picked up. Any new chapters and sections should also be added to [order_info.g](order_info.g) for documentation ordering purposes.

Tests should also be contained within their own language-specific directory under the `tst` sub-directory for consistency, but the range of tests you write is up to you and simply needs to prove that your implementation works as expected.

#### Extending support for new GAP types

Extending the package to support other GAP types (that may be implemented in other packages, or just not currently supported in the latest version) follows a slightly different process. 

If you're looking to support a type implemented in another package, first decide if it's worth simply implementing the framework in the other package and making `typeset` a dependency. If not, it is preferred that support for these external packages are kept in separate files named after the package itself under the `gap` sub-directory.

To ensure the implemented methods are only installed if the external package is available, ensure you add a call to `IsPackageMarkedForLoading` when adding the new files to [init.g](init.g) and [read.g](read.g).

If you're looking to simply add support for a type that is available as part of the GAP core distribution, then feel free to make additions to the files [gap/typeset.gi](gap/typeset.gi) and [gap/typeset.gd](gap/typeset.gd).

As supporting new types is seen as language-agnostic, the main concern for you as a developer will be installing a new method for the operation `GenArgs`. At it's core, this method should return a **list** of strings that would likely be used to populate a template string representing this new type regardless of the typesetting language. 

Of course, it may not always be possible to make this method perfectly generic, and if that is the case make sure to document exactly what else a developer would need to add to integrate your method into their implementation.

Beyond this, writing a new method for the operation `GenLatexTmpl` within the file latex.gi would provide a way for you to test if your `GenArgs` methods would integrate nicely, as well as provide an example for other developers. As LaTeX was the original focus of this package, this should be done before writing methods for other languages if possible.

Finally, before you can get all your changes committed make sure to document your code and methods cleanly, and add tests to ensure everything you've written works as expected. Documentation is fairly standard for GAP, and should at minimum include comments above declarations within .gd files, and some section header comments in your .gi files. 

Make sure to add any new directories to [makedoc.g](makedoc.g) under the `scan_dirs` record value or else it won't get picked up. Any new chapters and sections should also be added to [order_info.g](order_info.g) for documentation ordering purposes.

Tests should also be contained within their own language-specific directory under the `tst` sub-directory for consistency, but the range of tests you write is up to you and simply needs to prove that your implementation works as expected. Feel free to also write tests for the contents of `GenArgs`, there's no such thing as too many tests!

### Making Changes

#### Make changes in the UI

Click the pencil icon at the top-right of any file to make small changes such as a typo, sentence fix, or a broken link (that only need one file to be edited). This takes you to the file where you can make your changes and [create a pull request](#pull-request) for a review.

#### Make changes locally

1. Fork the repository.
- Using GitHub Desktop:
  - [Getting started with GitHub Desktop](https://docs.github.com/en/desktop/installing-and-configuring-github-desktop/getting-started-with-github-desktop) will guide you through setting up Desktop.
  - Once Desktop is set up, you can use it to [fork the repo](https://docs.github.com/en/desktop/contributing-and-collaborating-using-github-desktop/cloning-and-forking-repositories-from-github-desktop)!

- Using the command line:
  - [Fork the repo](https://docs.github.com/en/github/getting-started-with-github/fork-a-repo#fork-an-example-repository) so that you can make your changes without affecting the original project until you're ready to merge them.

2. Install or update [GAP](https://www.gap-system.org/) to the latest version.

3. Create a working branch and start with your changes!

### Commit your update

Commit the changes once you are happy with them. Don't forget to self-review (i.e. check your changes work, documentation is good, tests are written etc.) to speed up the review process.

### Pull Request

When you're finished with the changes, create a pull request, also known as a PR.
- Fill the "Ready for review" template so that we can review your PR. This template helps reviewers understand your changes as well as the purpose of your pull request. 
- Don't forget to [link PR to issue](https://docs.github.com/en/issues/tracking-your-work-with-issues/linking-a-pull-request-to-an-issue) if you are solving one.
- Enable the checkbox to [allow maintainer edits](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/allowing-changes-to-a-pull-request-branch-created-from-a-fork) so the branch can be updated for a merge.
Once you submit your PR, a Docs team member will review your proposal. We may ask questions or request additional information.
- We may ask for changes to be made before a PR can be merged, either using [suggested changes](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/incorporating-feedback-in-your-pull-request) or pull request comments. You can apply suggested changes directly through the UI. You can make any other changes in your fork, then commit them to your branch.
- As you update your PR and apply changes, mark each conversation as [resolved](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/commenting-on-a-pull-request#resolving-conversations).
- If you run into any merge issues, checkout this [git tutorial](https://github.com/skills/resolve-merge-conflicts) to help you resolve merge conflicts and other issues.

### Your PR is merged!

Congratulations :tada::tada:

Once your PR is merged, your contributions will be publicly visible on the repository.