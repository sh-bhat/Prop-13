library(ggplot2)
library(dplyr)
library(hrbrthemes)


filename <- "../../data/interim/city_tax_rates_rev_77_82_with_homeownership_rates_by_race_80.csv"
full_data <- read.csv(filename, header = TRUE, colClasses=c("ID"="character"))

# black homeownership rate
cat("pearson coef:", 
    cor(full_data$prop_tax_ratio_change, full_data$Black_homeownership_rate, method="pearson"))
cat("spearman coef:", 
    cor(full_data$prop_tax_ratio_change, full_data$Black_homeownership_rate, method="spearman"))

plot(prop_tax_ratio_change~Black_homeownership_rate, data=full_data)
# abline(v=summary(full_data$Black_homeownership_rate)[3])
abline(m1 <- lm(prop_tax_ratio_change~Black_homeownership_rate, data=full_data))
# identify(full_data$Black_homeownership_rate, full_data$prop_tax_ratio_change, n=2)
summary(m1)

plot(residuals(m1)~Black_homeownership_rate, data=full_data)
abline(h=0)
# identify(full_data$Black_homeownership_rate, residuals(m1), n=2)

summary(full_data$Black_homeownership_rate)
sample_med <- summary(full_data$Black_homeownership_rate)[3]
full_data$Black_homeownership_rate_group <- ifelse(
  full_data$Black_homeownership_rate > sample_med, "high", "low")
boxplot(full_data$prop_tax_ratio_change ~ full_data$Black_homeownership_rate_group,notched=TRUE)
