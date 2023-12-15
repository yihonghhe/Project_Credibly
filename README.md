**Credibly Credit Risk Prediction Project**

Team: Credibly

This repository contains the codebase for Credibly's Credit Risk Prediction project. The project aims to integrate multiple data timelines, adapting to new data inputs and improving the precision of future credit risk forecasts.

**Project Structure**

**Notebooks:**

  `2_stage_modeling.ipynb`: Implements a 2-stage modeling method.

  `baselin_modeling.ipynb`:Implements a baseline modeling method.

  `Ensembling.ipynb`: Implements an ensemble method.

  `imputation.ipynb`: Implement imputation techniques.

  

**Datasets:**

   `datasets`: Directory of all datasets containing historical and new data, given by our client Credibly.

**Results:**

  `images`: Directory of all AUC graphs of different methods.

**Code Overview**



* **Example of data exploration (from ensembling.ipynb):**
    * Interpolation for missing values:

        for feature in numeric_features:


            interpolator = interp1d(df['submission_year'], df[feature], kind='linear', fill_value='extrapolate')


            interpolated_values = pd.Series(interpolator(df['submission_year']), name=feature)


            df[feature].fillna(interpolated_values, inplace=True)

    * Imputation of missing values:

        from sklearn.impute import SimpleImputer


        imputer = SimpleImputer(strategy="median")


        numeric_cols = df.select_dtypes(include=['number']).columns


        df[numeric_cols] = imputer.fit_transform(df[numeric_cols])

    * Separation data into training and validation sets:

        train_df = df[df['TrainVal'] == 'Train_60']


        val_df = df[df['TrainVal'] == 'Val_40']

* **Example of imputation techniques (from imputation.ipynb)**

        from sklearn.impute import SimpleImputer


        # Impute missing values with median


        imputer = SimpleImputer(strategy="median")


        numeric_cols = df.select_dtypes(include=['number']).columns


        df[numeric_cols] = imputer.fit_transform(df[numeric_cols])

* **Example of hyperparameter tuning (from ensembling.ipynb):**

                 from sklearn.linear_model import LogisticRegression


        from sklearn.feature_selection import SelectFromModel


        # Initialize Logistic Regression model


        log_reg = LogisticRegression(penalty="l1", solver="liblinear")


        # Define the parameter grid


        param_grid = {'C': [0.001, 0.01, 0.1, 1, 10, 100, 1000]}


        # Perform GridSearchCV


        clf = GridSearchCV(log_reg, param_grid, cv=5)


        clf.fit(X_train, y_train)

* **Example of defining parameter grid for XGBoost model(from imputation.ipynb):**

        import xgboost as xgb


        from sklearn.model_selection import GridSearchCV


        # Define the parameter grid for XGBoost


        param_grid = {


            'learning_rate': [0.005, 0.01, 0.05, 0.1],


            'max_depth': [3, 4, 5],


            'n_estimators': [200, 250, 300, 350],


            'subsample': [0.4, 0.5, 0.6, 0.7],


            'colsample_bytree': [0.6, 0.7, 0.8]


        }


        # Perform GridSearchCV


        clf = xgb.XGBClassifier()


        grid_search = GridSearchCV(clf, param_grid, scoring='roc_auc', cv=3, verbose=1)


        grid_search.fit(X_train_new, y_train)

* **Example of cross validation (from ensemling.ipynb):**

        from sklearn.model_selection import KFold


        kf = KFold(n_splits=2, shuffle=True, random_state=42)


        X_train_old_list = []


        X_train_new_list = []


        X_train_full_list = []


        y_train_list = []


        valid_indices_list = [] 


        for train_index, valid_index in kf.split(train_df):


            train_fold = train_df.iloc[train_index]


            valid_indices_list.append(valid_index)  _# Store the validation indices_



#### **Key Features:**



* **Imputation Techniques:**
    * Implemented imputation using strategies such as median/mode imputation to handle missing data in short history values.
* **Two-Stage Modeling:**
    * Introduced a 2-stage modeling approach for interpretability and robustness.
    * First stage involves training on long-history features.
    * Second stage incorporates scores generated in the first stage with new data.
* **Ensembling Methodology:**
    * Built multiple models using stacking techniques (mean and XGBoost) to refine predictions.
    * Ensured a more accurate and stable prediction by combining diverse feature lists.
* **Cross Validation:**
    * Employed 2-fold Cross-Validation on training data to prevent data leakage and ensure unbiased model evaluation.
* **Hyperparameter Tuning:**
    * Fine-tuned models through GridSearchCV exploration of hyperparameters for improved accuracy.
* **Feature Engineering:**
    * Utilized z-score normalization and Lasso Regularization for enhanced AUC and reduced overfitting.


### **Outcome**

The 2-stage model outperformed ensembling with an ROC_AUC score of 0.67, striking a balance between performance and complexity.


### **Issues/Challenges**



* **Data Leakage and Overfitting:**
    * Addressed challenges in 2-stage modeling and ensembling by implementing 2-fold Cross-Validation to prevent data leakage and overfitting.
* **Handling Missing Values and Feature Selection:**
    * Dealt with datasets containing missing values and excessive features through collaboration and a grid search strategy.


### **Future Work**

While achieving the project's primary goals, future work may involve:



* Further exploration of the reasoning behind the 2-stage model's performance.
* Investigation into the impact of feature selection on model performance.
* Applying additional model-tuning techniques to enhance overall performance.


### **Handoff Documentation**

Detailed handoff documentation can be found[here](https://docs.google.com/document/d/1gpl7nRPgEBtwFj7584yCGlJA-2Dt5ofMaalV61lb6B8/edit?usp=sharing). 

**How to Use**

1. Open each Jupyter Notebook (`*.ipynb`) in a Jupyter environment.



* Clone the repository: 
    * git clone https://github.com/yihonghhe/Project_Creditbly.git

2. Execute cells in sequential order to reproduce results.

3. Ensure the `original_dataset.xlsx` file is in the datasets directory.

**Dependencies**

- Python (v-3.10.4)

- Jupyter Notebook

- Libraries: pandas, numpy, xgboost, scikit-learn, matplotlib, openpyxl

Feel free to reach out to the project team for any questions or clarifications.
