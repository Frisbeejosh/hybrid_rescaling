setwd("/Users/joshfelton/Desktop/class_project_directory/drosphilla_WF/")

library(tidyverse)
library(scales)

# tidy --------------------------------------------------------------------

Q20 <- read_csv("Q20_combined_nucleotide_diversity.csv")
Q50 <- read_csv("Q50_combined_nucleotide_diversity.csv")
Q100 <- read_csv("Q100_combined_nucleotide_diversity.csv")
Q200 <- read_csv("Q200_combined_nucleotide_diversity.csv")
Q150 <- read_csv("Q150_combined_nucleotide_diversity.csv")

Q20 <- mutate(Q20, scaling_factor = "Q20")
Q50 <- mutate(Q50, scaling_factor = "Q50")
Q100 <- mutate(Q100, scaling_factor = "Q100")
Q200 <- mutate(Q200, scaling_factor = "Q200")
Q150 <- mutate(Q150, scaling_factor = "Q150")

Q20  <- Q20  %>% rename(pi = 1)
Q50  <- Q50  %>% rename(pi = 1)
Q100 <- Q100 %>% rename(pi = 1)
Q150 <- Q150 %>% rename(pi = 1)
Q200 <- Q200 %>% rename(pi = 1)

combined_scaling <- bind_rows(Q20, Q50, Q100, Q150,Q200)

plot_levels <- c("Q20", "Q50", "Q100", "Q150","Q200")

# my_comparisons <- list( c("Q20", "Q50"), c("Q20", "Q100"), c("Q20", "Q150"), c("Q20","Q200") )

combined_scaling$scaling_factor <- factor(combined_scaling$scaling_factor, levels = plot_levels)

# stats -------------------------------------------------------------------
# test for normalility
ggqqplot(Q20$pi)
ggqqplot(Q200$pi)


t.test(Q20$pi,Q200$pi)
wilcox.test(Q1$pi,Q20$pi)

# mean percent error --------------------------------------------------------

dfs <- list(Q20 = Q20, Q50 = Q50, Q100 = Q100, Q150 = Q150, Q200 = Q200)

mean_pis <- map_dbl(dfs, ~mean(.x$pi))

base <- mean_pis["Q20"]
percent_errors <- (mean_pis - base) / base

mpe_df <- tibble(
  scaling_factor = names(percent_errors),
  mean_percent_error = percent_errors
) %>%
  filter(scaling_factor != "Q20")

# plotting ----------------------------------------------------------------
ggplot(data = combined_scaling) + 
  geom_bar(aes(x = scaling_factor, y = pi, fill = scaling_factor), stat = "summary", fun = "mean") +
  ylab("mean nucleotide diversity (π)") +
  xlab("scaling factor") +
  stat_summary(aes(x = scaling_factor, y = pi), fun.data = mean_se, geom = "errorbar", width = 0.2) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)), labels = label_comma()) +
  theme_minimal(base_size = 30) +
  theme(legend.position = "none")

ggsave("nucleotide_diversity.svg", units = "in", width = 11.5, height = 9)



# boxplot -----------------------------------------------------------------
ggplot(data = combined_scaling) + 
  geom_boxplot(aes(x = scaling_factor, y = pi, fill = scaling_factor)) +
  ylab("mean nucleotide diversity (π)") +
  xlab("scaling factor") +
  scale_y_continuous(labels = label_comma()) +
  theme_minimal(base_size = 30) +
  #stat_compare_means(comparisons = my_comparisons) +
  theme(legend.position = "none")

ggsave("nucleotide_diversity_boxplot.svg", units = "in", width = 11.5, height = 9)



# mpe plotting ------------------------------------------------------------
plot_levels <- c("Q50", "Q100", "Q150","Q200")

mpe_df$scaling_factor <- factor(mpe_df$scaling_factor, levels = plot_levels)



ggplot(data = mpe_df) +
  geom_bar(aes(x=scaling_factor, y = mean_percent_error, fill = scaling_factor), stat = "identity") +
  ylab("mean percent error") +
  xlab("scaling factor") +
  theme_minimal(base_size = 30) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)), labels = label_comma()) +
  geom_text(aes(x = scaling_factor, 
                y = mean_percent_error, 
                label = paste0(round(mean_percent_error * 100, 1), "%")), 
            vjust = -0.5, size = 8) +
  theme(legend.position = "none")

ggsave("MPE_nucleotide_diversity.svg", width = 10.5, height = 9)




# tajimas -----------------------------------------------------------------
Q20 <- read_csv("Q20_combined_tajima.csv")
Q50 <- read_csv("Q50_combined_tajima.csv")
Q100 <- read_csv("Q100_combined_tajima.csv")
Q200 <- read_csv("Q200_combined_tajima.csv")
Q150 <- read_csv("Q150_combined_tajima.csv")

Q20 <- mutate(Q20, scaling_factor = "Q20")
Q50 <- mutate(Q50, scaling_factor = "Q50")
Q100 <- mutate(Q100, scaling_factor = "Q100")
Q200 <- mutate(Q200, scaling_factor = "Q200")
Q150 <- mutate(Q150, scaling_factor = "Q150")

Q20  <- Q20  %>% rename(D = 1)
Q50  <- Q50  %>% rename(D = 1)
Q100 <- Q100 %>% rename(D = 1)
Q150 <- Q150 %>% rename(D = 1)
Q200 <- Q200 %>% rename(D = 1)

combined_scaling <- bind_rows(Q20, Q50, Q100, Q150,Q200)

plot_levels <- c("Q20", "Q50", "Q100", "Q150","Q200")

# my_comparisons <- list( c("Q20", "Q50"), c("Q20", "Q100"), c("Q20", "Q150"), c("Q20","Q200") )

combined_scaling$scaling_factor <- factor(combined_scaling$scaling_factor, levels = plot_levels)

# stats -------------------------------------------------------------------
# test for normalility
ggqqplot(Q20$D)
ggqqplot(Q200$D)


t.test(Q20$D,Q200$D)
wilcox.test(Q20$D,Q200$D)

dfs <- list(Q20 = Q20, Q50 = Q50, Q100 = Q100, Q150 = Q150, Q200 = Q200)

mean_pis <- map_dbl(dfs, ~mean(.x$D))

base <- mean_pis["Q20"]
percent_errors <- (mean_pis - base) / base

mpe_df <- tibble(
  scaling_factor = names(percent_errors),
  mean_percent_error = percent_errors
) %>%
  filter(scaling_factor != "Q20")

# plotting ----------------------------------------------------------------
ggplot(data = combined_scaling) + 
  geom_bar(aes(x = scaling_factor, y = D, fill = scaling_factor), stat = "summary", fun = "mean") +
  ylab("mean tajimas D") +
  xlab("scaling factor") +
  stat_summary(aes(x = scaling_factor, y = D), fun.data = mean_se, geom = "errorbar", width = 0.2) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)), labels = label_comma()) +
  theme_minimal(base_size = 30) +
  theme(legend.position = "none")

ggsave("mean_tajimas_D.svg", units = "in", width = 11.5, height = 9)



# boxplot -----------------------------------------------------------------
ggplot(data = combined_scaling) + 
  geom_boxplot(aes(x = scaling_factor, y = D, fill = scaling_factor)) +
  ylab("mean tajimas D") +
  xlab("scaling factor") +
  scale_y_continuous(labels = label_comma()) +
  theme_minimal(base_size = 30) +
  #stat_compare_means(comparisons = my_comparisons) +
  theme(legend.position = "none")

ggsave("mean_tajimas_D_boxplot.svg", units = "in", width = 11.5, height = 9)



# mpe plotting ------------------------------------------------------------
plot_levels <- c("Q50", "Q100", "Q150","Q200")

mpe_df$scaling_factor <- factor(mpe_df$scaling_factor, levels = plot_levels)



ggplot(data = mpe_df) +
  geom_bar(aes(x=scaling_factor, y = mean_percent_error, fill = scaling_factor), stat = "identity") +
  ylab("mean percent error") +
  xlab("scaling factor") +
  theme_minimal(base_size = 30) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)), labels = label_comma()) +
  geom_text(aes(x = scaling_factor, 
                y = mean_percent_error, 
                label = paste0(round(mean_percent_error * 100, 1), "%")), 
            vjust = -0.5, size = 8) +
  theme(legend.position = "none")

ggsave("MPE_tajimas_diversity.svg", width = 10.5, height = 9)


