# Subir serviços na AWS
- EKS
- ECR
- RDS
- Elastic Cache
- DynamoDB
- SQS

# Serviços no Kubernetes
- nginx

Dentro do arquivo de cada API
- namespace (separadores lógicos para aplicações)
- deployment (para gerenciar os Pods, garantindo que eles usem as
imagens do ECR) ( Requests and Limits, Readiness and Liveness )
- service
- service (do tipo ClusterIP)
- secret
- configmap (para injetar URLs de serviços internos e outros dados).
- ingress

- KEDA para HPA
-> ScaleObject que vai monitorar o SQS e escalar de acordo


Access: AKIA4MTWHB5UUCFXYHSR
Secret: 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


851725193065.dkr.ecr.us-east-1.amazonaws.com/analytics-service

851725193065.dkr.ecr.us-east-1.amazonaws.com/auth-service

851725193065.dkr.ecr.us-east-1.amazonaws.com/evaluation-service

851725193065.dkr.ecr.us-east-1.amazonaws.com/flag-service

851725193065.dkr.ecr.us-east-1.amazonaws.com/targeting-service


DB Instance Identifier: feature-flags-auth-db
Database Name: auth_db
Master Username: auth_user
Master Password: Jg2viSox2ao6UQ0C
Master Connection: feature-flags-auth-db.cluster-c01kesg62uh4.us-east-1.rds.amazonaws.com
                   feature-flags-auth-db-instance-1.c01kesg62uh4.us-east-1.rds.amazonaws.com


DB Instance Identifier: feature-flags-flag-db
Database Name: flags_db
Master Username: flags_user
Master Password: ir7H2OWlcscnRCCD
Master Connection: feature-flags-flag-db.cluster-c01kesg62uh4.us-east-1.rds.amazonaws.com


DB Instance Identifier: feature-flags-targeting-db
Database Name: targeting_db
Master Username: targeting_user
Master Password: 9xQBen3LocImRuXq
Master Connection: feature-flags-targeting-db.cluster-c01kesg62uh4.us-east-1.rds.amazonaws.com

Cluster ID: feature-flags-redis-cluster
Node Type: cache.t3.medium
Engine: Redis 7.x

master.feature-flags-redis-cluster.bpkb05.use1.cache.amazonaws.com:6379

replica.feature-flags-redis-cluster.bpkb05.use1.cache.amazonaws.com:6379

feature-flags-analytics-events

Informações do código
Nome da tabela (conforme README): ToggleMasterAnalytics
Chave primária: event_id (tipo String - HASH Key)

https://sqs.us-east-1.amazonaws.com/851725193065/evaluation-service-sqs

