library(ggplot2)
library(dplyr)
library(hrbrthemes)


filename <- "../../data/interim/city_tax_rates_rev_77_82_with_race_80.csv"
full_data <- read.csv(filename, header = TRUE, colClasses=c("ID"="character"))

# percentage of White with no Spanish origin
cat("pearson coef:", 
    cor(full_data$prop_tax_ratio_change, full_data$non_spanish_orig_white_percentage, method="pearson"))
cat("spearman coef:", 
    cor(full_data$prop_tax_ratio_change, full_data$non_spanish_orig_white_percentage, method="spearman"))

plot(prop_tax_ratio_change~non_spanish_orig_white_percentage, data=full_data)
# abline(v=summary(full_data$non_spanish_orig_white_percentage)[3])
abline(m1 <- lm(prop_tax_ratio_change~non_spanish_orig_white_percentage, data=full_data))
# identify(full_data$non_spanish_orig_white_percentage, full_data$prop_tax_ratio_change, n=2)
summary(m1)

plot(residuals(m1)~non_spanish_orig_white_percentage, data=full_data)
abline(h=0)
# identify(full_data$non_spanish_orig_white_percentage, residuals(m1), n=2)

summary(full_data$non_spanish_orig_white_percentage)
sample_med <- summary(full_data$non_spanish_orig_white_percentage)[3]
full_data$non_spanish_orig_white_percentage_group <- ifelse(
  full_data$non_spanish_orig_white_percentage > sample_med, "high", "low")
boxplot(full_data$prop_tax_ratio_change ~ full_data$non_spanish_orig_white_percentage_group,notched=TRUE)

mean_white_per_by_group <- full_data %>% group_by(non_spanish_orig_white_percentage_group) %>% summarise(non_hispanic_white_percent=mean(non_spanish_orig_white_percentage))
boxplot(full_data$non_spanish_orig_white_percentage ~ full_data$non_spanish_orig_white_percentage_group,notched=TRUE)

# compare histograms
# p <- full_data %>%
#   ggplot( aes(x=prop_tax_ratio_change, fill=non_spanish_orig_white_percentage_group)) +
#   geom_histogram( color="#e9ecef", alpha=0.6, position = 'identity') +
#   scale_fill_manual(values=c("#69b3a2", "#404080")) +
#   theme_ipsum() +
#   labs(fill="")
# p

# percentage of White
cat("pearson coef:",
    cor(full_data$prop_tax_ratio_change, full_data$white_percentage, method="pearson"))
cat("spearman coef:",
    cor(full_data$prop_tax_ratio_change, full_data$white_percentage, method="spearman"))

plot(prop_tax_ratio_change~white_percentage, data=full_data)
# abline(v=summary(full_data$white_percentage)[3])
abline(m1 <- lm(prop_tax_ratio_change~white_percentage, data=full_data))
# identify(full_data$white_percentage, full_data$prop_tax_ratio_change, n=2)
summary(m1)

plot(residuals(m1)~white_percentage, data=full_data)
abline(h=0)
# identify(full_data$white_percentage, residuals(m1), n=2)

summary(full_data$white_percentage)
sample_med <- summary(full_data$white_percentage)[3]
full_data$white_percentage_group <- ifelse(
  full_data$white_percentage > sample_med, "high", "low")
boxplot(full_data$prop_tax_ratio_change ~ full_data$white_percentage_group, notched=TRUE)

# percentage of Black
cat("pearson coef:", 
    cor(full_data$prop_tax_ratio_change, full_data$black_percentage, method="pearson"))
cat("spearman coef:", 
    cor(full_data$prop_tax_ratio_change, full_data$black_percentage, method="spearman"))
# significant
# cat("kendall coef:",
#     cor(full_data$prop_tax_ratio_change, full_data$black_percentage, method="kendall"))


plot(prop_tax_ratio_change~black_percentage, data=full_data)
# abline(v=summary(full_data$black_percentage)[3])
abline(m1 <- lm(prop_tax_ratio_change~black_percentage, data=full_data))
# identify(full_data$black_percentage, full_data$prop_tax_ratio_change, n=1)
#5 oakland
summary(m1)

summary(full_data$black_percentage)
sample_med <- summary(full_data$black_percentage)[3]
full_data$black_percentage_group <- ifelse(
  full_data$black_percentage > sample_med, "high", "low")
boxplot(full_data$prop_tax_ratio_change ~ full_data$black_percentage_group,notched=TRUE)

mean_black_per_by_group <- full_data %>% group_by(black_percentage_group) %>% summarise(black_percent=mean(black_percentage))
boxplot(full_data$black_percentage ~ full_data$black_percentage_group,notched=TRUE)

# percentage of Hispanic
cat("pearson coef:",
    cor(full_data$prop_tax_ratio_change, full_data$hispanic_percentage, method="pearson"))
cat("spearman coef:",
    cor(full_data$prop_tax_ratio_change, full_data$hispanic_percentage, method="spearman"))
# cat("kendall coef:",
#     cor(full_data$prop_tax_ratio_change, full_data$hispanic_percentage, method="kendall"))

plot(prop_tax_ratio_change~hispanic_percentage, data=full_data)
# abline(v=summary(full_data$hispanic_percentage)[3])
abline(m1 <- lm(prop_tax_ratio_change~hispanic_percentage, data=full_data))
# identify(full_data$hispanic_percentage, full_data$prop_tax_ratio_change, n=2)
summary(m1)

plot(residuals(m1)~hispanic_percentage, data=full_data)
abline(h=0)
# identify(full_data$hispanic_percentage, residuals(m1), n=2)

summary(full_data$hispanic_percentage)
sample_med <- summary(full_data$hispanic_percentage)[3]
full_data$hispanic_percentage_group <- ifelse(
  full_data$hispanic_percentage > sample_med, "high", "low")
boxplot(full_data$prop_tax_ratio_change ~ full_data$hispanic_percentage_group, notched=TRUE)

# percentage of Hispanic + Black
cat("pearson coef:",
    cor(full_data$prop_tax_ratio_change, full_data$hispanic_black_combined_percentage, method="pearson"))
cat("spearman coef:",
    cor(full_data$prop_tax_ratio_change, full_data$hispanic_black_combined_percentage, method="spearman"))
# cat("kendall coef:",
#     cor(full_data$prop_tax_ratio_change, full_data$hispanic_black_combined_percentage, method="kendall"))

plot(prop_tax_ratio_change~hispanic_black_combined_percentage, data=full_data)
# abline(v=summary(full_data$hispanic_black_combined_percentage)[3])
abline(m1 <- lm(prop_tax_ratio_change~hispanic_black_combined_percentage, data=full_data))
# identify(full_data$hispanic_black_combined_percentage, full_data$prop_tax_ratio_change, n=2)
summary(m1)

plot(residuals(m1)~hispanic_black_combined_percentage, data=full_data)
abline(h=0)
identify(full_data$hispanic_black_combined_percentage, residuals(m1), n=2)
# berkeley, sf

summary(full_data$hispanic_black_combined_percentage)
sample_med <- summary(full_data$hispanic_black_combined_percentage)[3]
full_data$hispanic_black_combined_percentage_group <- ifelse(
  full_data$hispanic_black_combined_percentage > sample_med, "high", "low")
boxplot(full_data$prop_tax_ratio_change ~ full_data$hispanic_black_combined_percentage_group, notched=TRUE)


