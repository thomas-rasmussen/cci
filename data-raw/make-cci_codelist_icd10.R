# Make a codelist mapping ICD-8 and ICD-10 codes to Charlson Comorbidity Index
# disease groups
library(usethis)

cci_codelist_icd10 <- list()

cci_codelist_icd10[[1]] <- list(
  label = "Myocardial infarction",
  name = "cci1",
  codes = c("I21", "I22", "I23"),
  weight = 1,
  assign0_if = NULL
)
cci_codelist_icd10[[2]] <- list(
  label = "Congestive heart failure",
  name = "cci2",
  codes = c("I50", "I110", "I130", "I132"),
  weight = 1,
  assign0_if = NULL
)
cci_codelist_icd10[[3]] <- list(
  label = "Peripheral vascular disease",
  name = "cci3",
  codes = c("I70", "I71", "I72", "I73", "I74", "I77"),
  weight = 1,
  assign0_if = NULL
)
cci_codelist_icd10[[4]] <- list(
  label = "Cerebrovascular disease",
  name = "cci4",
  codes = c("I6", "G45", "G46"),
  weight = 1,
  assign0_if = NULL
)
cci_codelist_icd10[[5]] <- list(
  label = "Dementia",
  name = "cci5",
  codes = c("F00", "F01", "F02", "F03", "F051", "G30"),
  weight = 1,
  assign0_if = NULL
)
cci_codelist_icd10[[6]] <- list(
  label = "Chronic pulmonary disease",
  name = "cci6",
  codes = c("J40", "J41", "J42", "J43", "J44", "J45", "J46", "J47", "J60",
            "J61", "J62", "J63", "J64", "J65", "J66", "J67", "J684", "J701",
            "J703", "J841", "J920", "J961", "J982", "J983"),
  weight = 1,
  assign0_if = NULL
)
cci_codelist_icd10[[7]] <- list(
  label = "Connective tissue disease",
  name = "cci7",
  codes = c("M05", "M06", "M08", "M09", "M30", "M31", "M32", "M33", "M34",
            "M35", "M36", "D86"),
  weight = 1,
  assign0_if = NULL
)
cci_codelist_icd10[[8]] <- list(
  label = "Ulcer disease",
  name = "cci8",
  codes = c("K221", "K25", "K26", "K27", "K28"),
  weight = 1,
  assign0_if = NULL
)
cci_codelist_icd10[[9]] <- list(
  label = "Mild liver disease",
  name = "cci9",
  codes = c("B18", "K700", "K701", "K702", "K703", "K709", "K71", "K73", "K74",
            "K760"),
  weight = 1,
  assign0_if = "cci17"
)
cci_codelist_icd10[[10]] <- list(
  label = "Diabetes without end-organ damage",
  name = "cci10",
  codes = c("E100", "E101", "E109", "E110", "E111", "E119"),
  weight = 1,
  assign0_if = "cci13"
)
cci_codelist_icd10[[11]] <- list(
  label = "Hemiplegia",
  name = "cci11",
  codes = c("G81", "G82"),
  weight = 2,
  assign0_if = NULL
)
cci_codelist_icd10[[12]] <- list(
  label = "Moderate to severe renal disease",
  name = "cci12",
  codes = c("I12", "I13", "N00", "N01", "N02", "N03", "N04", "N05", "N07",
            "N11", "N14", "N17", "N18", "N19", "Q61"),
  weight = 2,
  assign0_if = NULL
)
cci_codelist_icd10[[13]] <- list(
  label = "Diabetes with end-organ damage",
  name = "cci13",
  codes = c("E102", "E103", "E104", "E105", "E106", "E107", "E108", "E112",
            "E113", "E114", "E115", "E116", "E117", "E118"),
  weight = 2,
  assign0_if = NULL
)
cci_codelist_icd10[[14]] <- list(
  label = "Non-metastatic solid tumour",
  name = "cci14",
  codes = c("C0", "C1", "C2", "C3", "C4", "C5", "C6", "C70", "C71", "C72",
            "C73", "C74", "C75"),
  weight = 2,
  assign0_if = "cci18"
)
cci_codelist_icd10[[15]] <- list(
  label = "Leukaemia",
  name = "cci15",
  codes = c("C91", "C92", "C93", "C94", "C95"),
  weight = 2,
  assign0_if = NULL
)
cci_codelist_icd10[[16]] <- list(
  label = "Lymphoma",
  name = "cci16",
  codes = c("C81", "C82", "C83", "C84", "C85", "C88", "C90", "C96"),
  weight = 2,
  assign0_if = NULL
)
cci_codelist_icd10[[17]] <- list(
  label = "Moderate to severe liver disease",
  name = "cci17",
  codes = c("B150", "B160", "B162", "B190", "K704", "K72", "K766", "I85"),
  weight = 3,
  assign0_if = NULL
)
cci_codelist_icd10[[18]] <- list(
  label = "Metastatic solid tumour",
  name = "cci18",
  codes = c("C76", "C77", "C78", "C79", "C80"),
  weight = 6,
  assign0_if = NULL
)
cci_codelist_icd10[[19]] <- list(
  label = "AIDS",
  name = "cci19",
  codes = c("B21", "B22", "B23", "B24"),
  weight = 6,
  assign0_if = NULL
)

class(cci_codelist_icd10) <- "codelist"

usethis::use_data(cci_codelist_icd10, overwrite = TRUE)
