resource "yandex_compute_instance" "jenkins_instance" {
  for_each = {for vm in var.each_vm: vm.vm_name => vm}
  name            = each.value.vm_name
  hostname        = each.value.vm_name
  platform_id     = each.value.platform_id
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.osfamily.image_id
      type     = each.value.disk_type
      size     = each.value.disk_volume
    }
  }
  scheduling_policy {
    preemptible = each.value.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.jenkins_vm_sg.id]
    nat       = each.value.use_nat
  }
  allow_stopping_for_update = each.value.stopping_for_update
  metadata = {
    serial-port-enable = each.value.serial_port_enable
    ssh-keys           = "${var.default_user}:${local.ssh_pub_key}"
  }
}
