variable "bucket_name" {
  description = "The name of the GCS bucket"
  type        = string
}

variable "location" {
  description = "The location of the bucket"
  type        = string
  default     = "US"
}

variable "versioning_enabled" {
  description = "Whether to enable versioning on the bucket"
  type        = bool
  default     = true
}

variable "logging_enabled" {
  description = "Whether to enable access logging for the bucket"
  type        = bool
  default     = false
}

variable "log_bucket" {
  description = "The name of the bucket to store access logs"
  type        = string
  default     = ""
}

variable "labels" {
  description = "A map of labels to assign to the bucket"
  type        = map()
  default     = {}
}

variable "encryption_key" {
  description = "The KMS key to use for encrypting objects in the bucket"
  type        = string
  default     = ""
}

variable "uniform_bucket_level_access" {
  description = "Whether to enable uniform bucket-level access"
  type        = bool
  default     = true
}