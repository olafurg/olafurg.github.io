# olafurg.com
Personal website using [Middleman](https://middlemanapp.com/) - some notes to self.

[olafurg.com](https://olafurg.com)

To make changes:
* Make changes in the `main` branch or a new local branch from there, eventually merged back to `main`.
* Deployment:
  * Push to GitHub's `main` branch.
  * Cloudflare Pages will detect the change and deploy automatically.
  * In case of Terraform changes (e.g. DNS or security settings), Terraform Cloud will detect and apply those changes.

## Cloudflare and Terraform
The site is proxied through Cloudflare. Everything infra related is managed with Terraform.

State is stored in Terraform Cloud and applied on a push to GitHub (default directory) if `terrafrom plan` is successful.

## Words
Middleman blogging: https://middlemanapp.com/basics/blogging/

Generating articles: `middleman article TITLE`
