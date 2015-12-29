install.packages("streamR")
install.packages("ROAuth")
library(streamR)
library(ROAuth)
requestURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
consumerKey <- ""
consumerSecret <- ""
my_oauth <- OAuthFactory$new(consumerKey = consumerKey, consumerSecret = consumerSecret,
                             requestURL = requestURL, accessURL = accessURL, authURL = authURL)
my_oauth$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))
save(my_oauth, file = "my_oauth.Rdata")
keywords <- c()
while(1){
datetime <- gsub(":", "", gsub(" ", "-", Sys.time()))
filterStream(file=paste0("", datetime, ".json"), track = keywords, timeout = 86400, oauth = my_oauth)
}