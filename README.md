
# fatRats

The goal of fatRats is to help data scientists and statisticians
handling raw data and primarily handling lab data. We have created
functions to help in the data cleaning process by higlighting errors in
data cleaning and identify what changes may need to be made. All that
the package requires for useage is a dataframe. The rest of the package
is designed to be very easy to use. We recommend either reading in your
files as a CSV or if you have an excel spreadsheet, be sure to read in
the correct sheet before you get started.

## Installation

You can install the development version of fatRats from
[GitHub](https://github.com/) with:

``` r
install.packages("devtools")
#> Installing package into '/private/var/folders/bs/304947wx7_bdvtq7b3dynh5h0000gn/T/Rtmpg2rFU5/temp_libpath183405a374d09'
#> (as 'lib' is unspecified)
#> 
#> The downloaded binary packages are in
#>  /var/folders/bs/304947wx7_bdvtq7b3dynh5h0000gn/T//Rtmp1Ibk61/downloaded_packages
devtools::install_github("nkchebat/stat108project2")
#> Downloading GitHub repo nkchebat/stat108project2@HEAD
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#> * checking for file ‘/private/var/folders/bs/304947wx7_bdvtq7b3dynh5h0000gn/T/Rtmp1Ibk61/remotes184021a531838/nkchebat-stat108project2-0487895/DESCRIPTION’ ... OK
#> * preparing ‘fatRats’:
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> Omitted ‘LazyData’ from DESCRIPTION
#> * building ‘fatRats_0.1.0.tar.gz’
#> Installing package into '/private/var/folders/bs/304947wx7_bdvtq7b3dynh5h0000gn/T/Rtmpg2rFU5/temp_libpath183405a374d09'
#> (as 'lib' is unspecified)
```

## Example 1

This is a basic example which shows you how to use the plot_outliers
function. This function is very useful if you are trying to check if
your data seems reasonable. If you have any datapoints show up in red on
the plot, you may want to go back to your data and ensure that there
were no typos.

``` r
library(fatRats)
library(readxl)
data <- read_excel("R/data/mousedata.xlsx", sheet = 2)
#> New names:
#> • `Date Body Weight 2` -> `Date Body Weight 2...5`
#> • `Date Body Weight 2` -> `Date Body Weight 2...7`
data$'Body Weight 1' = as.numeric(data$"Body Weight 1") #Make sure you have a numeric
plot_outliers(data,"Body Weight 1")
#> 
#> Attaching package: 'dplyr'
#> 
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> 
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
```

<img src="man/figures/README-example 1-1.png" width="100%" />

## Example 2

This is a basic example which shows you how to use the check_trend
function. This function is useful for checking if there are major errors
in your data. If you are observing an experiment with trends over time,
this will allow you to check whether or not the data follows the trend
you expect. You can then check which data points go against the trend in
the table below.

``` r
library(fatRats)
data <- data #use the same data
increase_decrease(data, "Body Weight 1", "Body Weight 2", "increase")
#> ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
#> ✔ forcats   1.0.0     ✔ stringr   1.5.1
#> ✔ lubridate 1.9.3     ✔ tibble    3.2.1
#> ✔ purrr     1.0.2     ✔ tidyr     1.3.1
#> ✔ readr     2.1.5     
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
#> ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```

<div id="lzclvsndpc" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#lzclvsndpc table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#lzclvsndpc thead, #lzclvsndpc tbody, #lzclvsndpc tfoot, #lzclvsndpc tr, #lzclvsndpc td, #lzclvsndpc th {
  border-style: none;
}
&#10;#lzclvsndpc p {
  margin: 0;
  padding: 0;
}
&#10;#lzclvsndpc .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#lzclvsndpc .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#lzclvsndpc .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#lzclvsndpc .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#lzclvsndpc .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#lzclvsndpc .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#lzclvsndpc .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#lzclvsndpc .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#lzclvsndpc .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#lzclvsndpc .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#lzclvsndpc .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#lzclvsndpc .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#lzclvsndpc .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#lzclvsndpc .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#lzclvsndpc .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#lzclvsndpc .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#lzclvsndpc .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#lzclvsndpc .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#lzclvsndpc .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#lzclvsndpc .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#lzclvsndpc .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#lzclvsndpc .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#lzclvsndpc .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#lzclvsndpc .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#lzclvsndpc .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#lzclvsndpc .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#lzclvsndpc .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#lzclvsndpc .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#lzclvsndpc .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#lzclvsndpc .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#lzclvsndpc .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#lzclvsndpc .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#lzclvsndpc .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#lzclvsndpc .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#lzclvsndpc .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#lzclvsndpc .gt_left {
  text-align: left;
}
&#10;#lzclvsndpc .gt_center {
  text-align: center;
}
&#10;#lzclvsndpc .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#lzclvsndpc .gt_font_normal {
  font-weight: normal;
}
&#10;#lzclvsndpc .gt_font_bold {
  font-weight: bold;
}
&#10;#lzclvsndpc .gt_font_italic {
  font-style: italic;
}
&#10;#lzclvsndpc .gt_super {
  font-size: 65%;
}
&#10;#lzclvsndpc .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#lzclvsndpc .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#lzclvsndpc .gt_indent_1 {
  text-indent: 5px;
}
&#10;#lzclvsndpc .gt_indent_2 {
  text-indent: 10px;
}
&#10;#lzclvsndpc .gt_indent_3 {
  text-indent: 15px;
}
&#10;#lzclvsndpc .gt_indent_4 {
  text-indent: 20px;
}
&#10;#lzclvsndpc .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_heading">
      <td colspan="3" class="gt_heading gt_title gt_font_normal" style>Check for : increase</td>
    </tr>
    <tr class="gt_heading">
      <td colspan="3" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style>Highlighting rows where Body Weight 2 does not increase from Body Weight 1</td>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Row Number">Row Number</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Body Weight 1">Body Weight 1</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Body Weight 2">Body Weight 2</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="id" class="gt_row gt_right">2</td>
<td headers="change1" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">22.26618</td>
<td headers="change2" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">22.09388</td></tr>
    <tr><td headers="id" class="gt_row gt_right">4</td>
<td headers="change1" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">23.22670</td>
<td headers="change2" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">22.83796</td></tr>
    <tr><td headers="id" class="gt_row gt_right">6</td>
<td headers="change1" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">22.71246</td>
<td headers="change2" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">22.58711</td></tr>
    <tr><td headers="id" class="gt_row gt_right">7</td>
<td headers="change1" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">19.32622</td>
<td headers="change2" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">19.17762</td></tr>
    <tr><td headers="id" class="gt_row gt_right">8</td>
<td headers="change1" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">26.20532</td>
<td headers="change2" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">25.76116</td></tr>
    <tr><td headers="id" class="gt_row gt_right">15</td>
<td headers="change1" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">20.01614</td>
<td headers="change2" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">19.64952</td></tr>
    <tr><td headers="id" class="gt_row gt_right">16</td>
<td headers="change1" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">21.19320</td>
<td headers="change2" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">21.18061</td></tr>
    <tr><td headers="id" class="gt_row gt_right">17</td>
<td headers="change1" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">20.97079</td>
<td headers="change2" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">20.83598</td></tr>
    <tr><td headers="id" class="gt_row gt_right">18</td>
<td headers="change1" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">20.60029</td>
<td headers="change2" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">20.53593</td></tr>
    <tr><td headers="id" class="gt_row gt_right">20</td>
<td headers="change1" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">22.34022</td>
<td headers="change2" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">22.19201</td></tr>
    <tr><td headers="id" class="gt_row gt_right">21</td>
<td headers="change1" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">22.64139</td>
<td headers="change2" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">22.59283</td></tr>
    <tr><td headers="id" class="gt_row gt_right">22</td>
<td headers="change1" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">23.51281</td>
<td headers="change2" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">23.49694</td></tr>
    <tr><td headers="id" class="gt_row gt_right">23</td>
<td headers="change1" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">20.68464</td>
<td headers="change2" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">20.50044</td></tr>
    <tr><td headers="id" class="gt_row gt_right">24</td>
<td headers="change1" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">26.93153</td>
<td headers="change2" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">15.92768</td></tr>
    <tr><td headers="id" class="gt_row gt_right">27</td>
<td headers="change1" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">18.67069</td>
<td headers="change2" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">18.63924</td></tr>
    <tr><td headers="id" class="gt_row gt_right">28</td>
<td headers="change1" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">19.20827</td>
<td headers="change2" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">18.86431</td></tr>
    <tr><td headers="id" class="gt_row gt_right">29</td>
<td headers="change1" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">19.05964</td>
<td headers="change2" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">18.99461</td></tr>
    <tr><td headers="id" class="gt_row gt_right">32</td>
<td headers="change1" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">31.03108</td>
<td headers="change2" class="gt_row gt_right" style="color: #FF0000; font-weight: bold;">19.07309</td></tr>
  </tbody>
  &#10;  
</table>
</div>
