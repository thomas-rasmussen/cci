#' @title Codelist mapping ICD-8 and ICD10 codes to Charlson Comorbidity
#' Index disease groups
#'
#' @description A list containing the labels, names and codes used to define
#' each of the disease groups in the Charlson Comorbidity Index using both
#' ICD-8 and ICD-10 codes.
#'
#' @format A list with 19 elements, where each element is also a list
#' with 4 elements used to define each disease group:
#' \describe{
#'   \item{label}{Disease group label}
#'   \item{name}{Name used as variable name in data}
#'   \item{codes}{Character vector of ICD-8 and ICD-10 codes with no punctuation.}
#'   \item{assign0_if}{Character vector with names of CCI disease groups that is
#'   used to make corrections to this disease group, eg if one of the listed
#'   disease groups are present, the current disease group will be defined as
#'   being absent, regardless of whether or not it actually is.}
#' }
"cci_codelist_icd8_icd10"

#' @title Codelist mapping ICD10 codes to Charlson Comorbidity
#' Index disease groups
#'
#' @description A list containing the labels, names and codes used to define
#' each of the disease groups in the Charlson Comorbidity Index using
#' ICD-10 codes.
#'
#' @format A list with 19 elements, where each element is also a list
#' with 3 elements used to define each disease group:
#' \describe{
#'   \item{label}{Disease group label}
#'   \item{name}{Name used as variable name in data}
#'   \item{codes}{Character vector of ICD-10 codes with no punctuation.}
#'   \item{assign0_if}{Character vector with names of CCI disease groups that is
#'   used to make corrections to this disease group, eg if one of the listed
#'   disease groups are present, the current disease group will be defined as
#'   being absent, regardless of whether or not it actually is.}
#' }
"cci_codelist_icd10"

#' @title ICD-8 codes
#'
#' @description ICD-8 codes and corresponding chapter(labels). Note that
#' not all sub codes are included.
#'
#' @format A data.frame with 4510 rows and 3 columns containing
#' ICD-8 codes. Note that not all subcodes are included.
#' \describe{
#'   \item{code}{ICD-8 code}
#'   \item{chapter}{Chapter label}
#'   \item{label}{Code label}
#' }
#' @source \url{http://www.wolfbane.com/icd/icd8h.htm}
"icd8_4digits"

#' @title ICD-10-CM codes, 2020 version
#'
#' @description ICD-10-CM, 2020 version codes with corresponding labels.
#'
#' @format A data.frame with 72184 rows and 2 columns containing
#' ICD-10-CM codes.
#' \describe{
#'   \item{code}{ICD-10-CM code}
#'   \item{label}{Code label}
#' }
#' @source \url{https://ftp.cdc.gov/pub/Health_Statistics/NCHS/Publications/ICD10CM/2020/icd10cm_codes_2020.txt}
"icd10_cm_2020"

