each_vm = [
  {
     vm_name = "jenkins-master",
     cpu = 2,
     ram = 4,
     core_fraction = 20,
     disk_type = "network-hdd",
     disk_volume = 20,
     platform_id = "standard-v1",
     preemptible = true,
     use_nat = true,
     stopping_for_update = true,
     serial_port_enable = 0
  },
  {
     vm_name = "jenkins-agent",
     cpu = 2,
     ram = 4,
     core_fraction = 20,
     disk_type = "network-hdd",
     disk_volume = 20,
     platform_id = "standard-v1",
     preemptible = true,
     use_nat = true,
     stopping_for_update = true,
     serial_port_enable = 0
  }
]
