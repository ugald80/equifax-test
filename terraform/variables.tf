variable "projectID" {
  type = string
  default = "equifax-test"
}
//TODO: following variables must be provided using secret manager
variable "db_password" {
  type = string
  default = "equifax-test-377917"
}
variable "google_credentials_file" {
  type = string
  default = "../google-credentials.json"
}
