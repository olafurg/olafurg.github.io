### Building and running your application

When you're ready, start your application by running:
`docker compose up --build`.

### Deploying your application to the cloud

First, build your image, e.g.: `docker build -t myapp .`.
If your cloud uses a different CPU architecture than your development
machine (e.g., you are on a Mac M1 and your cloud provider is amd64),
you'll want to build the image for that platform, e.g.:
`docker build --platform=linux/amd64 -t myapp .`.

Then, push it to your registry, e.g. `docker push myregistry.com/myapp`.

Consult Docker's [getting started](https://docs.docker.com/go/get-started-sharing/)
docs for more detail on building and pushing.

### Cleaning up (Resetting the environment)

To ensure a completely clean state (removing all installed gems and data in the volume), run:

`docker compose down -v`

The `-v` flag is critical—it deletes the sticky `bundle_data` volume where gems are stored. This forces a fresh `bundle install` the next time you run `docker compose up`.

If you also want to rebuild the Docker image from scratch (ignoring layer cache):

`docker compose build --no-cache`
