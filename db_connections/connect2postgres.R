# connect to DB

library(DBI)

start_time <- Sys.time()

# Connect to a specific postgres database i.e. Heroku
con <- dbConnect(RPostgres::Postgres(),dbname = '<dbname>', 
                 host = '<ip>', # i.e. 'ec2-54-83-201-96.compute-1.amazonaws.com'
                 port = port, # or any other port specified by your DBA
                 user = 'user',
                 password = 'pass')

# dbListTables(con)
# dbWriteTable(con, "mtcars", mtcars)
# dbListTables(con)
# 
# dbListFields(con, "mtcars")
# dbReadTable(con, "mtcars")

# You can fetch all results:
res <- dbSendQuery(con, 'SELECT id,name,gender,department FROM python.users;')
x <- dbFetch(res)
dbClearResult(res)

print(x)

# # Or a chunk at a time
# res <- dbSendQuery(con, "SELECT * FROM mtcars WHERE cyl = 4")
# while(!dbHasCompleted(res)){
#   chunk <- dbFetch(res, n = 5)
#   print(nrow(chunk))
# }
# Clear the result
# dbClearResult(res)

# Disconnect from the database
dbDisconnect(con)

end_time <- Sys.time()

end_time - start_time


# export DSN="dbname=mydb host=localhost port=5432 user=myuser password=xxx"
# time python -c "import os, psycopg2; print psycopg2.connect(os.environ['DSN'])"
# time psql -c "" "$DSN"