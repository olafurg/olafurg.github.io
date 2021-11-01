# olafurg.github.com
Personal website using [Middleman](https://middlemanapp.com/) - some notes to self.

[olafurg.com]](https://olafurg.com)

Branches:
 * `source`: Source code for the Middleman website. Development here. A push to this branch deploys automatically to Cloudflare Pages.
 * `master`: Generated static website. If using GitHub Pages, the site would be served from here. _Not used at the moment._

To make changes:
* Make changes in the `source` branch or a new local branch from there, eventually merged back to `source`.
* Deployment:
  * Push to GitHub's `source` branch.
  * Cloudflare Pages will detect the change and deploy automatically.
  * In case of Terraform changes (e.g. DNS or security settings), Terraform Cloud will detect and apply those changes.

## Cloudflare and Terraform
The site is proxied through Cloudflare. Everything's managed with Terraform. 

State is stored in Terraform Cloud and applied on a push to GitHub (default directory) if `terrafrom plan` is successful.