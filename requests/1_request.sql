-- Пациенты, рожденные после 1990 года (Имя, Фамилия, дата рождения)
SELECT name, surname, birth_date
FROM Patient
WHERE birth_date > '1990-01-01'
ORDER BY birth_date;
