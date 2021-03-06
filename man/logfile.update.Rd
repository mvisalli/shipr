% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/logfile_funs.R
\name{logfile.update}
\alias{logfile.update}
\title{Log data manipulation}
\usage{
logfile.update(
  log_df = NULL,
  url = NULL,
  is_read = FALSE,
  assign_back = FALSE,
  logfile_path = NULL,
  ...
)
}
\arguments{
\item{log_df}{The table/data.frame containing the log data}

\item{url}{the url to either be updated or appended}

\item{is_read}{logical indicating whether or not the url has already been read in}

\item{assign_back}{logical indicating whether the data.frame should be reassigned back to the
working environment}

\item{logfile_path}{If provided and the log_df param is NULL, this file path will be
processed into the working environment/function as the log_df. Upon exit, the new data
will be written to the file location. At time of build/testing there is a logfile
located at \strong{\code{inst/data/logfile.json}}}

\item{...}{additional arguments to be processed}
}
\value{

}
\description{
\code{logfile.update}
}
\details{
This function handles the processing of our log data. The log data will tell
our other functions what needs to be read, what has been read and where to
start/stop. Additionally the time-stamps will provide a little insight into
debugging if data is missing etc in the future.

You can import the log data from a database and pass to the \code{log_df}
parameter, which if you then set \code{assign_back} to TRUE, will reassign the updated
dataframe back into the work-space, and can be written back to the database after. See examples
for a rough walk-through.

Additionally you can provide a path to a json file for processing. This will avoid
the need to add any tables to the working environment, and will assign, in place
the dataframe, and write to the same connection upon closing.

If a url already exists, but we are changing the status of the data being read,
the data is updated in place, and the cell for \code{is_read} simply changes.
}
\examples{

FOR DB connection

Create the object in R as the_log
the_log <- dbConnect(your_tables)

this will reassign the new data to the_log, note that if assign_back = FALSE,
the entire data.frame will be returned, so catch with the_log <- logfile.update(log_df = the_log)
logfile.update(log_df = the_log, assign_back = TRUE)

write back to db
writeDB(the_log, ...)

Example if the data is in the environment as log_df_test with only 4 rows
nrow(log_df)
[1] 4

> tail(log_df_test,1)
                                                                       url is_read  timestamp
4 https://ais.sbarc.org/logs_delimited/2018/180101/AIS_SBARC_180101-03.txt   FALSE 1574145802

> logfile.update(log_df = log_df_test, url = "testurl.com", is_read = TRUE, assign_back = TRUE)
> tail(log_df_test,2)
                                                                       url is_read  timestamp
4 https://ais.sbarc.org/logs_delimited/2018/180101/AIS_SBARC_180101-03.txt   FALSE 1574145802
5                                                              testurl.com    TRUE 1574148016

> nrow(log_df_test)
[1] 5

}
