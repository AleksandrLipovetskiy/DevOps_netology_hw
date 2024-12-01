Задание "Подъём инфраструктуры в Yandex Cloud" - Липовецкий Александр

[Ссылка на GIT проекта](https://github.com/AleksandrLipovetskiy/terraform_YC)

Для реализации проекта в задании подготовлен скрипт deploy.sh

[Ссылка на файл deploy.sh](https://github.com/AleksandrLipovetskiy/terraform_YC/blob/main/terraform-neto/deploy.sh)

Скрипт при помощи terraform разворачивает в облаке виртуальную машину, после чего проверяет ее доступность.
После этого, когда машина доступна, передает управление ansible, который разворачивает на виртуальной машине сервер nginx, заливает конфигурационные файлы nginx и веб-ресурса, после чего проверяет его доступность.

[Лог файл выполнения скрипта deploy.sh](https://github.com/AleksandrLipovetskiy/terraform_YC/blob/main/deploy.log)

Вот скрин стартовой страницы:
![Скрин стартовой страницы][def]

[def]: https://github.com/AleksandrLipovetskiy/terraform_YC/blob/main/scrin_index.png