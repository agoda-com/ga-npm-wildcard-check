# Stops People merging Wild card References in Package.json

The Problem? In recalculating package dependencies npm/yarn will elect to do automatic updates if you are using wild card expressions. A lot of people use things such as ^ which will only update patch version, but even in large libraries like AngularJs we see breaking changes in patch versions, so on our larger critical projects we made the decision to block this practice and only bump versions as a part of a conscious decision by an Engineer.

We find that most of the time when these are introduced it accidental as some package management tools will automatically add the wild card expressions.

This Action will allow you to check a package json and if a developer has added an expression it explodes, preventing teh build from passing.

## Inputs

### `packagejson-file-full-path`

**Required** The full path to the package json file for your application.

## Example usage

```yaml
jobs:    
  package-alpha:
    name: Npm version wildcard check
    steps:
      - uses: actions/checkout@v2    
      - uses: agoda-com/ga-npm-wildcard-check@v1
        with:
          packagejson-file-full-path: 'src/clientside/package.json'
```