## Applied Data Science Capstone Project


<img width="430" height="117" alt="image" src="https://github.com/user-attachments/assets/4d9a443a-a6b4-4e4a-923f-198199892c9a" />

### Overview
This project is an end‑to‑end analysis of SpaceX Falcon 9 launch data focused on mission success prediction, launch trends, customer diversity, and payload optimization. The core idea is that predicting whether the first stage will land and be reused allows data‑driven estimation of launch costs and understanding of how mission parameters affect reusability.
​

The work includes a complete ML pipeline: data acquisition from public SpaceX sources, exploratory data analysis (EDA), and feature engineering on variables such as payload mass, orbit type, launch site, and customer. A supervised learning model is trained and evaluated to classify first‑stage landing outcomes, and the results are surfaced through dashboards and visualizations to support technical and business decision‑making.
​
### Methodologies
in this section 
1. **Data collection through API**  
   - Ingest launch data from the official SpaceX REST API and normalize JSON responses into structured tabular formats.

2. **Data collection with web scraping**  
   - Scrape external sources (e.g., launch logs, mission pages) to enrich the dataset with payload details, customer information, and orbit metadata.

3. **Data wrangling**  
   - Clean, filter, and merge heterogeneous data sources; handle missing values; engineer target labels for first-stage landing outcomes; and export curated datasets for analysis and modeling.

4. **Exploratory Data Analysis with SQL**  
   - Use SQL queries to compute aggregates and trends such as yearly success rates, performance by launch site, payload statistics, and customer distribution.

5. **Exploratory Data Analysis with data visualization**  
   - Build visualizations (e.g., success rate vs. payload mass, orbit, launch site, and year) to uncover relationships between mission parameters and landing success.

6. **Interactive visual analytics with Folium**  
   - Create interactive geospatial maps of launch sites and landing outcomes, including proximity analysis to nearby infrastructure, to explore geographic patterns.

7. **Machine learning prediction**  
   - Implement and evaluate supervised learning models (e.g., logistic regression, SVM, decision trees, k-NN) to predict first-stage landing success, forming a deployable ML component that       supports mission success prediction, launch trend analysis, customer diversity insights, and payload optimization.
<!-- AUTO BADGES -->
![scikit-learn](https://img.shields.io/badge/scikit_learn-1.8.0-blue)
![pandas](https://img.shields.io/badge/pandas-2.2.3-green)
![numpy](https://img.shields.io/badge/numpy-1.26.4-yellow)
<!-- /AUTO BADGES -->
