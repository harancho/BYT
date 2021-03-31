'''

* Project Name: 	Be You There
* Author List: 		Siddharth Golecha
* Filename: 		main.py
* Functions: 		main()
* Global Variables:	NONE

'''

from keep_alive import keep_alive

#It is executed only when the program is run as a standalone script and not as
#an imported module.
if __name__=="__main__":

    #Calls keep_alive function defined in keep_alive module and starts the
    #server.
    keep_alive()
