
resource "oci_core_instance" "core" {
  display_name        = "core-${count.index}"
  compartment_id      = "${var.compartment_ocid}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.availability_domains.availability_domains[0],"name")}"
  shape               = "${var.core["shape"]}"
  subnet_id           = "${oci_core_subnet.subnet.id}"

  source_details {
    source_id   = "${var.images[var.region]}"
    source_type = "image"
  }

  create_vnic_details {
    subnet_id           = "${oci_core_subnet.subnet.id}"
    hostname_label = "core-${count.index}"
  }

  metadata {
    ssh_authorized_keys = "${var.ssh_public_key}"

    user_data = "${base64encode(join("\n", list(
      "#!/usr/bin/env bash",
      "password=${var.core["password"]}",
      file("../scripts/core.sh")
    )))}"
  }

  freeform_tags = {
    "Quickstart" = "{\"Deployment\":\"TF\", \"Publisher\":\"Neo4j\", \"Offer\":\"neo4j-enterprise\",\"Licence\":\"byol\"}"

    "otherTagKey" = "otherTagVal"
  }

  count = "${var.core["core_count"]}"
}

output "Core server public IPs" {
  value = "${join(",", oci_core_instance.core.*.public_ip)}"
}

output "Core server private IPs" {
  value = "${join(",", oci_core_instance.core.*.private_ip)}"
}
