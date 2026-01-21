
helm repo add kedacore https://kedacore.github.io/charts
helm repo update

helm install keda kedacore/keda \
  --namespace keda-system \
  --create-namespace \
  --version 2.12.0

kubectl get pods -n keda-system

kubectl get crd | grep keda

kubectl apply -f trigger-authentication.yaml

kubectl apply -f analytics-service-scaledobject.yaml
kubectl apply -f evaluation-service-scaledobject.yaml

kubectl get scaledobjects -n feature-flags

kubectl describe scaledobject analytics-service-scaledobject -n feature-flags
kubectl describe scaledobject evaluation-service-scaledobject -n feature-flags

kubectl get hpa -n feature-flags

while true; do 
  aws sqs send-message \
    --queue-url https://sqs.us-east-1.amazonaws.com/851725193065/evaluation-service-sqs \
    --message-body '{"user_id":"test","flag_name":"test","result":true,"timestamp":"'$(date -u +%Y-%m-%dT%H:%M:%SZ)'"}' \
    --region us-east-1 > /dev/null 2>&1
  sleep 0.3
done

aws sqs send-message \
  --queue-url https://sqs.us-east-1.amazonaws.com/851725193065/evaluation-service-sqs \
  --message-body '{
    "user_id": "user-123",
    "flag_name": "nova-feature",
    "result": true,
    "timestamp": "2026-01-11T20:00:00Z"
  }' \
  --region us-east-1