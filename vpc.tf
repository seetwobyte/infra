# Internet VPC
resource "aws_vpc" "bancroft" {
    cidr_block = "10.10.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags {
        Name = "main"
        Purp = "test_env"
        OS = "linux"
    }
}


# Subnets
resource "aws_subnet" "public-A" {
    vpc_id = "${aws_vpc.bancroft.id}"
    cidr_block = "10.0.1.0/25"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"

    tags {
        Name = "public-A"
    }
}
resource "aws_subnet" "public-B" {
    vpc_id = "${aws_vpc.bancroft.id}"
    cidr_block = "10.10.1.128/25"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1b"

    tags {
        Name = "public-B"
    }
}
resource "aws_subnet" "Web-tier-a" {
    vpc_id = "${aws_vpc.bancroft.id}"
    cidr_block = "10.10.2.0/25"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1a"

    tags {
        Name = "web-a"
    }
}
resource "aws_subnet" "web-tier-b" {
    vpc_id = "${aws_vpc.bancroft.id}"
    cidr_block = "10.10.2.0128/25"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1b"

    tags {
        Name = "web-b"
    }
}
resource "aws_subnet" "mgmt-tier-a" {
    vpc_id = "${aws_vpc.bancroft.id}"
    cidr_block = "10.10.3.0/25"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1a"

    tags {
        Name = "mgmt-a"
    }
}
resource "aws_subnet" "mgmt-b" {
    vpc_id = "${aws_vpc.bancroft.id}"
    cidr_block = "10.10.3.128/25"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1b"

    tags {
        Name = "mgmt-b"
    }
}

# Internet GW
resource "aws_internet_gateway" "bancroft-gw" {
    vpc_id = "${aws_vpc.bancroft.id}"

    tags {
        Name = "main"
    }
}

# route tables
resource "aws_route_table" "main-public" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main-gw.id}"
    }

    tags {
        Name = "main-public-1"
    }
}

# route associations public
resource "aws_route_table_association" "main-public-1-a" {
    subnet_id = "${aws_subnet.main-public-1.id}"
    route_table_id = "${aws_route_table.main-public.id}"
}
resource "aws_route_table_association" "main-public-2-a" {
    subnet_id = "${aws_subnet.main-public-2.id}"
    route_table_id = "${aws_route_table.main-public.id}"
}
resource "aws_route_table_association" "main-public-3-a" {
    subnet_id = "${aws_subnet.main-public-3.id}"
    route_table_id = "${aws_route_table.main-public.id}"
}
