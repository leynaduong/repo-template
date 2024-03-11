### Analysis of BioITA data

# Set working direcotry to repo-template folder

## Imports data into RStudio
# Sets the file path to the CSV file
file_path <- 'data/bioita-data.csv'

# Reads the CSV file into a data frame
bioita_data <- read.csv(file_path)

# Views data frame (creates table)
head(bioita_data)

## Calculates the averages and standard deviations of itaconate rows
itaconate <- c(1, 2, 3)
itaconate_data <- bioita_data[itaconate, ]

itaconate_averages <- colMeans(itaconate_data[, -1], na.rm = TRUE)
itaconate_std <- apply(itaconate_data[, -1], 2, sd, na.rm = TRUE)

## Calculates the averages and standard deviations of cis-aconitate rows
cis_aconitate <- c(4, 5, 6)
cis_aconitate_data <- bioita_data[cis_aconitate, ]

cis_aconitate_averages <- colMeans(cis_aconitate_data[, -1], na.rm = TRUE)
cis_aconitate_std <- apply(cis_aconitate_data[, -1], 2, sd, na.rm = TRUE)

## Creates bar graph with stds of itacoante and cis-aconitate concentrations vs. fluorescence
concentration <- c(40, 35, 30, 25, 20, 15, 10, 0)

bp <- barplot(
  height = rbind(itaconate_averages, cis_aconitate_averages),
  beside = TRUE,
  names.arg = concentration,
  xlab = "Concentration (mM)",
  ylab = "Fluorescence",
  main = "Itaconate vs. Cis-aconitate",
  ylim = c(0, 160000),
  legend.text = c("Itaconate", "Cis-aconitate"),
)

# Calculates the x-coordinates for std bars
x <- bp[1,]
y <- bp[2,]

# Adds std bars for itaconate
arrows(x, itaconate_averages - itaconate_std, x, itaconate_averages + itaconate_std,
       length = 0.05, angle = 90, code = 3, col = "black")

# Adds std bars for cis-aconitate
arrows(y, cis_aconitate_averages - cis_aconitate_std, y, cis_aconitate_averages + cis_aconitate_std,
       length = 0.05, angle = 90, code = 3, col = "black")
