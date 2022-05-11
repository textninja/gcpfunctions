resource "google_service_account" "main" {
  project = google_project.self_destruct_project.name
  account_id = "project-deleter"
  display_name = "Project Deleter"
}

resource "google_project_iam_custom_role" "main" {
  project = google_project.self_destruct_project.name
  role_id = "ProjectDeleter"
  title = "Project Deleter"
  description = "A project deleter has the ability to shut down the current project."
  permissions = [
    "resourcemanager.projects.delete"
  ]
}

resource "google_project_iam_binding" "main" {
  project = google_project.self_destruct_project.name
  role = google_project_iam_custom_role.main.id

  members = [
    "serviceAccount:${google_service_account.main.email}"
  ]
}
