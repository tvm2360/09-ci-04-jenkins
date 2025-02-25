output "all_inst" {
  value = [for inst_jen in yandex_compute_instance.jenkins_instance : {
      name = inst_jen.name
      ip =  inst_jen.network_interface.0.nat_ip_address
    }
  ]
}
