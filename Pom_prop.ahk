#Include graphicsearch.ahk\export.ahk
 t1 := A_TickCount, X := Y := ""
graphicsearch_query := "|<>*164$45.y0000006L/ihRermjhpfxSyJzcxFvomzprzhOs0001000U"
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
	 