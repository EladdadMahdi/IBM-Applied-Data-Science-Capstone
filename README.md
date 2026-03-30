# IBM Data Science professional certificate Applied Capstone Project : SpaceX Falcon 9 First‑Stage Landing Prediction

<!-- AUTO BADGES -->
![scikit-learn](https://img.shields.io/badge/scikit_learn-1.8.0-blue.svg)
![pandas](https://img.shields.io/badge/pandas-2.2.3-green.svg)
![numpy](https://img.shields.io/badge/NumPy-1.26.4-yellow.svg)
<!-- /AUTO BADGES -->



<img width="430" height="117" alt="image" src="https://github.com/user-attachments/assets/4d9a443a-a6b4-4e4a-923f-198199892c9a" />

[📄 Obtained certificate](./IBM_DS_PROFESSIONAL_CERTIFICATE.pdf)

## Project Highlights

- Project Overview
- Objectives
- Methodology
- Model Insights
- Repository Structure
- Acknowledgement

## Project Overview

This repository implements an end-to-end data science capstone project to predict whether the SpaceX Falcon 9 first stage will successfully land (and be reusable), following the IBM Applied Data Science Capstone structure.

The workflow covers data acquisition (SpaceX API + web sources), data wrangling, EDA (SQL + visualization), interactive analytics (Folium + Dash), and ML classification models.

## Objectives

- Build a reproducible dataset by collecting launch, rocket, core, payload, and site data from the public SpaceX REST API (v4).

- Enrich/validate fields using web-scraped launch tables (e.g., Wikipedia Falcon 9 launch records) and merge sources into one analytical dataset.

- Create a binary target label for first-stage landing success and engineer features relevant to reusability (payload, orbit, site, booster history, etc.).

- Perform EDA using both SQL queries (in a local SQLite workflow) and Python visualizations to understand drivers of success.

- Build interactive dashboards (Dash) and geospatial maps (Folium) to communicate insights.

- Train and compare supervised ML models (e.g., Logistic Regression, SVM, Decision Tree, kNN) and select the best model for landing success prediction.

## Methodology

1. **Data collection through API**

   - Retrieve historical launch records from the SpaceX API and work with nested launch objects that reference rockets, payloads, cores, and launchpads via IDs.

   - Enrich the launch table by resolving these IDs into human-readable fields (e.g., booster version, payload mass/orbit, launch site name + coordinates, and landing outcome attributes).

   - Produce a structured, analysis-ready dataset exported for downstream steps.

_Data Collection and Ingestion Flow :_

```mermaid

   graph LR
   A["Request launches<br/>(SpaceX API)"] --> B["Normalize nested JSON<br/>into launch table"]
   B --> C["Resolve referenced IDs<br/>(rocket, launchpad, payloads, cores)"]
   C --> D["Enrich dataset fields<br/>(BoosterVersion, LaunchSite, coords,<br/>PayloadMass, Orbit, landing outcome)"]
   D --> E["Basic cleaning + column selection<br/>(types, missing values, filters)"]
   E --> F["Export API-derived dataset<br/>to CSV"]

````

2. **Data collection with web scraping**

   - Collect Falcon 9/Falcon Heavy launch records from a fixed Wikipedia snapshot to ensure reproducibility over time.

   - Parse the relevant HTML launch tables into a tabular dataset and extract key columns such as date/time, booster version, payload mass, orbit, customer, launch outcome, and booster landing status.

   - Save the scraped table as a dataset that can be compared/merged with the API-based dataset.

_Web Scraping Pipeline :_

```mermaid

   graph LR
   A["Request Wikipedia page<br/>(fixed snapshot URL)"] --> B["Parse HTML<br/>(BeautifulSoup)"]
   B --> C["Locate launch records table<br/>(wikitable class)"]
   C --> D["Extract column headers"]
   D --> E["Parse rows/cells into<br/>structured table"]
   E --> F["Clean/standardize fields<br/>(text cleanup, units, dates)"]
   F --> G["Export scraped dataset<br/>to CSV"]

```

3. **Data wrangling and feature engineering**

   - Inspect data quality (missing values, data types) and summarize key distributions (launch sites, orbits, and landing outcomes).

   - Convert the detailed "Outcome" field into a binary training label ("Class"): 1 for successful first-stage landing, 0 for unsuccessful/no-landing outcomes (including failed ASDS/RTLS/Ocean and "None" cases).

   - Export the labeled dataset for EDA and modeling.

_Data Wrangling Pipeline :_

```mermaid

   graph LR
   A["Load datasets<br/>(API + scraped CSVs)"] --> B["Profile data quality<br/>(missing values, dtypes)"]
   B --> C["Summarize distributions<br/>(sites, orbits, outcomes)"]
   C --> D["Define failure/no-landing set<br/>(False ASDS/RTLS/Ocean, None)"]
   D --> E["Create binary label<br/>(Class: 1=success, 0=fail)"]
   E --> F["Export labeled dataset<br/>(datasetpart2.csv)"]

````
4. **Exploratory Data Analysis with SQL**
   - Load curated tables into a relational database (SQLite/Db2).
   - Use SQL queries to compute aggregates and trends (yearly success rates, performance by launch site, payload and customer statistics).

5. **Exploratory Data Analysis with visualization**
   - Use Matplotlib, Seaborn, and Plotly to visualize relationships between mission parameters and landing outcomes.
   - Explore success rate vs. payload mass, orbit type, launch site, and time.

6. **Interactive visual analytics with Folium and Dash**
   - Build geospatial maps of launch and landing sites with Folium.
   - Develop an interactive Plotly Dash application for real‑time visual analytics.

7. **Machine learning prediction**
   - Implement and evaluate multiple supervised learning models (Logistic Regression, SVM, Decision Trees, k‑NN, etc.).
   - Perform hyperparameter tuning and model comparison.
   - Use the best model as a reusable component for landing success prediction and cost estimation.

```mermaid

   graph LR
   A["Load labeled dataset"] --> B["Preprocessing"]
   subgraph Preprocess["Preprocessing"]
   B1["Handle missing values"]
   B2["One-hot encode categoricals"]
   B3["Scale numeric features"]
   end
   B --> Preprocess
   Preprocess --> C["Train/Test split"]
   subgraph ML["Model Training"]
   D["Train models<br/>(LogReg, SVM, DT, kNN)"]
   E["Hyperparameter tuning<br/>(GridSearchCV)"]
   end
   C --> ML
   subgraph Eval["Evaluation"]
   F["Test metrics<br/>(Accuracy, Precision, Recall, F1)"]
   G["Confusion matrix analysis"]
   H["Select best model"]
   end
   ML --> Eval

```
## Model Insights

- Best models: SVM, KNN, Logistic Regression (83.33%)

<div align="center">
<img src="images\image.png" width="350">
</div>

- Decision Tree shows overfitting (77.78% test)
- The confusion matrix of our best model (SVM, 83.33%) reveals **3 false positives** - predicting successful landings that actually failed. This over-optimistic bias could lead competitors to underestimate launch costs when benchmarking against SpaceX.

<div align="center">
<img src="images\image-1.png" width="350">
</div>


## Business Impact:

While accuracy is solid at 83.33%, reducing false positives would be critical for cost estimation reliability.

## Repository Structure:

``` text
.
├── .git/
├── .hypothesis/
├── badges/
├── .github/
│   └── workflows/
│       └── update_badges.yml
├── data/
│   ├── Module_1/
│   │   ├── dataset_part_1_data_API_collection.csv
│   │   ├── dataset_part_2_data_wrangling_output.csv
│   │   └── spacex_web_scraped_data.csv
│   ├── Module_2/
│   │   ├── dataset_part_3_eda_dataviz_output.csv
│   │   └── my_data1_eda_sql_output.db
│   ├── Module_3/
│   │   └── spacex_launch_dash.csv
├── dashboards/
│   └── spacex_dash_app.py
├── notebooks/
│   ├── Module_1/
│   │   ├── 1_spacex-data-collection-api.ipynb
│   │   ├── 2_spacex-data-webscraping.ipynb
│   │   └── 3_spacex-data-wrangling.ipynb
│   ├── Module_02/
│   │   ├── 4_eda_sql_sqllite.ipynb
│   │   └── 5_eda_dataviz.ipynb
│   ├── Module_03/
│   │   └── 6_Interactive_Visual_Analytics_With_Folium.ipynb
│   └── Module_04/
│       └── 7_Machine_Learning_Prediction.ipynb
├── requirements.txt
└── README.md
```

### Acknowledgments

- IBM and Coursera for the Applied Data Science Capstone template and instructional material.
- SpaceX for providing public launch data through the SpaceX API.
- The open‑source Python data science community for the tools that make this project possible.


