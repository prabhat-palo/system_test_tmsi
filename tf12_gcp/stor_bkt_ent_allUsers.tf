resource "google_container_cluster" "primary" {
  provider = google
  name = "my-gke-cluster"
  location = "us-central1"
  initial_node_count = 1
  // GCP Kubernetes Engine Clusters have Legacy Authorization enabled
  // $.resource[*].google_container_cluster.*.*[*].enable_legacy_abac anyTrue
  enable_legacy_abac = true

  tags = {
    Name = "google_container_cluster"
  }
}

resource "google_storage_bucket" "static-site" {
  name = "image-store.com"
  location = "EU"
  force_destroy = true
  versioning {
    enabled = false
  }
  tags = {
    Name = "google_storage_bucket"
  }
}

resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.static-site.name
  role = "READER"
  entity = "allUsers"
  tags = {
    Name = "google_storage_bucket_access_control"
  }
}
