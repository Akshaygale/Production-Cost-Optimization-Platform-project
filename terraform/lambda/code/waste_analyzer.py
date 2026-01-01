import boto3
import os
import datetime
import json

SNS_TOPIC_ARN = os.environ.get("SNS_TOPIC_ARN")
sns = boto3.client("sns")

# Example: underutilized EC2 instances found
underutilized = ["i-1234567890abcdef0", "i-0987654321fedcba0"]

if underutilized:
    message = f"Underutilized EC2 instances detected: {underutilized}"
    sns.publish(
        TopicArn=SNS_TOPIC_ARN,
        Subject="AWS Cost Optimization Alert",
        Message=message
    )
    print("SNS alert sent:", message)
else:
    print("No underutilized instances found")
today = datetime.date.today().isoformat()

filename = f"waste-reports/{today}/waste-report.json"

s3.put_object(
    Bucket=S3_BUCKET,
    Key=filename,
    Body=json.dumps(underutilized)
)

# Environment variables from Lambda
SNS_TOPIC_ARN = os.environ.get("SNS_TOPIC_ARN")

# AWS clients
ec2 = boto3.client("ec2")
sns = boto3.client("sns")

def lambda_handler(event, context):
    # List all instances
    instances = ec2.describe_instances()
    underutilized = []

    for reservation in instances['Reservations']:
        for instance in reservation['Instances']:
            state = instance['State']['Name']
            instance_id = instance['InstanceId']
            # Example logic: check if stopped
            if state == "stopped":
                underutilized.append(instance_id)

    # Send alert via SNS if underutilized instances found
    if underutilized:
        message = f"Underutilized EC2 instances: {underutilized}"
        sns.publish(
            TopicArn=SNS_TOPIC_ARN,
            Subject="AWS Cost Optimization Alert",
            Message=message
        )
        print(message)
    else:
        print("No underutilized EC2 instances found.")

    return {"status": "success", "underutilized": underutilized}
