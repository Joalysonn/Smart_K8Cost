provider "helm" {
  kubernetes {
    config_path = "~/.kube/config" 
  }
}

# Descreve a instalação do Kubecost como um recurso
resource "helm_release" "kubecost" {
  name       = "kubecost"                # Nome da instalação
  repository = "https://kubecost.github.io/cost-analyzer/" # URL do repositório Helm
  chart      = "cost-analyzer"           # Nome do chart
  namespace  = "kubecost"                # Namespace onde será instalado
  create_namespace = true                # Pede para o Terraform criar o namespace se não existir
  version    = "1.108.1"                 # Fixa a versão para garantir consistência (boa prática!)

  # Aqui você pode adicionar configurações personalizadas
  # que normalmente iriam num ficheiro values.yaml
  values = [
    <<-EOT
    kubecostProductConfigs:
      clusterName: "meu-cluster-de-producao"
    EOT
  ]
}
