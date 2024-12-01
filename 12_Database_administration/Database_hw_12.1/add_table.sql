CREATE TABLE IF NOT EXISTS public.cities (
    city_id serial PRIMARY KEY NOT NULL,
    city varchar(255)
);
COMMENT ON TABLE public.cities IS '### Таблица Городов - cities.';

CREATE TABLE IF NOT EXISTS public.branch_address (
    address_id serial PRIMARY KEY NOT NULL,
    city_id integer REFERENCES cities(city_id),
    street varchar(255)
);
COMMENT ON TABLE public.branch_address IS '### Таблица Адрес филиала - branch_address.';

CREATE TABLE IF NOT EXISTS public.positions (
    position_id smallint PRIMARY KEY NOT NULL,
    position varchar(125)
);
COMMENT ON TABLE public.positions IS '### Таблица Должности - positions.';

CREATE TABLE IF NOT EXISTS public.types_divisions (
    type_division_id serial PRIMARY KEY NOT NULL,
    type_division varchar(125)
);
COMMENT ON TABLE public.types_divisions IS '### Таблица Типы подразделений - types_divisions.';

CREATE TABLE IF NOT EXISTS public.divisions (
    division_id serial PRIMARY KEY NOT NULL,
    division varchar(125),
    type_division_id integer REFERENCES types_divisions(type_division_id)
);
COMMENT ON TABLE public.divisions IS '### Таблица Структурное подразделение - divisions.';

CREATE TABLE IF NOT EXISTS public.projects (
    project_id serial PRIMARY KEY NOT NULL,
    project varchar(255)
);
COMMENT ON TABLE public.projects IS '### Таблица Проекты - projects.';

CREATE TABLE IF NOT EXISTS public.staff (
    employee_id serial PRIMARY KEY NOT NULL,
    employee_name varchar(125),
    salary decimal(8, 2),
    date_hiring date,
    position_id smallint REFERENCES positions(position_id),
    division_id integer REFERENCES divisions(division_id),
    address_id integer REFERENCES branch_address(address_id),
    project_id integer REFERENCES projects(project_id)
);
COMMENT ON TABLE public.staff IS '### Таблица Сотрудники - staff.';
