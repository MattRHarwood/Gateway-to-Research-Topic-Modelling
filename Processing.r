library(lubridate)
library(tidyverse)
library(stm)

#adding start year and duration column
library(lubridate)
grants$start_date_2 <- dmy(grants$start_date)
grants$end_date_2 <- dmy(grants$end_date)
grants$start_year <- year(grants$start_date_2)

#getting grants 2014 onwards
grants_no_missing <- filter(grants, grants$start_year > 2013)

#removing grants with no award or duration
library(tidyverse)

grants_no_missing <- grants_no_missing %>% 
  filter(duration_days > 0) %>% 
  filter(award_pounds > 0) %>% 
  filter(!is.na(award_pounds))

#removing missing abstracts
missing <- grants$abstract[1658]

grants_no_missing <- grants_no_missing %>% 
  filter(abstract != missing)

#just Medical Research Council grant abstracts, awards and start years

MRCmeta <- grants_no_missing %>% filter(i_funding_org_name == 'MRC')
MRCmeta <- MRCmeta %>% select(18, 27, 30)

#adjusting for inflation using 2019 as base year for index

CPIUK$Value <- CPIUK$Value / 1.7



CPIUK <- CPIUK[c(6,7)]

MRCCPI <- merge(MRCmeta, CPIUK, by = 'start_year', all.x =TRUE)

MRCCPI <- filter(MRCCPI, MRCCPI$start_year > 2013)

MRCCPI$CPIPounds <- MRCCPI$award_pounds / MRCCPI$Value

MRCCPIMeta <- MRCCPI[c(3,5)]

#getting natural long of award values

MRCCPIMeta$logCPIpounds <- log(CPIPounds)
MRCCPIMeta$CPIpounds <- NULL

#text processing and document term matrix production

MRCprestmn <- textProcessor(MRCCPIMeta$abstract, metadata = MRCCPIMeta, customstopwords = c('will', 'cell', 'cells'), stem = FALSE)
MRCout <- prepDocuments(MRCprestm$documents, MRCprestm$vocab, MRCprestm$meta, lower.thresh = 1)


