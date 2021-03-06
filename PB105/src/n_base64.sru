$PBExportHeader$n_base64.sru
forward
global type n_base64 from nonvisualobject
end type
end forward

global type n_base64 from nonvisualobject autoinstantiate
end type

type variables
private:
	char code[] = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	
end variables

forward prototypes
public function string of_encode (blob plain)
public function string of_encode (string as_plain)
public function string of_encode (string as_plain, encoding aencoding)
public function string of_decode (string cypher, encoding aencoding)
public function string of_decode (string cypher)
end prototypes

public function string of_encode (blob plain);//====================================================================
// Function: n_base64.of_encode()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	blob	plain	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/01/09
//--------------------------------------------------------------------
// Usage: n_base64.of_encode ( blob plain )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

byte lbyte[]
Char lc_cypher[]
Long i,j,ll_loop
ULong lul_len,lul_tmp
Int li_mod

Integer li_idx, li_max

li_max = Len(plain)
For li_idx = 1 To li_max
	lbyte[li_idx] = Byte(BlobMid(plain, li_idx, 1))
Next

//lbyte = getByteArray(plain) //pb11.5 later
lul_len = UpperBound(lbyte)
li_mod = Mod(lul_len,3)
Choose Case li_mod
	Case 1
		lbyte[lul_len + 1] = 0
		lbyte[lul_len + 2] = 0
	Case 2
		lbyte[lul_len + 1] = 0
End Choose

ll_loop = UpperBound(lbyte) / 3

For i = 1 To ll_loop
	lul_tmp = lbyte[3 * i - 2] * 65536 + lbyte[3 * i - 1] * 256 + lbyte[3 * i]
	j += 1
	lc_cypher[j] = code[lul_tmp / 262144 + 1]
	lul_tmp = Mod(lul_tmp,262144)
	j += 1
	lc_cypher[j] = code[lul_tmp / 4096 + 1]
	lul_tmp = Mod(lul_tmp,4096)
	j += 1
	lc_cypher[j] = code[lul_tmp / 64 + 1]
	lul_tmp = Mod(lul_tmp,64)
	j += 1
	lc_cypher[j] = code[lul_tmp + 1]
Next

Choose Case li_mod
	Case 1
		lc_cypher[j] = '='
		lc_cypher[j - 1] = '='
	Case 2
		lc_cypher[j] = '='
End Choose

Return lc_cypher


end function

public function string of_encode (string as_plain);//====================================================================
// Function: n_base64.of_encode()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_plain	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/01/09
//--------------------------------------------------------------------
// Usage: n_base64.of_encode ( string as_plain )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Blob lb_data
lb_data = Blob(as_plain, EncodingUTF8!)
Return of_encode(lb_data)

end function

public function string of_encode (string as_plain, encoding aencoding);//====================================================================
// Function: n_base64.of_encode()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string  	as_plain 	
// 	value	encoding	aencoding	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/01/09
//--------------------------------------------------------------------
// Usage: n_base64.of_encode ( string as_plain, encoding aencoding )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Blob lb_data
lb_data = Blob(as_plain, aEncoding)
Return of_encode(lb_data)

end function

public function string of_decode (string cypher, encoding aencoding);//====================================================================
// Function: n_base64.of_decode()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string  	cypher   	
// 	value	Encoding	aEncoding	
//--------------------------------------------------------------------
// Returns:  blob
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/01/09
//--------------------------------------------------------------------
// Usage: n_base64.of_decode ( string cypher, encoding aencoding )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Blob lblb_plain
Long i,j,ll_loop
Char lc_cypher[]
ULong lul_tmp,lul_len
byte lbyte[]
Int li_mod

lc_cypher = cypher
lul_len = UpperBound(lc_cypher)
If lc_cypher[lul_len] = '=' Then
	li_mod = 2
	lc_cypher[lul_len] = 'A'
End If
If lc_cypher[lul_len - 1] = '=' Then
	li_mod = 1
	lc_cypher[lul_len - 1] = 'A'
End If

ll_loop = UpperBound(lc_cypher) / 4
For i = 1 To ll_loop
	lul_tmp = (Pos(code,lc_cypher[4 * i - 3]) - 1) * 262144 +&
		(Pos(code,lc_cypher[4 * i - 2]) - 1) * 4096 +&
		(Pos(code,lc_cypher[4 * i - 1]) - 1) * 64 +&
		(Pos(code,lc_cypher[4 * i]) - 1)
	
	j += 1
	lbyte[j] = lul_tmp / 65536
	lul_tmp = Mod(lul_tmp,65536)
	j += 1
	lbyte[j] = lul_tmp / 256
	lul_tmp = Mod(lul_tmp,256)
	j += 1
	lbyte[j] = lul_tmp
Next

//lblb_plain = blob(lbyte) //pb11.5 later

Long lBlobLen
Long lBytePos

lBlobLen = UpperBound(lbyte)
lblb_plain = Blob(Space(lBlobLen),aEncoding)
For lBytePos = 1 To lBlobLen
	BlobEdit(lblb_plain, lBytePos, lbyte[lBytePos], aEncoding)
Next

Choose Case li_mod
	Case 1
		lblb_plain = BlobMid(lblb_plain,1,Len(lblb_plain) - 2)
	Case 2
		lblb_plain = BlobMid(lblb_plain,1,Len(lblb_plain) - 1)
End Choose

Return String(lblb_plain, aEncoding)



end function

public function string of_decode (string cypher);//====================================================================
// Function: n_base64.of_decode()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	cypher	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/01/09
//--------------------------------------------------------------------
// Usage: n_base64.of_decode ( string cypher )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Return  of_decode(cypher, EncodingUTF8!)


end function

on n_base64.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_base64.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

