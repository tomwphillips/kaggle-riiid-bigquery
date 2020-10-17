# kaggle-riiid-bigquery

Code to set up a Google Cloud project and load the data from the [Riiid Answer Correctness Prediction competition](https://www.kaggle.com/c/riiid-test-answer-prediction/overview) into BigQuery.

## Requirements

* [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
* [`gcloud`](https://cloud.google.com/sdk/docs/install)

## Create Google Cloud project

```
gcloud auth application-default login  # if not already
echo 'google_billing_account = "YOUR_BILLING_ACCOUNT"' > terraform.tfvars
terraform init
terraform apply
```

## Load data into BigQuery

The data is large enough to be annoying if your internet connection has a slow upload speed.
Instead, run [`load_data.ipynb` in Colab](https://colab.research.google.com/github/tomwphillips/kaggle-riiid-bigquery/blob/main/load_data.ipynb) to download the data from Kaggle and upload it to BigQuery.

## dbt

The `riiid` directory contains a [dbt](https://getdbt.com) project to manage and work with the data in BigQuery.
You need to set up a dbt profile in `~/.dbt/profiles.yml`.
Check the [docs](https://docs.getdbt.com/dbt-cli/configure-your-profile), but mine looks like:

```
riiid:
  target: dev
  outputs:
    dev:
      type: bigquery
      method: oauth
      project: my_google_project_id
      threads: 1
      timeout_seconds: 300
      schema: dev
```

