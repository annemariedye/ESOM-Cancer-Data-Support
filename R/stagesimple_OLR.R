library(ggplot2)
library(dplyr)

data <- AEH_data

ggplot(data, aes(x = stage_simple, y = MMR, group = BMI_cat)) +
	geom_col() + #use for bar graph
	#geom_boxplot(size = .75) + #use for box plot
	#geom_point(alpha = .5) + #use for box plot
	facet_grid(. ~ BMI_cat, margins = TRUE) +
	labs(
		title = "Relationship Between MMR Status and Cancer Stage by BMI Category",
		x = "Cancer Stage",
		y = "MMR Proficient",
		caption = "BMI Categories are coded as 0 < 25, 1 = 25-29.9, 2 = 30-34.9, 3 = 35-39.9, 4 ≥ 40"
	) +
	theme_minimal() +
	theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))

library(MASS)

data$stage_simple <- factor(data$stage_simple,
														levels = c(0:4),
														ordered = TRUE)

olr_model <- polr(stage_simple ~ MMR + BMI_cat, data = data, Hess = TRUE)

summary(olr_model)

# Get the coefficients table from the summary
ctable <- coef(summary(olr_model))

# Calculate p-values using the Wald test (two-tailed)
p_values <- pnorm(abs(ctable[, "t value"]), lower.tail = FALSE) * 2

# Combine the coefficients, standard errors, t-values, and p-values into a table
results <- cbind(ctable, "p value" = p_values)
print(results)

