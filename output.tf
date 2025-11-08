
output "vm1_ip_address" {
  description = "The IP address of the VM1 instance"
  value       = harvester_virtualmachine.vm1.status[0].interfaces[0].ip
}
