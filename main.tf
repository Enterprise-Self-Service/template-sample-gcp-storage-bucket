resource "google_storage_bucket" "secure_bucket" {
  name     = var.bucket_name
  location = var.location
  public_access_prevention = "enforced"
  
  versioning {
    enabled = var.versioning_enabled
  }

  dynamic "logging" {
    for_each = var.logging_enabled ? [1] : []
    content {
        log_bucket        = var.logging_enabled ? var.log_bucket : null
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

  encryption {
    default_kms_key_name = var.encryption_key
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
