resource "google_storage_bucket" "secure_bucket" {
  name     = var.bucket_name
  location = var.location
  
  versioning {
    enabled = var.versioning_enabled
  }

  dynamic "logging" {
    for_each = var.logging_enabled ? [1] : []
    content {
        log_bucket        = var.log_bucket
        log_object_prefix = "log/"
    }
  }

  labels = var.labels

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 90
    }
  }

  dynamic "encryption" {
    for_each = var.encryption_key != "" ? [1] : []
    content {
        default_kms_key_name = var.encryption_key
    }
  }

  uniform_bucket_level_access = var.uniform_bucket_level_access
}

resource "google_storage_bucket_iam_member" "prevent_public_access" {
  bucket = google_storage_bucket.secure_bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"

  depends_on = [google_storage_bucket.secure_bucket]

  lifecycle {
    prevent_destroy = true
  }
}
