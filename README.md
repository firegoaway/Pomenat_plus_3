# Pomenat+ 3

> Язык альфы: **AHK**

> ~~Язык релиза: **JS/Python**~~

> Интерфейс: **нативный**

## Особенности и описание работы утилиты
Эта утилита является средством автоматизации и предназначена для быстрого переименования помещений в **Fenix+ 3**.

### Поддерживаемые версии Fenix+
> **Fenix+ 3**

**По сути, это кликер.**

Особенность заключается в использовании не стандартного **ImageSearch**, а мощной поисковой библиотеки, позволяющей преобразовывать набор захваченных пикселей в `ASCII структуру`.

![Screenshot of an ASCII structure of captured screen image](https://raw.githubusercontent.com/firegoaway/Pomenat_plus_3/main/.gitpics/pic1.PNG)

Такая структура повторяет активные пиксели и игнорирует периферические слабо выраженные пиксели.

![Original captured image](https://raw.githubusercontent.com/firegoaway/Pomenat_plus_3/main/.gitpics/Pic2.PNG)
![Modified image](https://raw.githubusercontent.com/firegoaway/Pomenat_plus_3/main/.gitpics/Pic3.PNG)

Полученное при завате изображение токенизируется в численно-буквенный вид специальным образом, образуя особый посев символов ASCII, который соответствует захваченному набору сильно выраженных пикселей, позволяя обнаруживать не только тело захваченного изображения на экране, но и его морфологические подобия по оттенкам, положению пикселей, размеру и соотношению сторон.

```AutoHotKey
 t1 := A_TickCount, X := Y := ""
graphicsearch_query := "|<>*164$45.y0000006L/ihRermjhpfxSyJzcxFvomzprzhOs0001000U"	;	TOKEN
 resultObj := graphicsearch.search(GraphicSearch_query)
 if (resultObj) {
   X := resultObj.1.x, Y := resultObj.1.y, Comment := resultObj.1.id
   ; Click, %X%, %Y%
 }
 
 for i,v in resultObj
   if (i<=2)
     graphicsearch.mouseTip(resultObj[i].x, resultObj[i].y)
```

**Результат:**
![firegoaway_pomenat_demo_compressed](https://raw.githubusercontent.com/firegoaway/Pomenat_plus_3/main/.gitpics/pomenat_demo_compressed.gif)

## Статус разработки
> Альфа

## Сторонние библиотеки
Утилита использует одну из самых мощных поисковых библиотек: [**graphicsearch.ahk**](https://chunjee.github.io/graphicsearch.ahk/)

## Как установить и пользоваться
| № п/п | Действие |
|---------|---------|
| 1 | Скачайте последнюю версию **Pomenat+ 3** в формате **.zip** в разделе [**Releases**](https://github.com/firegoaway/Pomenat_plus_3/releases);     |
| 2 | Разархиваруйте в любое удобное место;      |
| 3 | Запустите **Pomenat+ 3.exe**;      |
| 4 | Проследуйте инструкции в появившемся окне.      |

## Профилактика вирусов и угроз
- **Pomenat+ 3** предоставляется "как есть".
- Актуальная версия утилиты доступна в разделе [**Releases**](https://github.com/firegoaway/Pomenat_plus_3/releases).
- Файлы, каким-либо образом полученные не из текущего репозитория, несут потенциальную угрозу вашему ПК.
- Файл с расширением **.exe**, полученный из данного репозитория, имеет уникальную Хэш-сумму, позволяющую отличить оригинальную утилиту от подделки. 
- Хэш-сумма обновляется только при обновлении версии утилиты и всегда доступна в конце файла **README.md**.

### Актуальная Хэш-сумма
> **6610b4e988552e7f170fc3288962495c**