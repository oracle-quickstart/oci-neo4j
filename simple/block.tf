
# totally unused block volumes for testing

# Volume 1
resource "oci_core_volume" "CoreVolume1" {
  count = "${var.core["core_count"]}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.availability_domains.availability_domains[0],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "Node ${format("%01d", count.index)} Volume 1"
  size_in_gbs         = 700
  freeform_tags = {"Quickstart"="{\"Deployment\":\"TF\", \"Publisher\":\"Neo4j\", \"Offer\":\"neo4j-enterprise\",\"Licence\":\"byol\"}","otherTagKey"="otherTagVal"}
}

resource "oci_core_volume_attachment" "NodeAttachment1" {
  count = "${var.core["core_count"]}"
  attachment_type = "iscsi"
  compartment_id  = "${var.compartment_ocid}"
  instance_id     = "${oci_core_instance.core.*.id[count.index]}"
  volume_id       = "${oci_core_volume.CoreVolume1.*.id[count.index]}"
}
