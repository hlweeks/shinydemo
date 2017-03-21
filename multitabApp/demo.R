library('datasets')

dat_names <- data()$results[,"Item"]
dat_names <- dat_names[!grepl("[(]", dat_names)]
  
