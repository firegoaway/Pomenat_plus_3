#Include graphicsearch.ahk\export.ahk
 t1 := A_TickCount, X := Y := ""
graphicsearch_query := "|<>*192$72.zk7w00000000U8Dw00000000U8AA3s000000h8A42N020000b8A42DhjhRTzb8A42CxzhTzjd8AA2CzchFTgU8CQ2DajzT+7zs6M00001000U"
 resultObj := graphicsearch.search(GraphicSearch_query)
 if (resultObj) {
   X := resultObj.1.x, Y := resultObj.1.y, Comment := resultObj.1.id
   ; Click, %X%, %Y%
 }

 ToolTip, 1024, Tip, % "Found :`t" Round(resultObj.MaxIndex())
   . "`n`nTime  :`t" (A_TickCount-t1) " ms"
   . "`n`nPos   :`t" X ", " Y
   . "`n`nResult:`t" (resultObj ? "Success !" : "Failed !")

 for i,v in resultObj
   if (i<=2)
     graphicsearch.mouseTip(resultObj[i].x, resultObj[i].y)
	 