provider "google" {
  project     = "terraform-gcp-468217"
  region      = "us-central1"
  zone        = "us-central1-a"
}
resource "google_storage_bucket" "GCS1" {
    name = "bucket-tf-up"
    location = "us-central1"
}