library(readxl)

filename <- "test_empirical.xlsx"

read_excel_allsheets <- function(filename) {
  sheets <- readxl::excel_sheets(filename)
  x <- lapply(sheets,function(X){readxl::read_excel(filename, sheet = X, col_name = FALSE)})
  names(x) <- sheets
  x
}

output_to_csv <- function(filename) {
  my_sheets <- read_excel_allsheets(filename)
  message("\n")
  for (i in c(1:length(my_sheets))) {
    df <- data.frame(my_sheets[i])
    output_name <- sprintf("%s_%d.csv", substr(filename, start = 1, stop = nchar(filename) - 5), i)
    write.table(df,file=output_name, row.names=FALSE, sep = ",")
    confirmation <- sprintf("sheet %d outputted to %s", i, output_name)
    message(confirmation)
  }
  message("\n")
}

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 1) {
  stop("USAGE ERROR: enter filename of Excel workbook you wish to convert", call. = FALSE)
} else {
  output_to_csv(args[1])
  message("-------------------\nConversion complete\n-------------------\n")
}