```bash
# this will build the attributes in default.nix: { repo, myDerivation }
$ nix-build

# first, see default.nix, which fetches a repo in repo and then makes a derivation that consumes it

# example outPath of importing the repo
$ nix-instantiate --eval -E '(import ./default.nix {}).repo.outPath'
"/nix/store/c3kf5dz3cgzpx9nf070s8ar640bfr2xm-source"

# myDerivation's src is set to this, so it is the same
$ nix-instantiate --eval -E '(import ./default.nix {}).myDerivation.src.outPath'
"/nix/store/c3kf5dz3cgzpx9nf070s8ar640bfr2xm-source"

# this is the result of the output of myDerivation
$ nix-instantiate --eval -E '(import ./default.nix {}).myDerivation.outPath'
"/nix/store/mg6nzcv641d9r2wdgaxxv50nwavkcy06-my-derivation"

# note, the output from fetching the repo has .git removed,
# but otherwise does contain the repo fetched at the provided rev,
# and this result is checked with the sha256 attribute.
$ ls /nix/store/c3kf5dz3cgzpx9nf070s8ar640bfr2xm-source -a
.                default.nix  Makefile          README.md
..               .gitignore   packages.json     src
CONTRIBUTING.md  LICENSE      psc-package.json  .travis.yml

# this could have been in either order
# 'result' is the result of 'myDerivation'
$ cat result/output
I am a build phase using /nix/store/c3kf5dz3cgzpx9nf070s8ar640bfr2xm-source.

# 'result-2' is the result of 'repo'
$ ls result-2/
CONTRIBUTING.md   .gitignore        Makefile          psc-package.json  src/
default.nix       LICENSE           packages.json     README.md         .travis.yml
```
