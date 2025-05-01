# BiodiversityWithShiny
Biodiversity Dashoard - Project for Apsilon


1.- This development is using biodiversity data, available on Google Drive, 
    The first thing to do is getting the file biodiversity-data.tar.gz by clicking the link below:
    https://drive.google.com/file/d/1l1ymMg-K_xLriFv1b8MgddH851d6n2sU/view?usp=sharing

  1.1 - Extract biodiversity-data.tar.gz content(multimedia.csv and occurence.csv) to the
        project directory path inside the Data folder.
  1.2 - Open a terminal on the project directory and run the terminal program:
        On Linux: LoadingAndFilteringData.sh
        On Windows: LoadingAndFilteringData.bat (Sometimes on you need to set the path to Rscript)
        
   This will run R, set your actual directory as working directory, read the occurence.csv file and create Data/bioDiversityData.duckdb
   database.


2.- Once the bioDiversityData.duckdb database has been created successfully, go to Dashboard directory, open a terminal and run app.sh or app.bat
    This will allow you to visualize wht the development does an you can start making changes to it.

        
        