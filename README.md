# Author list for the PSD Detector Group

Python app that fetches the names of the group members from the official PSI webpage and formats them for use in scientific papers. 

### Setup

Create a conda environment with the dependencies. 

```
conda create -n myenv --file=conda/environment.yml
conda activate myenv
```

Launch the development server

```
uvicorn names:app --reload 

# Optionally port and host can be supplied
uvicorn names:app --reload --port 5000 --host your-hostname
```