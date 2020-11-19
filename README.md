# Text Summarisation

This is a side project in which I've created an app using R Shiny to take any well-formatted text and summarise it into a subset of sentences. I have implemented the text summarisation methods desribed [in this paper](https://www.cs.bham.ac.uk/~pxt/IDA/text_summary.pdf). The functions for the summarisation are described in the `helper_functions.R` script - I've built them up manually according to the steps defined in the paper. I would welcome any correction in the functions or discrepancies between the paper and my implementation. 

Presently the app does no inherent data cleaning of the input text so it is assumed that the user is entering clean text. The code for the app is in the `app.R` script - it does no error handling and enforces no upper bound on the number of summarised sentences to return. However, if the user tries to return summarised sentences that are greater than the number of sentences in the input text, the underlying functions will break and you will see an error. 

## Web App

I've deployed the Shiny app as a web app via Dockerhub using Azure. The details of the Docker file which generates the app is in `Dockerfile`. The live app can be found [here](https://text-summariser.azurewebsites.net/). 

