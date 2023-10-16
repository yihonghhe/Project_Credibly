<style>
  .leaderboard-table {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
  }

  .leaderboard-entry {
    flex: 0 0 calc(33.33% - 10px); /* Adjust the width as needed */
    margin: 5px;
    text-align: center;
  }
</style>

## Model Leaderboard

<div class="leaderboard-table">
  <div class="leaderboard-entry">
    <p>Baseline Model - XGBoost</p>
    <img src="./images/baseline_result.jpg" width="400" alt="Baseline Model">
  </div>
  
  <div class="leaderboard-entry">
    <p>Imputation</p>
    <img src="./images/imputation_result.jpg" width="400" alt="Imputation">
  </div>
  
  <div class="leaderboard-entry">
    <p>2-Stage Modeling</p>
    <img src="./images/2_stage_modeling_result.jpg" width="400" alt="2-Stage Modeling">
  </div>
  
  <div class="leaderboard-entry">
    <p>Ensembling</p>
    <img src="./images/ensembling.jpg" width="400" alt="Ensembling">
  </div>
</div>
## Getting Started

### Prerequisites

- Python (v-3.10.4)
- Libraries: pandas, scikit-learn, xgboost, etc.

### Installation

1. Clone the repository:

```bash
git clone https://github.com/yihonghhe/Project_Creditbly.git
```
