terraform {
  backend "gcs" {
    bucket = "tf-state-gke-kseniia"
    prefix = "terraform/state"
  }
}

module "gke_cluster" {
  source              = "github.com/KseniiaEvans/tf-google-gke-cluster"
  GOOGLE_REGION       = var.GOOGLE_REGION
  GOOGLE_PROJECT      = var.GOOGLE_PROJECT
  GKE_NUM_NODES       = 2
  DELETION_PROTECTION = false
}
