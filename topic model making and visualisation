#testing for K: step 1 producing computational K using lee mimno(2014)

MRCktest <- searchK(documents = MRCprestm$documents,
                vocab = MRCprestm$vocab, K = 0, prevalence =~ CPIpounds, 
                max.em.its = 75, data = MRCprestm$meta, init.type = "Spectral")

#final stm with k of 60

MRCstm <- stm(documents = MRCprestmnostem$documents,
              vocab = MRCprestmnostem$vocab,
              K = 60, prevalence =~ logCPIpounds,
              max.em.its = 75,
              data = MRCprestmnostem$meta, init.type = "Spectral")

#estimating linear and non-linear effect of funding

prepCPI <- estimateEffect(1:60 ~ s(logCPIpounds), MRCstm, metadata = MRCprestmnostem$meta, uncertainty = "Global")
prepCPIlinear <- estimateEffect(1:60 ~ logCPIpounds, MRCstm, metadata = MRCprestmnostem$meta, uncertainty = "Global")

#example of a low funding topic

plot(prepCPI, "logCPIpounds", 
               method = "continuous", 
               topics = 20, printlegend = FALSE, 
               main = 'Topic 20: Hearing Loss', 
               xlab = 'Ln(Inflation Adjusted Award (£))', 
               ylab  = 'Topic  Probability Change', 
               ylim = (c(-0.5, 0.5)))
