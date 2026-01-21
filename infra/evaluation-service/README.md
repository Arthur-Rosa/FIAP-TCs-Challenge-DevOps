aws sqs send-message \
  --queue-url https://sqs.us-east-1.amazonaws.com/851725193065/evaluation-service-sqs \
  --message-body '{
    "user_id": "user-123",
    "flag_name": "nova-feature",
    "result": true,
    "timestamp": "2026-01-11T20:00:00Z"
  }' \
  --region us-east-1
aws sqs send-message \
  --queue-url https://sqs.us-east-1.amazonaws.com/851725193065/evaluation-service-sqs \
  --message-body '{
    "user_id": "user-123",
    "flag_name": "nova-feature",
    "result": true,
    "timestamp": "2026-01-11T20:00:00Z"
  }' \
  --region us-east-1
aws sqs send-message \
  --queue-url https://sqs.us-east-1.amazonaws.com/851725193065/evaluation-service-sqs \
  --message-body '{
    "user_id": "user-123",
    "flag_name": "nova-feature",
    "result": true,
    "timestamp": "2026-01-11T20:00:00Z"
  }' \
  --region us-east-1
aws sqs send-message \
  --queue-url https://sqs.us-east-1.amazonaws.com/851725193065/evaluation-service-sqs \
  --message-body '{
    "user_id": "user-123",
    "flag_name": "nova-feature",
    "result": true,
    "timestamp": "2026-01-11T20:00:00Z"
  }' \
  --region us-east-1
aws sqs send-message \
  --queue-url https://sqs.us-east-1.amazonaws.com/851725193065/evaluation-service-sqs \
  --message-body '{
    "user_id": "user-123",
    "flag_name": "nova-feature",
    "result": true,
    "timestamp": "2026-01-11T20:00:00Z"
  }' \
  --region us-east-1
aws sqs send-message \
  --queue-url https://sqs.us-east-1.amazonaws.com/851725193065/evaluation-service-sqs \
  --message-body '{
    "user_id": "user-123",
    "flag_name": "nova-feature",
    "result": true,
    "timestamp": "2026-01-11T20:00:00Z"
  }' \
  --region us-east-1
aws sqs send-message \
  --queue-url https://sqs.us-east-1.amazonaws.com/851725193065/evaluation-service-sqs \
  --message-body '{
    "user_id": "user-123",
    "flag_name": "nova-feature",
    "result": true,
    "timestamp": "2026-01-11T20:00:00Z"
  }' \
  --region us-east-1
aws sqs send-message \
  --queue-url https://sqs.us-east-1.amazonaws.com/851725193065/evaluation-service-sqs \
  --message-body '{
    "user_id": "user-123",
    "flag_name": "nova-feature",
    "result": true,
    "timestamp": "2026-01-11T20:00:00Z"
  }' \
  --region us-east-1
aws sqs send-message \
  --queue-url https://sqs.us-east-1.amazonaws.com/851725193065/evaluation-service-sqs \
  --message-body '{
    "user_id": "user-123",
    "flag_name": "nova-feature",
    "result": true,
    "timestamp": "2026-01-11T20:00:00Z"
  }' \
  --region us-east-1


while true; do 
  aws sqs send-message \
    --queue-url https://sqs.us-east-1.amazonaws.com/851725193065/evaluation-service-sqs \
    --message-body '{"user_id":"test","flag_name":"test","result":true,"timestamp":"'$(date -u +%Y-%m-%dT%H:%M:%SZ)'"}' \
    --region us-east-1 > /dev/null 2>&1
  sleep 0.3  
done