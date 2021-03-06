$PBExportHeader$pbgeneratebase64.sra
$PBExportComments$Generated Application Object
forward
global type pbgeneratebase64 from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type pbgeneratebase64 from application
string appname = "pbgeneratebase64"
end type
global pbgeneratebase64 pbgeneratebase64

on pbgeneratebase64.create
appname="pbgeneratebase64"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on pbgeneratebase64.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;open(w_main)
end event

