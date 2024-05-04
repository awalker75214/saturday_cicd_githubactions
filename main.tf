terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.27.0"
    }
  }
}

provider "google" {
  # Configuration options
    project = var.project
    region = var.region
    zone = "us-central1-a"
    credentials = "milliondollarsofgame-571e697b0f13-KEY.json"
}



# This is the bucket for your state files
resource "google_storage_bucket" "raw74" {
  project = var.project
  name = "${var.data_project}-raw74"
  force_destroy = false
  uniform_bucket_level_access = true
  location = var.region
  labels = local.labels
}

terraform {
    backend "gcs" { 
      bucket  = "gitactionsbucket100"
      credentials = "milliondollarsofgame-571e697b0f13-KEY.json"
      prefix  = "prod"
    }
}


locals {
    labels = {
        "data-project" = var.data_project
    }
}

variable "project" {
    type= string
    default = "milliondollarsofgame"
    description = "ID Google project"
}

variable "region" {
    type= string
    default = "southamerica-east1"
    description = "Region Google project"
}

variable  "data_project" {
    type = string
    default = "saturday_cicd_githubactions"
    description = "Name of data pipeline project to use as resource prefix"
}









