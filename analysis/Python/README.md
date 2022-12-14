1. Install [Anaconda](https://docs.anaconda.com/anaconda/install/index.html)
2. Create a new conda environment using:
     ```
    conda create --name <env> --file requirements.txt
    ```
3. Add the new environment to jupyter kernel
    ```
    conda activate <env>
    python -m ipykernel install --user --name=<env>
   ```
4. Make sure you are at the root directory of the repo.  
Install our own package prop13_utils and its source code is under Python/prop13_utils.  
    ```
   cd Python | python setup.py install
   ```
4. Open jupyter notebook
    ```
   jupyter notebook
   ```
