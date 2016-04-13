setwd("/Users/Julian/Documents/YRWA/current-data/")

yrwa<-read.csv("/Users/Julian/Documents/YRWA/current-data/d2h_values.csv", stringsAsFactors = FALSE, strip.white = TRUE, na.strings = c("NA", "", "na"))
head(yrwa)

#change column name for ease of use
colnames(yrwa)[5]<-c("featherH")

#remove empty rows
row.has.na <- apply(yrwa, 1, function(x){any(is.na(x))})
yrwa <- yrwa[!row.has.na, ]

#transfer functions to associate feather with precip values
#
# if feather H < -53.6%, use f = 0.5765 * p - 61.34
# if feather H >= -53.6%, use f = 1.345 * p - 20.17


for(i in 1:length(yrwa$featherH)){
  if (yrwa$featherH[i] < -53.6){
    yrwa$environmentalH[i] <- (yrwa$featherH[i] + 61.34) / 0.5765
  } else {
    yrwa$environmentalH[i] <- (yrwa$featherH[i] + 20.17) / 1.345
  }
}

write.csv(yrwa, file = "environmentalH.csv")
