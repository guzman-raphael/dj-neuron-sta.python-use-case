# Summary

Leverages alpine docker compatible with Python3 and DataJoint (+dependencies), installs custom packaged DataJoint [python module](https://github.com/guzman-raphael/dj-neuron-sta.python-module), initializes the DB schema, populates elements of the pipeline, and creates visualizations.


# Instructions

$ bash pkg.sh


# Description

* Note: First time run will trigger an ~11[min] build cycle.


- pkg.sh is to be run from the main repo directory. It controls what processes to trigger to maximize reuse of image.
- docker-compose.yml contains the instructions for mapping of the docker image and mount points:
      - input dir (./client/config) : documents provided for task, connection config file
      - output dir (./client/log) : saved matplot figures as PNG, JSON converted PKL file with np arrays replaced with shape
      - script dir (./client/src) : script that triggers the job (ingestion, population, visualization)
- ./client/dj.dockerfile contains the instructions on how to build an alpine docker with python3 with pip3 packages: datajoint, matplot, graphviz, and my custom package (dj_neuron).
- ./client/docker-entrypoint.sh contains the script that runs on boot. Currently, it simply exists once it has completed executing the ./client/src/run.py script.
- ./client/config/instance.json contains the details for the connection (user,password,DB,schema). This is leveraged by a several functions.
- ./client/config/task-details contains the documents that I was provided for this task.
- ./client/src/run.py contains 5 methods that can be used to DEMO the solution to for this task. They are as follows:
      - createSchemaScratch(HOME Dir, Delay) : Creates the entire pipeline from scratch. It converts the provided PKL file into a combination of manual entry tasks and simulated output files. It then ingests the entire pipeline with dependencies and computations. Takes ~9[min].
      - updateSchemaComputationOnly(Delay) : Replaces the delay value in STRFParams table. Drops the STRFCalcs table, recreates this portion of the schema, and performs computation from parent Neurons. Useful while I was testing different structure arrangements for the table.
      - addComputationComparison(Delay) : Simply adds a delay value into STRFParams and populates child Neuron computations into STRFCalcs.
      - convertTaskDataToJSON(HOME Dir) : Converts provided PKL document into a JSON that substitutes the np array data for a tuple of the shape. Useful in validating when indexing.
      - saveVisualizations(NeuronArray,Shape of figures for STA and Sample Images,HOME Dir) : Displays the first few entries of all tables in console, and saves the following figures: ERD, STA for an array of keys specified in neuros_interest, Spikes plot for array of keys neuros_interest, and Sample movie stills.



# Points for Improvements

- Upload datajoint-alpine image to DockerHub to translate build time to pull time (reduce cost).
- Clean log folder prior to adding outputs.
- Improve documentation.
- Add visualization of different delays on same figure.
- Improve computation runtime.


# Assumptions

- Direct comparison between 2 different delays is not desirable (visualization only).
