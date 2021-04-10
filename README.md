# DriveZy
# Ride Sharing Application Similar to Uber/Lyft using AI/ML to predivt the ride fare
Java enterprise web application which is similar to Uber and Lyft ride booking application that allows customer to book Shared or solo ride. We are using ML model to predict increase or decrease for the rider fare 

***

## Getting Started
•	Download/Clone all files on local system which contains all java, python code and all other project files that requires for project execution  
•	Start Tomcat and MySQL Server  
•	run MySQL Database script for creating Project Database structure on local system  
•	run the fare_api.py using "python fare_api.py" command for starting flask api for getting taxi fare from machine learning model  
•	enter the URL "localhost:/8080/DriveZy" on browser (8080 Tomcat Port)  
•	Follow the screenshots.pdf for exploring project features Prerequisites  

***

### Prerequisites
•	Java SE (v7 and above)  
•	Python (v2.7 and above)  
•	Tomcat (v8 and above)  
•	MySQL Database server  
•	Anaconda (for Package dependencies)   

***

### Technologies used in the application

•   Java Servlets  
•   HTML5 & CSS3  
•   MySQL Database  
•   MySQL CRUD Operations  
•   Application User Roles (Rider/Driver/Admin)  
•   Data Analytics & Visualizations  
•   Python  
•   Jupyter Notebooks  
•   JavaScript  
#### _Others:_

•   Google Maps, Places & Distance Matrix APIs  
•   Dask for handling large amount of data (100 million records which don't fit in memory) and extraction useful data from the said data  
•   Numpy, Scipy & Pandas for Data - Cleaning & Analysis  
•   scikit-learn for Machine Learning Model - Selection, Creation & Evaluation  
•   RandomForestRegression - machine learning algorithm to estimate fare for a ride based on the distance, duration  
•   google distance matrix api) & number of perople sharing the ride  

***

### Dataset used for the application

The Chicago City Data Portal's Transportation Network Providers - Trips dataset has been used for this application. The dataset contains 100,717,116 records of ridesharing trips, starting November 2018, reported by Transportation Network Providers (sometimes called rideshare companies) to the City of Chicago as part of routine reporting required by ordinance. It contains trip start & end times, trip miles, trip total, pickup areas and many more informations for each trip.

From this dataset, we took 1 million records with only [Trip Miles, Trip Total, Shared Trip Authorized, Trips Pooled] columns using random sampling. This was done as the 100 million records did not fit into memory and the random sampling feature of pandas gives a very good sub sample of a dataset with same mean, variance & standard deviation.

 ***
 
## Contributing  
•	https://www.kaggle.com/  
•	https://github.com/  

