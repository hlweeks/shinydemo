library('datasets')

# Maybe I should just pick like 10 interesting ones...
dat_titles <- data()$results[,"Title"]
dat_names <- data()$results[,"Item"]

dat_titles <- dat_titles[!grepl("[(]", dat_names)]
dat_names <- dat_names[!grepl("[(]", dat_names)]

all_datasets <- vector('list', length(dat_names))
for(i in seq_along(dat_names)){
  data(list = dat_names[i])
  all_datasets[[i]] <- get(dat_names[i])
}

ind_keep <- unlist(lapply(all_datasets, function(x) length(colnames(x)) > 1))

dat_titles <- dat_titles[ind_keep]
dat_names <- dat_names[ind_keep]


#Problems: occupationalStatus, iris3, crimtab, WorldPhones, VADeaths, USPersonalExpenditure, 
#          UCBAdmissions, Titanic, Seatbelts, HairEyeColor, EuStockMarkets, uspop2, txhousing,
#          presidential, msleep, mpg