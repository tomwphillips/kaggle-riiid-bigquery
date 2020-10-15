variable "google_billing_account" {
  type = string
}

provider "google" {
}

locals {
  project_name = "riiid"
  region       = "europe-west2"
}

resource "random_id" "project_id" {
  prefix      = "${local.project_name}-"
  byte_length = 10
}

resource "google_project" "riiid" {
  name            = local.project_name
  project_id      = random_id.project_id.hex
  billing_account = var.google_billing_account
}

resource "google_project_service" "project_service" {
  project = google_project.riiid.project_id

  service = each.key

  for_each = {
    for i in [
      "bigquery.googleapis.com",
      "bigquerystorage.googleapis.com",
      "cloudresourcemanager.googleapis.com",
      "cloudbilling.googleapis.com",
      "compute.googleapis.com",
      "iam.googleapis.com",
      "storage-api.googleapis.com",
      "storage-component.googleapis.com"
    ] : i => i
  }
}

resource "google_bigquery_dataset" "raw" {
  dataset_id = "raw"
  project    = google_project.riiid.project_id
  location   = "EU"
}

output "project_id" {
  value = google_project.riiid.project_id
}

output "bigquery_dataset_raw_id" {
  value = google_bigquery_dataset.raw.dataset_id
}
