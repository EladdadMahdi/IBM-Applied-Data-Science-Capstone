# IBM Data Science professional certificate Applied Capstone Project : SpaceX Falcon 9 First‑Stage Landing Prediction

<!-- AUTO BADGES -->
![scikit-learn](https://img.shields.io/badge/scikit_learn-1.8.0-blue.svg)
![pandas](https://img.shields.io/badge/pandas-2.2.3-green.svg)
![numpy](https://img.shields.io/badge/NumPy-1.26.4-yellow.svg)
<!-- /AUTO BADGES -->


<img width="430" height="117" alt="image" src="https://github.com/user-attachments/assets/4d9a443a-a6b4-4e4a-923f-198199892c9a" />

## Project Overview

This repository contains an end‑to‑end data science capstone project focused on predicting the landing outcome of the SpaceX Falcon 9 first stage. The motivation is that accurately predicting whether the first stage will land and be reused allows better estimation of launch costs and a deeper understanding of how mission parameters (payload mass, orbit, launch site, customer, etc.) affect reusability [attached_file:1][web:21].

The project implements a full ML pipeline, from raw data acquisition using the official SpaceX REST API and web scraping, through data wrangling and SQL‑based exploratory data analysis (EDA), to machine learning models that classify landing outcomes. Interactive visualizations and dashboards are used to surface insights for both technical and business stakeholders [attached_file:1][web:22].

> **Key results (to fill in later)**
> - Best model: `<MODEL_NAME>`
> - Test accuracy: `<ACCURACY>`
> - Precision / Recall / F1: `<PREC> / <REC> / <F1>`
> - ROC–AUC: `<ROC_AUC>`
> - Top features: `<FEATURE_1>`, `<FEATURE_2>`, `<FEATURE_3>`

---

## Objectives

The project is structured into several modules, each building on the previous one, similar to the IBM Applied Data Science Capstone SpaceX project structure [attached_file:1][web:25]:

1. **Data collection through API**  
   - Request and ingest launch data from the official SpaceX API.  
   - Normalize nested JSON responses into structured tabular formats suitable for analysis.

***Data Collection and Ingestion Flow***

```mermaid
graph LR
    A["Data Collection using GET<br/>request to the SpaceX API"]
        --> B["Decode response as JSON<br/>and load into DataFrame<br/>using json_normalize()"]
        --> C["Data cleaning process"]
        --> D["Falcon 9 rocket web scraping<br/>from Wikipedia using BeautifulSoup"]
        --> E["Parse HTML tables<br/>into DataFrame"]
        --> F["Export to CSV<br/>for future analysis"]
````

2. **Data collection with web scraping**  
   - Scrape external sources (e.g., Wikipedia Falcon 9 launch logs, mission pages) using BeautifulSoup.  
   - Enrich the dataset with payload details, customer information, and orbit metadata.
     
#### Web Scraping Pipeline

```mermaid
graph LR
    A["Apply HTTP GET<br/>method to request<br/>Falcon 9 HTML page"] 
        --> B["Create BeautifulSoup<br/>object from HTML response"]
        --> C["Extract all column names<br/>from HTML table header"]
        --> D["Create DataFrame by<br/>parsing launch HTML tables"]
        --> E["Export data to CSV"]
```

3. **Data wrangling and feature engineering**  
   - Clean, filter, and merge heterogeneous data sources.  
   - Handle missing values and engineer a binary target for first‑stage landing success.  
   - Create informative features from payload, orbit, launch site, vehicle, and customer attributes.

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

---

## Data Sources

### SpaceX REST API

Primary data is obtained from the public SpaceX API v4, which exposes launch, rocket, core, payload, and site information [web:21][web:23]:

- Base URL: `https://api.spacexdata.com/v4/`
- Main endpoints:
  - `launches`
  - `cores`
  - `payloads`
  - `launchpads`
  - `landpads`

Key fields used:

- **Launches**: flight number, date, rocket ID, launchpad ID, cores list, payloads list, mission success flag.  
- **Cores**: core serial, block/version, reuse count, landing attempt, landing success, landing type, landpad.  
- **Payloads**: payload ID, name, type, mass in kg, orbit, customer(s).  

### Web‑scraped data

To complement the API data, public Falcon 9 launch tables and mission pages (e.g., Wikipedia) are scraped using BeautifulSoup, following common approaches in other SpaceX capstone repositories [attached_file:1][web:22]:

- Extracted fields:
  - Payload/operator names when missing or aggregated in API.
  - More detailed orbit labels (e.g., SSO vs. generic LEO).
  - Mission notes about landing attempts (ASDS vs. RTLS vs. expended).

---

## Data Wrangling and Feature Engineering

Data wrangling consolidates API and scraped data into a single analytical dataset:

- **Cleaning**:
  - Remove obvious duplicates and inconsistent records.  
  - Standardize categorical values (e.g., site names, customers).  
  - Handle missing values (e.g., impute `payload_mass_kg` by orbit‑specific medians).

- **Target engineering**:
  - Define a binary target `landing_success` ∈ {0,1}.  
  - Success = landing attempt was made and reported as successful (ASDS or RTLS).  
  - Failure = landing attempt failed or the booster was expended/no landing attempt (depending on project definition; document your choice clearly).

- **Key features**:
  - Payload: `payload_mass_kg`, number of payloads per launch, payload type.  
  - Orbit: raw orbit plus an `orbit_class` (LEO, MEO, GTO, GEO, SSO, etc.).  
  - Vehicle: core serial, booster version/block, `reuse_count`.  
  - Operations: launch site, landing site, landing type (ASDS/RTLS/Ocean/None), year and month of launch.  
  - Customer: primary customer, plus a high‑level category (commercial, government, SpaceX/internal).

- **Encoding and scaling**:
  - One‑hot encode categorical variables (orbit_class, launch_site, customer_type, booster_version).  
  - Standardize numeric features (payload mass, reuse count, year, optional distances).

Outputs of this stage typically include:

- `data/processed/merged_spacex_launches.csv`  
- `data/features/train_features.csv`  
- `data/features/test_features.csv`

---

## Exploratory Data Analysis

### SQL‑based EDA

The curated tables are loaded into a database (e.g., SQLite/Db2) to perform SQL‑driven analysis, as in the IBM capstone labs [attached_file:1][web:25]:

Examples:

- Year‑over‑year landing success rates.
- Success rates by launch site and orbit.
- Average payload mass by orbit class.
- Top customers by number of launches.

This step validates data quality and surfaces high‑level trends before modeling.

### Visualization‑based EDA

Using Python visualization libraries (Matplotlib, Seaborn, Plotly):

- **Success vs. payload mass**: scatter plots and trend lines.  
- **Success vs. orbit**: bar charts of success rate per orbit class.  
- **Success vs. launch site**: bar or heatmap plots by site and year.  
- **Correlation analysis**: heatmaps of numeric feature correlations.

These analyses help identify non‑linear relationships, inform feature selection, and expose potential covariate shift.

---

## Geospatial Analysis with Folium

Geospatial exploration uses Folium to create interactive maps, as in the IBM launch site location module [attached_file:1][web:22]:

- Map launchpads and landing sites (ASDS vs. RTLS vs. ocean) with markers.  
- Color‑code markers by landing success or landing type.  
- Optionally compute approximate distances between launch and landing sites and incorporate them as model features.

This helps understand geographic patterns, such as the difference between East Coast and West Coast operations.

---

## Machine Learning Pipeline

### Problem formulation

- **Task**: Binary classification — predict whether the Falcon 9 first stage will successfully land.  
- **Input**: Engineered mission features (payload, orbit, site, booster history, customer, temporal variables).  
- **Output**: Predicted probability of landing success and a class label.

### Models implemented

In line with the IBM Applied Data Science Capstone structure, multiple supervised learning models are trained and compared [attached_file:1][web:21]:

- Logistic Regression  
- Support Vector Machine (SVM)  
- Decision Tree Classifier  
- k‑Nearest Neighbors (k‑NN)  

You can optionally add Random Forest or Gradient Boosting models.

### Training and evaluation

Typical pipeline:

1. Split data into training and test sets with stratification on `landing_success`.  
2. Build a preprocessing pipeline with:
   - One‑hot encoding for categorical features.  
   - StandardScaler for numeric features.
3. Use cross‑validation (e.g., 5‑fold) on the training set.  
4. Perform hyperparameter tuning with `GridSearchCV` for each model.  
5. Evaluate the best estimator from each model family on the held‑out test set.

Metrics reported:

- Accuracy  
- Precision  
- Recall  
- F1‑score  
- ROC–AUC  
- Confusion matrix  

Summary of results :

```text
Model               Accuracy  Precision  Recall  F1-score  ROC-AUC
------------------  --------  ---------  ------  --------  -------
Logistic Regression  <VAL>     <VAL>      <VAL>   <VAL>     <VAL>
SVM                  <VAL>     <VAL>      <VAL>   <VAL>     <VAL>
Decision Tree        <VAL>     <VAL>      <VAL>   <VAL>     <VAL>
k-NN                 <VAL>     <VAL>      <VAL>   <VAL>     <VAL>
```
### Repository Structure:

``` text
├── data/
│   ├── Module_1 /
|       ├──               #
│   ├── Module_2/
|        ├──          # Cleaned and merged datasets
│   ├── Module_3/
|        ├──
|   ├── Module_4/
|   ├── Module_5/             # Train/test feature matrices
├── notebooks/
│   ├── 1_data_collection_api.ipynb
│   ├── 2_web_scraping.ipynb
│   ├── 3_data_wrangling.ipynb
│   ├── 4_eda_sql.ipynb
│   ├── 5_eda_visualization.ipynb
│   ├── 6_geospatial_analysis.ipynb
│   └── 7_ml_modeling.ipynb
├── dashboards/
│   ├── spacex_dash_app.py       # Plotly Dash app
├── requirements.txt             # Python dependencies
├── .github/workflows/update_badges.yml  # Python dependencies badges
├── README.md                    # Project documentation
```
### Acknowledgments

- IBM and Coursera for the Applied Data Science Capstone template and instructional material.
- SpaceX for providing public launch data through the SpaceX API.
- The open‑source Python data science community for the tools that make this project possible.


