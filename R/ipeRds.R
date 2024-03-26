## -----------------------------------------------------------------------------
##
##' [PROJ: ipeRds]
##' [FILE: Automagically Download Labelled .rds IPEDS Files]
##' [INIT: March 25th 2024]
##' [AUTH: Matt Capaldi] @ttalVlatt
##' [CRED: Benjamin T. Skinner] @btskinner
##
## -----------------------------------------------------------------------------

## ---------------------------
##' [README]
## ---------------------------

## ---------------------------
##' [Temp file list (will be created by file_selector eventually)]
## ---------------------------

# file_selector <- function(files = files, years = years) { }

selected_files <- c(
  "GR2020_PELL_SSL",
  "HD2017",
  "EFFY2018",
  "SFA1718",
  "F1718_F1A",
  "F1718_F2",
  "F1718_F3",
  "S2017_SIS",
  "IC2017_AY",
  "EF2017A_DIST"
  )

## ---------------------------
##' [do_labeler function]
## ---------------------------

# do_labeler <- function(do_file)

## ---------------------------
##' [ipeRds function]
## ---------------------------

# ipeRds <- function(files, years, revised = TRUE, keep = TRUE)

##'[Create folders if they don't exist]

folders <- c("zip-data", "zip-do-files", "zip-dictionaries",
             "unzip-data", "unzip-do-files", "unzip-dictionaries",
             "rds-data")

for(i in folders) {
  if(!dir.exists(i)) {
    dir.create(i)
  }
}

##'[Download files from IPEDS if they don't exist]

zip_folders <- c("zip-data", "zip-do-files", "zip-dictionaries")

for(i in selected_files) {

  for(j in zip_folders) {

    if(!file.exists(paste0(j, "/", i, ".zip"))) {

      print(paste("Downloading", i, "to", j))
      url <- paste0("https://nces.ed.gov/ipeds/datacenter/data/", i, "_Data_Stata.zip")
      destination <- paste0(j, "/", i, ".zip")
      download.file(url, destination)
      Sys.sleep(3)

    }
  }
}


##'[Unzip all downloaded files]

for(i in zip_folders) {

  zip_files <- list.files(i, full.names = TRUE)

  for(j in zip_files) {
    unzip(j, exdir = paste0("un", i))

  }
}

##'[Replace revised data with _rv]

rv_data <- list.files("unzip-data",
                      pattern = "_rv|_RV",
                      full.names = TRUE)

for(i in rv_data) {

  og_name <- stringr::str_remove(i, "_rv|_RV")
  file.remove(og_name)
  file.rename(i, og_name)

}

##'[do_labeler]

unzip_data <- list.files("unzip-data",
                         full.names = TRUE)

for(i in unzip_data) {

  data <- readr::read_csv(i, show_col_types = F)

  name <- stringr::str_remove_all(i, "unzip-data/|_data_stata.csv")
  rds_name <- paste0("rds-data/", name, ".rds")

  print(paste("Saving", rds_name))
  readr::write_rds(data, rds_name)

}

## -----------------------------------------------------------------------------
##' *END SCRIPT*
## -----------------------------------------------------------------------------
