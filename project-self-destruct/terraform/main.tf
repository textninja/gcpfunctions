resource "google_project" "self_destruct_project" {
  name = var.project
  project_id = var.project
  folder_id     = var.folder_id
  billing_account = var.billing_account
}

resource "google_storage_bucket" "cloud_function_source_bucket" {
  name = "${var.project}-function-bucket"
  project = google_project.self_destruct_project.name
  location = "US"
}

resource "google_storage_bucket_object" "function_source_code" {
  name = "selfdestruct.${filemd5("../build/selfdestruct.zip")}.zip"
  source = "../build/selfdestruct.zip"
  bucket = google_storage_bucket.cloud_function_source_bucket.name
}

resource "google_cloudfunctions_function" "selfdestruct" {
  project = google_project.self_destruct_project.name
  name = "self-destruct"
  description = "Destroy the current project"
  runtime = "nodejs14"
  available_memory_mb = 128
  source_archive_bucket = google_storage_bucket.cloud_function_source_bucket.name
  source_archive_object = google_storage_bucket_object.function_source_code.name
  trigger_http = true
  entry_point = "selfdestruct"
  max_instances = 1
  depends_on = [
    google_project_service.cloudfunctions_api,
    google_project_service.cloudbuild_api,
    null_resource.cloudresourcemanager_api
  ]
  service_account_email = google_service_account.main.email
}
