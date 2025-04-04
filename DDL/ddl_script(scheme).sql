DROP TABLE IF EXISTS DiseaseToDepartment CASCADE;
DROP TABLE IF EXISTS Disease CASCADE;
DROP TABLE IF EXISTS InpatientTreatment CASCADE;
DROP TABLE IF EXISTS OutpatientTreatment CASCADE;
DROP TABLE IF EXISTS Patient CASCADE;
DROP TABLE IF EXISTS HospitalRoom CASCADE;
DROP TABLE IF EXISTS Department CASCADE;
DROP TABLE IF EXISTS HospitalBuilding CASCADE;
DROP TABLE IF EXISTS Clinic CASCADE;
DROP TABLE IF EXISTS Hospital CASCADE;

CREATE TABLE Hospital (
    id SERIAL PRIMARY KEY,
    name VARCHAR(128) NOT NULL,
    address VARCHAR(128) NOT NULL
);

CREATE TABLE Clinic (
    id SERIAL PRIMARY KEY,
    hospital_id INT NOT NULL,
    name VARCHAR(128) NOT NULL,
    address VARCHAR(128),
    FOREIGN KEY (hospital_id) REFERENCES Hospital(id) ON DELETE CASCADE
);

CREATE TABLE HospitalBuilding (
    id SERIAL PRIMARY KEY,
    hospital_id INT NOT NULL,
    name VARCHAR(128) NOT NULL,
    FOREIGN KEY (hospital_id) REFERENCES Hospital(id) ON DELETE CASCADE
);

CREATE TABLE Department (
    id SERIAL PRIMARY KEY,
    hospital_building_id INT NOT NULL,
    name VARCHAR(128) NOT NULL,
    FOREIGN KEY (hospital_building_id) REFERENCES HospitalBuilding(id) ON DELETE CASCADE
);

CREATE TABLE HospitalRoom (
    id SERIAL PRIMARY KEY,
    department_id INT NOT NULL,
    beds_number INT NOT NULL,
    type_room TEXT CHECK (type_room IN ('standard', 'intensive', 'vip')) NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Department(id) ON DELETE CASCADE
);

CREATE TABLE Patient (
    id SERIAL PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    surname VARCHAR(64) NOT NULL,
    patronymic VARCHAR(64),
    birth_date DATE NOT NULL,
    gender TEXT CHECK (gender IN ('male', 'female')) NOT NULL,
    phone VARCHAR(15),
    passport_number VARCHAR(12)
);

CREATE TABLE InpatientTreatment (
    id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    hospital_room_id INT NOT NULL,
    diagnosis TEXT NOT NULL,
    patient_temperature DECIMAL(4,2) NOT NULL CHECK (patient_temperature < 42.0),
    begin_date DATE NOT NULL,
    end_date DATE,
    CHECK (end_date IS NULL OR begin_date <= end_date),
    FOREIGN KEY (patient_id) REFERENCES Patient(id) ON DELETE CASCADE,
    FOREIGN KEY (hospital_room_id) REFERENCES HospitalRoom(id) ON DELETE CASCADE
);

CREATE TABLE OutpatientTreatment (
    id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    clinic_id INT NOT NULL,
    begin_date DATE NOT NULL,
    end_date DATE,
    CHECK (end_date IS NULL OR begin_date <= end_date),
    FOREIGN KEY (patient_id) REFERENCES Patient(id) ON DELETE CASCADE,
    FOREIGN KEY (clinic_id) REFERENCES Clinic(id) ON DELETE CASCADE
);

CREATE TABLE Disease (
    id SERIAL PRIMARY KEY,
    name VARCHAR(128) NOT NULL,
    icd_code VARCHAR(10) NOT NULL,
    chronic BOOLEAN DEFAULT FALSE,
    contagious BOOLEAN DEFAULT FALSE,
    symptoms TEXT
);

CREATE TABLE DiseaseToDepartment (
    id SERIAL PRIMARY KEY,
    department_id INT NOT NULL,
    disease_id INT NOT NULL,
    UNIQUE(department_id, disease_id),
    FOREIGN KEY (department_id) REFERENCES Department(id) ON DELETE CASCADE,
    FOREIGN KEY (disease_id) REFERENCES Disease(id) ON DELETE CASCADE
);
