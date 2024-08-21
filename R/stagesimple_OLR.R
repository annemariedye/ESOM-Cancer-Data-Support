library(ggplot2)
library(dplyr)

data <- AEH_R_Data

ggplot(data, aes(x = stage_simple, y = MMR, group = Cat_BMI)) +
	geom_col() + #use for bar graph
	#geom_boxplot(size = .75) + #use for box plot
	#geom_point(alpha = .5) + #use for box plot
	facet_grid(. ~ Cat_BMI, margins = TRUE) +
	labs(
		title = "Relationship Between MMR Status and Cancer Stage by BMI Category",
		x = "Cancer Stage",
		y = "MMR Proficient",
		caption = "BMI Categories are coded as 0 < 25, 1 = 25-29.9, 2 = 30-34.9, 3 = 35-39.9, 4 ≥ 40"
	) +
	theme_minimal() +
	theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))
