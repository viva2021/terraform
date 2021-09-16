provider "aws" {
    region = "eu-central-1"
    shared_credentials_file = "/home/slava/terraform/creds"
    profile = "default"
}

resource "aws_instance" "my_webserver" {
    ami = "ami-05f7491af5eef733a"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.my_webserver.id]
    tags = {
      Name = "Ubuntu_Server_for_MyApp"
      Owner = "Viacheslav Ivanenko"
    }
    user_data = "${file("user_data.sh")}"

}

resource "aws_security_group" "my_webserver" {
    name        = "WebServer Security Group"
    description = "Server_for_MyApp"

    ingress {
        description      = "HTTP"
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    ingress {
        description      = "SSH"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["178.165.77.146/30"]
    }

    egress {
            from_port        = 0
            to_port          = 0
            protocol         = "-1"
            cidr_blocks      = ["0.0.0.0/0"]
            ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "my_webserver"
    }
}
