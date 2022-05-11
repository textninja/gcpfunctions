resource "google_project_service" "cloudfunctions_api" {
  project = google_project.self_destruct_project.name
  service = "cloudfunctions.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudbuild_api" {
  project = google_project.self_destruct_project.name
  service = "cloudbuild.googleapis.com"
  disable_on_destroy = false
}

resource "null_resource" "cloudresourcemanager_api" {
  triggers = {
    project_id = google_project.self_destruct_project.name
  }

  provisioner "local-exec" {
    command = "gcloud services enable cloudresourcemanager.googleapis.com --project ${google_project.self_destruct_project.name}"
  }
}
