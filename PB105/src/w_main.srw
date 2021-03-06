$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type st_3 from statictext within w_main
end type
type st_2 from statictext within w_main
end type
type st_1 from statictext within w_main
end type
type ddlb_encoding from dropdownlistbox within w_main
end type
type mle_output from multilineedit within w_main
end type
type mle_input from multilineedit within w_main
end type
type cb_decode from commandbutton within w_main
end type
type cb_encode from commandbutton within w_main
end type
end forward

global type w_main from window
integer width = 2318
integer height = 1328
boolean titlebar = true
string title = "PowerBuilder Generate Base64 Without API"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_3 st_3
st_2 st_2
st_1 st_1
ddlb_encoding ddlb_encoding
mle_output mle_output
mle_input mle_input
cb_decode cb_decode
cb_encode cb_encode
end type
global w_main w_main

type prototypes
Function Boolean CryptBinaryToString ( Blob pbBinary, ULong cbBinary, ULong dwFlags, Ref String pszString, 	Ref ULong pcchString ) Library "crypt32.dll" Alias For "CryptBinaryToStringW"
Function Boolean CryptBinaryToString ( Blob pbBinary, ULong cbBinary, ULong dwFlags, Long pszString, Ref ULong pcchString ) Library "crypt32.dll" Alias For "CryptBinaryToStringW"
Function Boolean CryptStringToBinary ( String pszString, ULong cchString, ULong dwFlags, Ref Blob pbBinary, Ref ULong pcbBinary, Ref ULong pdwSkip, Ref ULong pdwFlags ) Library "crypt32.dll" Alias For "CryptStringToBinaryW"

end prototypes

forward prototypes
public function encoding wf_getencoding ()
end prototypes

public function encoding wf_getencoding ();Encoding lEncoding

lEncoding = EncodingANSI! //default

If ddlb_encoding.Text = "EncodingANSI!" Then
	lEncoding = EncodingANSI!
ElseIf ddlb_encoding.Text = "EncodingUTF8!" Then
	lEncoding = EncodingUTF8!
ElseIf ddlb_encoding.Text = "EncodingUTF16LE!" Then
	lEncoding = EncodingUTF16LE!
ElseIf ddlb_encoding.Text = "EncodingUTF16BE!" Then
	lEncoding = EncodingUTF16BE!
End If

Return  lEncoding
end function

on w_main.create
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_encoding=create ddlb_encoding
this.mle_output=create mle_output
this.mle_input=create mle_input
this.cb_decode=create cb_decode
this.cb_encode=create cb_encode
this.Control[]={this.st_3,&
this.st_2,&
this.st_1,&
this.ddlb_encoding,&
this.mle_output,&
this.mle_input,&
this.cb_decode,&
this.cb_encode}
end on

on w_main.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_encoding)
destroy(this.mle_output)
destroy(this.mle_input)
destroy(this.cb_decode)
destroy(this.cb_encode)
end on

type st_3 from statictext within w_main
integer x = 64
integer y = 696
integer width = 343
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Output Text:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_main
integer x = 64
integer y = 180
integer width = 329
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Input Text:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_main
integer x = 50
integer y = 44
integer width = 315
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Encoding:"
boolean focusrectangle = false
end type

type ddlb_encoding from dropdownlistbox within w_main
integer x = 366
integer y = 40
integer width = 914
integer height = 400
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
string item[] = {"EncodingANSI!","EncodingUTF8!","EncodingUTF16LE!","EncodingUTF16BE!"}
borderstyle borderstyle = stylelowered!
end type

event constructor;ddlb_encoding.selectitem( 2)
end event

type mle_output from multilineedit within w_main
integer x = 50
integer y = 784
integer width = 2167
integer height = 400
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type mle_input from multilineedit within w_main
integer x = 50
integer y = 260
integer width = 2167
integer height = 400
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "https://programmingmethodsit.com/"
borderstyle borderstyle = stylelowered!
end type

type cb_decode from commandbutton within w_main
integer x = 1664
integer y = 40
integer width = 297
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Decode"
end type

event clicked;n_base64 ln_base64
String ls_input, ls_out
Encoding lEncoding

lEncoding = wf_getencoding( )
ls_input = mle_input.Text

ls_out = ln_base64.of_decode( ls_input, lEncoding)

mle_output.Text = ls_out

end event

type cb_encode from commandbutton within w_main
integer x = 1353
integer y = 40
integer width = 297
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Encode"
end type

event clicked;n_base64 ln_base64
String ls_input, ls_out
Encoding lEncoding

lEncoding = wf_getencoding( )
ls_input = mle_input.Text

ls_out = ln_base64.of_encode( ls_input , lEncoding) 

mle_output.Text = ls_out

end event

