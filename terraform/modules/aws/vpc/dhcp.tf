resource "aws_vpc_dhcp_options" "dhcp" {
  domain_name = "${ var.region == "us-east-1" ? "ec2.internal" : "${ var.region }.compute.internal" }"

  domain_name_servers = [
    "AmazonProvidedDNS",
    "1.1.1.1",
  ]

  tags = "${ merge(
    map(
      "Name",
      "${ var.name_prefix }_dhcp_options"
    ),
    var.tags,
    module.constants.tags_default )
  }"
}

resource "aws_vpc_dhcp_options_association" "dhcp" {
  vpc_id          = "${ aws_vpc.vpc.id }"
  dhcp_options_id = "${ aws_vpc_dhcp_options.dhcp.id }"
}
