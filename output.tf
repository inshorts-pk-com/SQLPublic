#****** Public Testing *******
output "staticip" {
    value = google_compute_address.static.address
}
output "SQL_Instance" {
 value = google_sql_database_instance.instance.name
}
output "vm_name" {
  value = google_compute_instance.sqlterra.name
}
output "SQL_Database_Name" {
  value = google_sql_database.sqldb.name
}
output "user" {
    value = google_sql_user.user.name
}