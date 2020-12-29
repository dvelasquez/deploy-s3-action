# Deploy S3 Github Action 🚀

Github action to deploy a folder to an Amazon S3 bucket. This project is a fork of the excellent work of
[lewandy/vue-s3-deployer](https://github.com/lewandy/vue-s3-deployer). The main differences are:

* No build step included (so you can build the project with yarn or npm)
    * This allows to cache node_modules / yarn / npm 
    * No need to install and compile files again (faster build)
* Official [AWS-CLI docker image](https://hub.docker.com/r/amazon/aws-cli)
* Configurable `DIST` folder (you can specify if is `dist`, `build` or `lib`)
* Configurable `PATH` in bucket (allowing for uploads for PRs, etc.)

## Usage

In your workflow, define a step which refers to the action:

```yaml
      - name: Deploying application to Amazon S3
        uses: dvelasquez/deploy-s3-action@main
        with:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: ${{ secrets.AWS_DEFAULT_REGION }}
          AWS_BUCKET_NAME: ${{ secrets.AWS_BUCKET_NAME }}
          BUCKET_PATH: "" # Or to upload a pull_request: "/pr/${{github.event.number}}"
          DIST_LOCATION_CODE: ./dist
```

### Configuration

These settings are environment variables that the action will use for make the deployment. Below we describe each variable.

| Key | Value | Required | Default |
| ------------- | ------------- | ------------- | ------------- |
| `AWS_ACCESS_KEY_ID` | AWS Access Key. [More info here.](https://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html) | **Yes** | N/A |
| `AWS_SECRET_ACCESS_KEY` | AWS Secret Access Key. [More info here.](https://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html) | **Yes** | N/A |
| `AWS_BUCKET_NAME` | The name of the bucket you're syncing to. For example, `vue-action`. | **Yes** | N/A |
| `BUCKET_PATH` | The region of the bucket. Set to `us-east-1` by default. [Full list of regions here.](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-
| `AWS_DEFAULT_REGION` | The region of the bucket. Set to `us-east-1` by default. [Full list of regions here.](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-
| `DIST_LOCATION_CODE` | Distribution files to be uploaded | **yes** | ./



# Complete workflow example 😁

This is a simple workflow for deploy any JS app using JS S3 deployer action.

```yaml
# This is a basic workflow to help you get started with Vue s3 deployer action

name: Deployment

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2
          
      - name: Get yarn cache directory path 🛠
        id: yarn-cache-dir-path
        run: echo "::set-output name=dir::$(yarn cache dir)"
        
      - name: Cache node_modules 📦
        uses: actions/cache@v2
        id: yarn-cache # use this to check for `cache-hit` (`steps.yarn-cache.outputs.cache-hit != 'true'`)
        with:
          path: ${{ steps.yarn-cache-dir-path.outputs.dir }}
          key: ${{ runner.os }}-yarn-${{ hashFiles('**/yarn.lock') }}
          restore-keys: |
            ${{ runner.os }}-yarn-

      - name: Install dependencies 👨🏻‍💻
        run: yarn --frozen-lockfile
        
      - name: Build dependencies 🛠
        run: yarn build

      - name: Deploying application to Amazon S3
        uses: dvelasquez/deploy-s3-action@main
        with:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: ${{ secrets.AWS_DEFAULT_REGION }}
          AWS_BUCKET_NAME: awesome-bucket
          BUCKET_PATH: "/pr/${{github.event.number}}"
          DIST_LOCATION_CODE: ./dist
```

# Note 👀

Remember store your amazon account credentials in repository secret. Stay safely guys. 😉

# Resources

- https://levelup.gitconnected.com/deploying-vue-js-to-aws-with-https-and-a-custom-domain-name-3ae1f79fe188
- https://developer.okta.com/blog/2018/07/03/deploy-vue-app-aws


# 🤝 Contributing

1. Fork this repository.
2. Create a new branch with the feature name.
3. Commit and set commit message with feature name.
4. Push your code to your fork repository.
5. Create a pull request. 🙂

# ⭐️ Support

If you like this project, You can support me with starring ⭐ this repository.

# 📄 License

[MIT](LICENSE)
