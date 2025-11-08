<img width="2048" height="3044" alt="image" src="https://github.com/user-attachments/assets/867b7482-4dff-4e30-87be-1abc9356fb3d" />


## Harvester | Hyperconverged Infrastructure
Harvester is an open-source hyperconverged infrastructure (HCI) solution developed by SUSE (formerly by Rancher Labs). It provides virtualization and Kubernetes integration on bare-metal servers, designed to be an alternative to proprietary virtualization stacks like VMware vSphere, Proxmox, or Nutanix, but built entirely with open-source technologies.

Hyperconverged infrastructure (HCI) is
an IT framework that combines compute, storage, networking, and virtualization into a single, software-defined system that runs on commodity hardware. This model simplifies data center management by consolidating traditionally separate components into a single platform managed by a unified software interface, leading to lower costs, greater agility, and easier scalability. HCI pools resources, making them easy to allocate to virtual machines as needed

#### 🧩 Key Features: :
   - **Virtualization on Kubernetes**: Create, manage, and migrate VMs natively inside Kubernetes.
   - **Integrated Storage**: Built-in distributed block storage with snapshot and backup support.
   - **Networking**: Multiple NICs per VM via Multus CNI.VLAN support and external network attachment definitions.
   - **Cluster Management**: Add or remove nodes easily.Supports HA control plane and live migration.
   - **Rancher Integration**: Manage Harvester and RKE2/K3s clusters under the same Rancher interface.
   - **VM Templates**: Predefine hardware and network configurations for consistent deployment.


🧠 Architecture Overview:
```
🧱 Kubernetes
🧱 KubeVirt
🧱 Longhorn
🧱 Harvester Controller
🧱 MetalLB + Multus
🧱 Rancher Integration
```
     

🚀 Deployment Options
```
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```





