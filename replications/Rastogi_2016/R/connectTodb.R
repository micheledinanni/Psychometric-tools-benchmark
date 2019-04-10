require("RMySQL") 
con<-dbConnect(MySQL(),
               user="root",
               password="root",
               port=3306,
               db="personality",
               host="localhost")
