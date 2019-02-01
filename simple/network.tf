
module "vcn" {
  source  = "oracle-terraform-modules/default-vcn/oci"
  version = "1.0.1"
  compartment_ocid = "${var.compartment_ocid}"
  vcn_display_name = "${var.vcn_display_name}"
  # vvv isn't applyable because we're using a module not a a resource
  #freeform_tags = {"Deployment"="TF", "Publisher"="Neo4J", "Offer"="neo4j-enterprise"}
}

resource "oci_core_security_list" "oci_core_default_security_list" {

  display_name   = "security_list"
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${module.vcn.vcn_id}"

  egress_security_rules = [{
    protocol    = "All"
    destination = "0.0.0.0/0"
  }]

  ingress_security_rules = [{
    protocol = "All"
    source   = "0.0.0.0/0"
  }]

}
