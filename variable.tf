variable "sqlname" {
  default = "my-terraform-sql"
}
variable "sqlregion" {
  default = "asia-south1"
}
variable "sqltier" {
  default = "db-f1-micro"
}
variable "sqlversion" {
  default = "MYSQL_8_0"
}
variable "vpcsql" {
  default = "vpcsqlterra"
}
variable "subnetsql" {
  default = true
}
variable "staticip" {
  default = "staticsqlip"
}
variable "vmname" {
  default = "sqlvmname"
}
variable "vmtype" {
  default = "f1-micro"
}
variable "vmzone" {
  default = "asia-south1-a"
}
variable "region" {
  default = "asia-south1"
}
variable "sqlfirewall" {
  default = "sqlvmfirewall"
}
variable "sqluser" {
  default = "sqlvmuser"
}
variable "dbname" {
  default = "sqldb"
}