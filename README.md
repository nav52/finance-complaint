# Finance-Complaint 

Financial Companies deal with grievance registration and complaint portals on a daily basis.
The sheer volume of the complaints makes it hard for the companies to immediately attend to the urgent and important queries.
This project focuses on gathering the complaint data and classify them based on the sererity in order to aid the company and its employees to attend the most grievent customer on priority.

Data is gathered from [Consumer Financial Protection Bureau](https://www.consumerfinance.gov/data-research/consumer-complaints/)

Data is read from thier API between the dates on monthly basis and stored in Amazon S3.
The feature store is created with the parquet files of the successfully downloaded files.

## Deployment Setup

```yaml
# Aws Secert 
AWS_ACCESS_KEY_ID : <your AWS_ACCESS_KEY_ID >
AWS_SECRET_ACCESS_KEY: <your AWS_SECRET_ACCESS_KEY >
AWS_DEFAULT_REGION: "ap-south-1" 
MONGO_DB_URL: <your Mongo Url >

# Gcp Secert 
GCLOUD_SERVICE_KEY: <json format key>
GOOGLE_COMPUTE_ZONE: asia-south1
GOOGLE_PROJECT_ID: <project id from dashboard>

# Image Secrets
REPOSITORY: finance-complaint
GAR_IMAGE_NAME: finance-complaint
IMAGE_TAG: latest
```

## WorkFLow setup
### Step-1
Create .env file

```
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
MONGO_DB_URL=
TRAINING=1
PREDICTION=1
```
1- Trigger
0- Bypass

Build docker image
```
docker build -t tc:lts .
```

Lauch docker image

```
docker run -it -v $(pwd)/finance_artifact:/app/finance_artifact  --env-file=$(pwd)/.env fc:lts
```


AIRFLOW SETUP

## How to setup airflow

Set airflow directory
```
export AIRFLOW_HOME="/home/nav52/census_consumer_project/census_consumer_complaint/airflow"
```

To install airflow 
```
pip install apache-airflow
```

To configure databse
```
airflow db init
```

To create login user for airflow
```
airflow users create  -e naveenfaster@gmail.com -f Naveen -l Karanth -p admin -r Admin  -u admin
```
To start scheduler
```
airflow scheduler
```
To launch airflow server
```
airflow webserver -p <port_number>
```

Update in airflow.cfg
```
enable_xcom_pickling = True
```

Steps to run project in local system


1. Build docker image
   ```
   docker build -t fc:lts .
   ```
2. Set envment variable
```
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export MONGO_DB_URL=
export AWS_DEFAULT_REGION="ap-south-1"
export IMAGE_NAME=fc:lts
```
3. To start your application
```
docker-compose up
```
4. To stop your application
```
docker-compose down
``` 