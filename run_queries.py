"""Run every view in sql/ on Google's public GA4 Google Merchandise Store sample
and save each result to results/.

Signs in with your Google account (a browser window opens the first time).

usage: GCP_PROJECT=your-project-id python run_queries.py
"""
import glob
import os

import pydata_google_auth
from google.cloud import bigquery

PROJECT = os.environ["GCP_PROJECT"]  # any Google Cloud project; the BigQuery sandbox is free

creds = pydata_google_auth.get_user_credentials(
    ["https://www.googleapis.com/auth/bigquery"], use_local_webserver=True
)
client = bigquery.Client(project=PROJECT, credentials=creds)
os.makedirs("results", exist_ok=True)

for path in sorted(glob.glob("sql/*.sql")):
    name = os.path.splitext(os.path.basename(path))[0]
    df = client.query(open(path).read()).to_dataframe()
    df.to_csv(os.path.join("results", f"{name}.csv"), index=False)
    print(f"{name}: {len(df)} rows")
