# Pomenat+ 3

### Язык альфы: **AHK**

### ~~Язык релиза: **JS/Python**~~

### Интерфейс: **нативный**

## Особенности и описание работы утилиты
### По сути, это кликер.

Особенность заключается в использовании не стандартного **ImageSearch**, а мощной поисковой библиотеки, позволяющей преобразовывать набор захваченных пикселей в `ASCII структуру`.

![Screenshot of an ASCII structure of captured screen image](https://raw.githubusercontent.com/firegoaway/Pomenat_plus_3/main/gitpics/pic1.PNG)

Такая структуа повторяет активные пиксели и игнорирует периферические слабо выраженные пиксели.

![Original captured image](https://raw.githubusercontent.com/firegoaway/Pomenat_plus_3/main/gitpics/Pic2.PNG)
![Modified image](https://raw.githubusercontent.com/firegoaway/Pomenat_plus_3/main/gitpics/Pic3.PNG)

Полученное при завате изображение токенизируется в численно-буквенный вид специальным образом, образуя особый посев символов ASCII, который соответствует захваченному набору сильно выраженных пикселей, позволяя обнаруживать не только тело захваченного изображения на экране, но и его морфологические подобия по оттенкам, положению пикселей, размеру и соотношению сторон.

```
 t1 := A_TickCount, X := Y := ""
graphicsearch_query := "|<>*164$45.y0000006L/ihRermjhpfxSyJzcxFvomzprzhOs0001000U"
 resultObj := graphicsearch.search(GraphicSearch_query)
 if (resultObj) {
   X := resultObj.1.x, Y := resultObj.1.y, Comment := resultObj.1.id
   ; Click, %X%, %Y%
 }

 MsgBox, 4096, Tip, % "Found :`t" Round(resultObj.MaxIndex())
   . "`n`nTime  :`t" (A_TickCount-t1) " ms"
   . "`n`nPos   :`t" X ", " Y
   . "`n`nResult:`t" (resultObj ? "Success !" : "Failed !")

 for i,v in resultObj
   if (i<=2)
     graphicsearch.mouseTip(resultObj[i].x, resultObj[i].y)
```

## Статус
> Альфа

## Сторонние библиотеки
### Утилита использует одну из самых мощных поисковых библиотек: [graphicsearch.ahk](https://chunjee.github.io/graphicsearch.ahk/)
