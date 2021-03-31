'''

* Project Name: 	Be You There
* Author List:      Siddharth Golecha
* Filename: 		keep_alive.py
* Functions: 		json_to_graph, change_coords, rms_coords, BFS, predictPath,
                    generate, run, keep_alive
* Global Variables:	graph

'''

from flask import Flask, request
from threading import Thread
import numpy as np
import json
import traceback
import asyncio
from replit import db

'''

* Function Name: 	json_to_graph
* Input: 		    fname -> string which is basically the json file name which
                    needs to be converted to graph
* Output: 		    new_dict -> A dictonary which is the graph decoded from the
                    the json file
* Logic:            Opens the file of the given name and converts the data from
                    the file to graph structure
* Example Call:		json_to_graph("graph.json")

'''
def json_to_graph(fname):

  new_graph = {}
  #Open the file fname with file as an alias
  with open(fname) as file:

    #Reads the data stored in the file and replaces '{' and '}' from the data
    temp = file.readlines()[0].replace("{","").replace("}","")
    #Splits the data into a lift when ', "' was encountered
    key_vals = temp.split(", \"")
    #key_vals is iterated for every value with key_val as its value.
    for key_val in key_vals:
      #Spaces in Key_val data is removed and then split into a list called pair
      #of length 2 by ':'
      pair = key_val.strip().split(":")
      #Second half of pair is converted into a list of list by json.loads which
      #is basically a list of coordinates of graph connected to the node
      value = json.loads(pair[1].strip())
      #Each coordinate is converted from list to tuple to allow hashable queries
      #in future
      value = [tuple(val) for val in value]
      #Various charachters and spaces are removed from the string and then split
      #by ',' into x and y coordinates
      temp_key = pair[0].strip().replace("\"","").replace("(","")\
      .replace(")","").split(",")
      #Tuple key is created from temp_key and stored in new_graph dictonary with
      #value as its value
      key = tuple([int(temp_key[0].strip()),int(temp_key[1].strip())])
      new_graph[key] = value


  return new_graph

'''

* Function Name: 	change_coords
* Input: 		    u_x -> User's predicted X coordinate
                    u_y -> User's predicted Y coordinate
* Output: 		    (u_x, u_y) -> A tuple which contains new X and Y coordinates
                    of the user
* Logic:            The new predicted coordinates are travered until they lie
                    over the graph
* Example Call:		change_coords(202,121)

'''
def change_coords(ux,uy):

  graph2 = {}
  start = (ux,uy)
  openList = set()
  #Since the starting coordinate 'start' is already travered, it is added to the
  #openList
  openList.add(start)
  #The loop runs until there is no coordinate left in the openList
  while len(openList) > 0:
          #X and Y coordinates are poped out from the openList and assigned to
          #x and y respectively
          x, y = openList.pop()
          #Checks out if the (x,y) coordinates are there in graph. So, if it
          #does not exist, it traverses and finds a new one
          if (x,y) not in graph:
              graph2[(x,y)] = []
              #Maps all the possible coordinates adjacent to it on (x,y) key
              for i in range(-1,2):
                  for j in range(-1,2):
                          graph2[(x,y)].append((x+i,y+j))
              #All the unqiue values are added to the openList and all the
              #coordinates as the key from the graph2 are removed
              openList = openList | set(graph2[(x,y)])
              openList = openList - set(graph2.keys())
          #If the coordinates exist in graph, it returns x and y as a tuple
          else:
            return (x,y)


'''

* Function Name: 	rms_coords
* Input: 		    coordinates -> An numpy array of coordinates
* Output: 		    Returns root mean coordinate for given array of coordinates
* Logic:            It first squares all the X and Y coordinates, then takes an
                    average value of it and then sqaures it
* Example Call:		rms_coords([[0 0],[10 0]])

'''
def rms_coords(coordinates):
    return (np.sqrt(np.mean(coordinates[:,0]**2)),\
    np.sqrt(np.mean(coordinates[:,1]**2)))

'''

* Function Name: 	BFS
* Input: 		    graph -> Graph with all the connected nodes in the map
                    src -> Starting point from where the path should start
                    dest -> Destination point from where the path should end
                    pred -> Empty dictonary to store predicted path found by the
                    BFS algorithm
                    dist -> Empty dictonary to store distance of nodes from the
                    start for BFS algorithm
* Output: 		    Returns True if a path is found by the BFS algorithm else
                    returns False
* Logic:            Implements BFS algorithm to find a path from starting point
                    to destination. It sets distance of the all the nodes first
                    to a very high value, say 1000000 and starting point as 0.
                    It then explores the graph breadth-wise to find the
                    shortest path from starting point to destination.
* Example Call:		BFS(graph, source, dest, pred, dist)

'''
def BFS(graph, src, dest, pred, dis):

    queue = []
    visited = {}
    #Iterates every node in the graph and adds to various data structures
    for coord in graph:
        #Since one of the coordinates are visited, it marks it as False
        visited[coord] = False
        #All the values are set to high since none of them are visited
        dis[coord] = 1000000
        #All connected notes which have been traversed
        pred[coord] = -1

    #Since the starting point is already visited, it is set to True and its
    #distance is taken as 0
    visited[src] = True
    dis[src] = 0
    #It is then appended in the queue of open nodes which through which we can
    #visit other nodes
    queue.append(src)

    #Iterate while no open nodes are left
    while (len(queue) != 0):
        #Poping the first value from the queue
        u = queue[0]
        queue.pop(0)

        #Iterates through all the nodes connected to the u coordinate
        for i in range(len(graph[u])):
            #If the given node is not visited, set its visited as true and
            #assign it a value 1 more than the parent/previous node
            if (visited[graph[u][i]] == False):
                visited[graph[u][i]] = True
                dis[graph[u][i]] = dis[u] + 1
                #Set the previous node value of graph[u][i] in pred to u.\
                pred[graph[u][i]] = u
                #The current node is added in the queue of open nodes.
                queue.append(graph[u][i])
                #If the current node is the destination, the function retruns
                #True that the shortest path exists.
                if (graph[u][i] == dest):
                    return True
    #If there doesn not exist any path from the source to destination, it
    #returns False
    return False

'''

* Function Name: 	predictPath
* Input: 		    src -> Starting point from where the path should start
                    dest -> Destination point from where the path should end
                    graph -> Graph with all the connected nodes in the map
* Output: 		    path -> A list which stores the shortest path
* Logic:            Calls BFS algorithm to find shortest path from one
                    coordinate to another. If the BFS algorithm retruns true, it
                    iteratively traverses the pred dictonary to find the path
                    from destination to source and returns a reversed path. If
                    there exists no path, it prints "Given source and
                    destination are not connected"
* Example Call:		predictPath((u_x,u_y),end,graph)

'''
def predictPath(source, dest, graph):

    pred={}
    dist={}
    #Checks if there exists a path between source and destination
    if (BFS(graph, source, dest, pred, dist) == False):
        print("Given source and destination are not connected")

    # vector path stores the shortest path
    path = []
    crawl = dest
    #The destination is appended to the list first to traceback the path
    path.append(crawl)

    #Iterate until the value of pred[crawl] is not equal to -1.
    while (pred[crawl] != -1):
        #Adds the coordinate to the path list
        path.append(pred[crawl])
        #crawl is equated to the previous connected node of the current node.
        crawl = pred[crawl]

    #Reversed path is returned with source as first value and destination as
    #last
    return path.reverse()

'''

* Function Name: 	generate
* Input: 		    request -> Request recieved from the app to the server
* Output: 		    json.dumps(returnjson) -> A list which stores the shortest path
* Logic:            Asynchronous function that calculates the position of the
                    user using Monte Carlo simulation technique. First it gets
                    the locations of the beacons from the uuids detected. If no
                    beacons are detected, it shows a default value and False
                    status. It then generates random uniform points in the given
                    radius of the one of the beacons. It then checks which
                    points lie in the intersection of other beacon's range.
                    After that it takes RMS value of the remaining points. If
                    those points don't lie on graph, it changes the coordinates
                    such that it lies over the graph and calculate the path from
                    that predicted coordinate to the destination. At last, it
                    returns a json string with path and status True.
* Example Call:		generate(request)

'''
async def generate(request):
  global graph
  try:
    #Retrieving UUIDS and end coordinate data from the request
    keys = request.json['uuids']
    end = request.json['end']
    #The locations of the beacons are retrieved from the database and stored in
    #a list
    locations = [json.loads(db[key]) for key in keys]
    #If the total number of beacons detected are 0, then it returns default
    #value and fasle status
    if len(locations) == 0:
      returnjson = {'position': [0, 0], 'status': False}
      return json.dumps(returnjson)
    #N random radii are generated
    r = R * np.sqrt(np.random.rand(N, 1))
    #N random angles are generated
    theta = 2 * np.pi * np.random.rand(N, 1)
    #Using polar equaion of circle, random points are generated within the
    #radius of 1st beacon. These are then stacked column wise.
    points = np.column_stack((locations[0][0] + r * np.cos(theta),\
    locations[0][1] + r * np.sin(theta)))
    #The coordinates from other points are iterated
    for coordinates in locations[1:]:
        #(X2-X1)^2 and (Y2-Y1)^2 are first calculated and then checked if they
        #lie within the range of that beacon. Based on intersection of circle.
        x = np.square(points[:,0] - coordinates[0])
        y = np.square(points[:,1] - coordinates[1])
        points = points[x + y <= R*R]

    #Points are then converted to array for calculations
    points = np.array(points)
    #RMS Coordinates are calculated for the common points and round off value is
    #taken till 2 digits
    pred_x, pred_y = np.round(rms_coords(points),2)
    #The predicted values are then multiplied by 5 and converted into int to
    #convert it from meters to pixels.
    u_x, u_y = int(np.round(pred_x*5)), int(np.round(pred_y*5))
    #If the now user's coordinates don't lie in graph, they are changed
    #accordingly
    if (u_x,u_y) not in graph:
      u_x, u_y = change_coords(u_x,u_y)

    #The path from source to destination is calculated and stored in path
    #variable
    path = predictPath((u_x,u_y),end,graph)
    #The path and status varibales are stored in returnjson dictonary
    returnjson = {'path' : path, 'status' : True}
    #It is then converted to json string and returned
    return json.dumps(returnjson)
  except Exception as e:
    print(e)
    print(traceback.format_exc())

#Try - Except block is placed to catch errors if there were any
try:
  global graph
  #Call the function to convert 'graph.json' file to graph
  graph = json_to_graph("graph.json")
  db['00080F08-08CF-77EB-4A35-B67F03739AAC'] = "[7.32, 16.34]" #36:8C
  db['00080F08-08EB-2B7E-B52C-66FFA7268E7E'] = "[16.32, 16.34]" #36:C5
  db['53594F4F-4B53-4146-4551-524E54414753'] = "[25.32, 16.34]" #506
  db['53594F4F-4B53-4146-4551-524E54414754'] = "[34.32,16.34]"   #510
  db['00080F08-0845-3A95-FA5B-F6EDFDBE3532'] = "[43.32,16.34]"  #36:A1
  #Assumed radius of beacons
  R = 10
  #No of particles for Monte Carlo Simulations
  N = 500
except Exception as e:
  #Prints the exception and also traceback log without throwing off error or
  #stopping the server
  print(e)
  print(traceback.format_exc())


#Flask server is created
app = Flask('')

#Flask home route is called to check the status of server and aslo used to
#send requests at an interval to keep the server running
@app.route('/')
def home():
    return "Hello. I am alive!"

#The predict route calls calls the function asynchronously and send the given
#json file back to the application
@app.route('/predict',methods=['POST','GET'])
def predict():
  try:

    #Creates a new asynchronous event loop and calls it
    asyncio.set_event_loop(asyncio.new_event_loop())
    loop = asyncio.get_event_loop()
    #A new task is created in the loop for predicting the position and path
    task = loop.create_task(generate(request))
    #The loop will run asynchronously and the next request will only be dealt
    #when first one will finish
    js = loop.run_until_complete(asyncio.gather(task))[0]
    #The event loop is closed
    loop.close()
    #The json string is returned back to the application
    return js

  except:
    print(traceback.format_exc())

#The server is ran through local host on server via 8080 port
def run():
  app.run(host='0.0.0.0',port=8080)

#The server is starts with this function
def keep_alive():
    t = Thread(target=run)
    t.start()
