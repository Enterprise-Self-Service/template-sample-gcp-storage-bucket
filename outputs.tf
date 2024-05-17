output "bucket_name" {
  value = google_storage_bucket.secure_bucket.name
}

output "bucket_self_link" {
  value = google_storage_bucket.secure_bucket.self_link
}