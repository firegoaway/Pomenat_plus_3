# Pomenat+ 3

### Язык альфы: **AHK**

### ~~Язык релиза: **JS/Python**~~

### Интерфейс: **нативный**

## Особенности и описание работы утилиты
### По сути, это кликер.

Особенность заключается в том, что она использует не стандартный ImageSearch, а мощную поисковую библиотеку, позволяющую преобразовывать набор захваченных пикселей в `ASCII структуру`.

![Screenshot of an ASCII structure of captured screen image](https://raw.githubusercontent.com/firegoaway/Pomenat_plus_3/main/gitpics/pic1.PNG)

Такая структуа повторяет активные пиксели и игнорирует периферические слабо выраженные пиксели.

![Original captured image](https://raw.githubusercontent.com/firegoaway/Pomenat_plus_3/main/gitpics/Pic2.PNG)
![Modified image](https://raw.githubusercontent.com/firegoaway/Pomenat_plus_3/main/gitpics/Pic3.PNG)

Полученное при завате изображение токенизируется в численно-буквенный вид смециальным образом, образуя особый посев символов ASCII, который соответствует захваченному набору сильно выраженных пикселей, позволяя обнаруживать не только тело захваченного изображения на экране, но и его метаморфических подобий по шейду, положению пикселей, размеру и соотношению сторон.

![Tokenized image](https://raw.githubusercontent.com/firegoaway/Pomenat_plus_3/main/gitpics/Pic4.PNG)

## Статус
### Альфа

## Сторонние библиотеки
### Утилита использует одну из самых мощных поисковых библиотек: [graphicsearch.ahk](https://chunjee.github.io/graphicsearch.ahk/)
