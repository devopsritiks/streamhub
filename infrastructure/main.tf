module "vpc" {
  source = "./modules/vpc"

  vpc_cidr       = "10.0.0.0/16"
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  azs            = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
}

module "eks" {
  source = "./modules/eks"

  cluster_name       = var.cluster_name
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnets
  node_instance_type = var.node_instance_type
  desired_capacity   = var.desired_capacity
  min_size           = var.min_size
  max_size           = var.max_size
}
