terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# не уверен полностью в работоспособности tf-файла для AWS
# у меня амазонья учетка залокалась - не могу запускать инстансы EC2
# как разлокают - допилю/проверю

provider "aws" {
  region = "eu-central-1"
}


resource "aws_vpc" "imc_net" {
  cidr_block = "10.0.0.0/16"
  tags = {
    environment = "tf-example"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.imc_net.id
}




resource "aws_subnet" "imc_subnet" {
  vpc_id            = aws_vpc.imc_net.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "eu-central-1a"
  
  map_public_ip_on_launch = true
  depends_on = [aws_internet_gateway.gw]

  tags = {
    environment = "tf-example"
  }
}

resource "aws_network_interface" "imc_nic" {
 count = 5
  subnet_id   = aws_subnet.imc_subnet.id
#  private_ips = ["172.16.10.100"]
  tags = {
    Name = "primary_network_interface ${count.index}"
    environment = "tf-example"
  }
}


resource "aws_key_pair" "pupko" {
  key_name   = "pupko-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDhN0r8K0ERrRBLK5kBgp3XsPBS32LNC60UeN71+J6o42wnJ+CUeOmKT+yIAjSeeOQ7KCG47AitOlylsrkYMa1erHKXptLBBtlXY/kh6+1i2Csu9Jo6rSUkFDN0iHe8kKYZHSk0N34uNn6EwcjPsImUfK0SByPs/SPNsBGsFS3H2McZrWVsJtAC9+KYCYzNDpvYmrsBwNDV9uHmy6q41vpv+LSfaA8bxLwTVvx55mb1Zw0Ff921lDprTGwPnEXL/7zxTu3cYovJetNZdabD26Xaz4IXDRguAWXKhNBeQUt8L86zvHlwbv4bGdMBZ6LPjdAUVo1CYjeC6xrH81AvgvkD"
}

resource "aws_instance" "aws_5nodes" {
  count =5 
  ami           = "ami-0502e817a62226e03"
  availability_zone = "eu-central-1a"
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.imc_nic[count.index].id
    device_index         = 0
  }

#  credit_specification {
#    cpu_credits = "unlimited"
#  }

  #  computer_name  = "imc-awsnode${count.index}"
  #  admin_username = "pupko"
    key_name = "pupko-key"

  tags = {
    Name = "imc-awsnode${count.index}${count.index}"
    environment = "tf-example"
  }

}


