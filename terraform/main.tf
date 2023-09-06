terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.53.0"
    }
  }
}

provider "google" {
  credentials = file("path/to/your/gcp/credentials.json") # ציין את נתיב קובץ הכרטיסים שלך
  project     = "your-gcp-project-id" # ציין את זיהוי הפרויקט שלך ב-GCP
  region      = "us-central1" # ציין את האזור הרצוי של GCP
}

resource "google_container_cluster" "example_cluster" {
  name     = "example-cluster"
  location = "us-central1" 

  initial_node_count = 3 # כמות הסרברים הראשונים בקלאסטר

  node_config {
    machine_type = "e2-standard-2" 

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  master_auth {
    username = ""
    password = ""
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
  }
}
