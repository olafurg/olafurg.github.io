# olafurg.github.com
Personal website using [Middleman](https://middlemanapp.com/) - some notes to self.

Branches:
 * ```source```: Source code for the Middleman website. Development here. In case of deploying through Netlify (currently the case) then deployment is from here.
 * ```master```: Generated static website. If using GitHub Pages, the site is served from here on [olafurg.com](http://olafurg.com).

To make changes:
* Make changes in the ```source``` branch or a new local branch from there, eventually merged back to ```source```.
* Netlify deploy: Push to GitHub. Netlify will detect a new push to this branch and trigger a deployment automatically.
* GitHub Pages:
  * Merge those changes into the ```master``` branch.
  * Generate and deploy changes using ```middleman deploy --build-before``` from the command line.

Todo:
* Update Bootstrap
