CREATE TABLE paciente (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nome_paciente VARCHAR(255),
    descricao_cama VARCHAR(255)
);

CREATE TABLE profissional (
	id_profissional INT AUTO_INCREMENT PRIMARY KEY,
    nome_usuaraio VARCHAR(255),
    cronograma_horas VARCHAR(255)
);


CREATE TABLE agenda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT,
    id_profissional INT,
    protocolo_registro_hora_entrada VARCHAR(255),
	FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
	FOREIGN KEY (id_profissional) REFERENCES profissional(id_profissional)
);
