
terraform {
  required_providers {
    harvester = {
      source  = "harvester/harvester"
      version = "~> 0.6.2" # or the latest version
    }
  }
}

provider "harvester" {
  # Path to kubeconfig file
  kubeconfig = "./modules/provider/harvester.yaml"
  kubecontext = "harvester"
}
