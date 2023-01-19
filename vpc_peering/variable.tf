variable "peer_owner_id" {
    description = "AWS owner ID"
    type = string
    default =  "833995681443" 
}

variable "peer_owner_cidr" {
    description = "Peer cennection sender cidr"
    type = string
    default =  "10.0.0.0/16" 
}

variable "peer_accepter_cidr" {
    description = "Peer cennection accepter cidr"
    type = string
    default =  "10.20.0.0/16" 
}