# Be You There
-> Inside this repo, you will find two folders\
a.) BYT-Flutter-App  : This is the Deployment part which is a Flutter application. \
b.) BYT-Server : This is the server part which includes all the algorithms and data.\
## Deployment Part
-> Open the BYT-Flutter-App folder in android studio and build a release apk for this application\
-> Comments are added for every function and global variables for easy understanding of our code.\
## Server Part and Business logic 
-> This server is created on Flask using Python. To run the server you need to install Python of verion >= 3.6. You can install Python using this [link](https://realpython.com/installing-python/)\
-> It has been tested to work with the latest version of Flask, Flask 1.1.2. To install Flask on your system, use the following command
`pip install Flask`\
-> Server also requires certain other depedencies, which can be installed using following commands\
`pip install numpy`\
`pip install asyncio`\
`pip install json`\
`pip install threading`\
`pip install traceback`\
-> Since this project is currenlty deployed on replit.com, replit database is used and for it replit module is being used. You can check out the deployed server [here](https://replit.com/@SiddharthG123/BYT-Server)\
-> To run this in your local server, you can remove `from replit import db` and add this line just initialize the db variable as a global variable along graph. Change the code in line 303 to `global graph, db` and add this code at 304 `db = {}`.\
-> To start the server run the following line in the shell, `python3 main.py`\
-> Voila, the BYT server will be started!\
