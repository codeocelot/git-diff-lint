# git-diff-lint
Unopinionated lint runner that only lints files that your feature branch has modified.

Many codebases don't start off with good linting standards and adopting a linting standard in a large codebase is rarely non-trivial or easy.  `git-diff-lint` is a tool that allows contributors to enjoy the benefits of linting and automated status checks on their feature branches without requiring the entire project to conform.  `git-diff-lint` only lints files that have been modified since the current branch diverges from it's parent.

`git-diff-lint` is configurable with many popular linters and faithfully preserves the linter exit code meaning it works great as a status check or git pre-push hook.

## Installation
Just download and add command to your system path:

```bash
curl -O https://raw.githubusercontent.com/codeocelot/git-diff-lint/master/git-diff-lint
export PATH=$PATH/$(pwd)
# add to zshrc to use in future sessions
echo "export PATH=\$PATH:$(pwd)" >> ~/.zshrc
# or add to bashrc
echo "export PATH=\$PATH:$(pwd)" >> ~/.bashrc
```

## Usage

```bash
$ git-diff-lint -x eslint -e .js
$ git-diff-lint -x "pycodestyle --statistics" -e .py -b master
```

Executes linter command with the list of modified files compared to parent git branch.  Returns status from linter command and prints any linting errors to stderr.  

### Options:

| flag | env var | purpose | default |
|----|-----|----|----|
| -x | LINT | lint command, e.g. `eslint` | `pycodestyle` |
| -b | BRANCH | parent git branch | stage |
| -e | EXT | file regex expression | `\.py$` |
| -h | \<none\> | Show help message and exit |

## Recipes

#### ESLint

- Lint .js & .jsx files with ESlint:

```bash
git-diff-lint -x "npx eslint" -e ".js$|.jsx" -b stage
# alternatively, using env vars:
EXT=".js$|.jsx$" LINT="npx eslint" BRANCH=stage git-diff-lint
```

#### Node package.json

Escaping strings is annoying in package.json, but doable.

```json
{
  "name": "your-project",
  "scripts": {
    "lint": "EXT=\".js$|.jsx$|.ts$|.tsx$\" LINT=\"npx eslint --ext .js,.jsx,.ts,.tsx\" ./tools/git-diff-lint/git-diff-lint"
  }
}
```

Or create a script file and call it.

```bash
# lint.sh
git-diff-lint -x "npx eslint" -e ".js$|.jsx" -b stage
```

```json
{
  "name": "your-project",
  "scripts": {
    "lint": "./lint.sh"
  }
}
```

## Contributing

Have any ideas on how to make this tool more useful?  PRs are greatly appreciated.  Since this project doesn't have a test suite, please make sure your contribution doesn't break existing functionality and within your PR, please document how to test your proposed feature.

I prefer if you use [commitizen](https://github.com/commitizen/cz-cli) to format your commits, but any reasonable committing strategy is fine.

If you have ideas on how to write tests for this project, please share!

## License

MIT Licensed.  Go forth and create, but please provide attribution back to this project.
