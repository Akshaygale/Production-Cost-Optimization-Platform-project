import boto3
import datetime
import json
import os
import datetime

# Current date
today = datetime.date.today().isoformat()  # e.g., "2026-01-01"

# Create S3 key with folder structure
filename = f"cost-reports/{today}/cost-report.json"

# Upload to S3
s3.put_object(
    Bucket=S3_BUCKET,
    Key=filename,
    Body=data
)
# Environment variables from Lambda
S3_BUCKET = os.environ.get("S3_BUCKET")

# AWS clients
ce = boto3.client("ce")  # Cost Explorer
s3 = boto3.client("s3")

def lambda_handler(event, context):
    # Define time period
    end = datetime.date.today()
    start = end - datetime.timedelta(days=1)

    # Get cost data
    response = ce.get_cost_and_usage(
        TimePeriod={
            'Start': str(start),
            'End': str(end)
        },
        Granularity='DAILY',
        Metrics=['UnblendedCost']
    )

    # Prepare JSON data
    filename = f"cost-report-{str(end)}.json"
    data = json.dumps(response, indent=4)

    # Save to S3
    s3.put_object(
        Bucket=S3_BUCKET,
        Key=filename,
        Body=data
    )

    print(f"Cost report uploaded to s3://{S3_BUCKET}/{filename}")
    return {"status": "success"}


OST_THRESHOLD = 50  # in USD

# Suppose response contains total cost
total_cost = float(response['ResultsByTime'][0]['Total']['UnblendedCost']['Amount'])

if total_cost > COST_THRESHOLD:
    message = f"Alert! Daily AWS cost is ${total_cost}, above threshold ${COST_THRESHOLD}"
    sns.publish(
        TopicArn=SNS_TOPIC_ARN,
        Subject="AWS Daily Cost Alert",
        Message=message
    )