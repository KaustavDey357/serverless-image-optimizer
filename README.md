
# 🖼️ Serverless Image Optimizer on AWS

A fully serverless, cost-efficient image optimization pipeline built using **AWS Lambda**, **Amazon S3**, and **API Gateway**. This project automatically compresses any image uploaded to an S3 bucket and stores the optimized version alongside the original.

---

## 🧰 Tech Stack

- AWS Lambda (Python 3.11)
- Amazon S3 (Event trigger)
- API Gateway (optional REST endpoint)
- AWS IAM (Role-based access)
- Python Pillow library (for image processing)

---

## 📌 Architecture

```text
            ┌────────────┐
            │  Upload    │
            │  Image     │
            └────┬───────┘
                 │
         ┌───────▼────────┐
         │     S3 Bucket  │
         └───────┬────────┘
                 │  (Event Trigger)
         ┌───────▼────────┐
         │    AWS Lambda  │
         │  Compresses    │
         └───────┬────────┘
                 │
         ┌───────▼────────┐
         │ Optimized Image│
         │ Saved in S3    │
         └────────────────┘
````

---

## 🚀 Features

* Automatically compresses `.jpg`/`.jpeg`/`.png` images uploaded to S3.
* Stores optimized images with the prefix `optimized-`.
* Uses AWS Free Tier resources.
* Includes deployment and teardown scripts to **avoid unwanted charges**.
* Extensible via API Gateway for programmatic image optimization.

---

## 📂 Project Structure

```bash
serverless-image-optimizer/
├── lambda/
│   └── handler.py             # Lambda function code
├── deploy/
│   ├── create_resources.sh    # Script to deploy resources
│   ├── delete_resources.sh    # Script to tear down resources
│   └── trust-policy.json      # IAM trust policy
├── requirements.txt           # Lambda dependencies
├── test-images/               # Sample images for testing
└── README.md
```

---

## 🛠️ Setup Instructions

### 1. Clone the repository

```bash
git clone https://github.com/your-username/serverless-image-optimizer.git
cd serverless-image-optimizer
```

### 2. Configure AWS CLI

Make sure you have the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) installed and configured:

```bash
aws configure
```

### 3. Install dependencies locally (optional, for testing)

```bash
pip install -r requirements.txt
```

### 4. Deploy resources to AWS

```bash
bash deploy/create_resources.sh
```

> This will create:
>
> * An S3 bucket (edit name inside script)
> * An IAM role for Lambda
> * A Lambda function with event trigger from the S3 bucket

---

## 🔄 Usage

Upload an image to your S3 bucket via console or AWS CLI:

```bash
aws s3 cp test-images/sample.jpg s3://your-bucket-name/
```

After a few seconds, a new file called `optimized-sample.jpg` will appear in the same bucket.

---

## 🧯 Tear Down

To avoid AWS charges, run:

```bash
bash deploy/delete_resources.sh
```

This will delete the Lambda function, IAM role, and S3 bucket.

---

## 📸 Example Output

| Original Image | Optimized Image        |
| -------------- | ---------------------- |
| `sample.jpg`   | `optimized-sample.jpg` |

> Compression is \~40–60% depending on image quality.

---

## 💡 Improvements for Later

* Integrate with API Gateway to optimize images via POST requests
* Add file size logging via CloudWatch
* Use Terraform or AWS SAM for cleaner IAC

---

## 🛡️ Cost Management

This project is safe to run under the AWS Free Tier:

* ✅ Lambda: 1M requests/month free
* ✅ S3: 5GB storage free
* ✅ API Gateway: 1M REST API calls/month free (if enabled)

**⚠️ Don’t forget to tear down the resources when done!**

---

## 📢 Author

**Kaustav Dey** – DevOps & Cloud Enthusiast

* GitHub: [@KaustavDey357](https://github.com/KaustavDey357)
* LinkedIn: [linkedin.com/in/KaustavDey357](https://www.linkedin.com/in/kaustav-dey-107593244?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app)
* Portfolio: [KaustavDey357.github.io](https://KaustavDey357.github.io)
* Dev.to : [https://dev.to/kaustav_dey_/](https://dev.to/kaustav_dey_/)

---
