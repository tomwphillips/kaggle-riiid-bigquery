# kaggle-riiid-bigquery

Code to set up a Google Cloud project and load the data from the [Riiid Answer Correctness Prediction competition](https://www.kaggle.com/c/riiid-test-answer-prediction/overview) into BigQuery.

## Requirements

* [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
* [`gcloud`](https://cloud.google.com/sdk/docs/install)

## Create Google Cloud project

```
gcloud auth application-default login  # if not already
echo 'google_billing_account = "YOUR_BILLING_ACCOUNT"' > terraform.tfvars
terraform apply
```

# Load data into BigQuery

The data is large enough to be annoying if your internet connection has a slow upload speed.
Instead, we can do it from a Colab instance.
