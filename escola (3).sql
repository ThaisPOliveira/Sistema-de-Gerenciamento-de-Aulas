-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 12/11/2025 às 15:40
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `escola`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `alunos`
--

CREATE TABLE `alunos` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `idade` int(11) DEFAULT NULL,
  `responsavel` varchar(100) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `alunos`
--

INSERT INTO `alunos` (`id`, `nome`, `idade`, `responsavel`, `telefone`) VALUES
(1, 'Thais Rafa', 12, 'Maria', '99999-1111'),
(2, 'Pedro Dudu', 13, 'João', '99999-2222'),
(3, 'Matheus', 14, 'Carla', '99999-3333'),
(4, 'Ana Beatriz Silva', 10, 'Carla Silva', '(11) 91234-5678'),
(5, 'João Pedro Santos', 11, 'Marcos Santos', '(11) 99876-5432'),
(6, 'Maria Eduarda Oliveira', 9, 'Fernanda Oliveira', '(11) 97777-1111'),
(7, 'Lucas Gabriel Costa', 12, 'Patrícia Costa', '(11) 98888-2222'),
(8, 'Isabela Rocha Lima', 8, 'Roberta Lima', '(11) 96666-3333'),
(9, 'Pedro Henrique Souza', 10, 'Ricardo Souza', '(11) 95555-4444'),
(10, 'Laura Martins', 9, 'André Martins', '(11) 94444-5555'),
(11, 'Gustavo Almeida', 11, 'Tatiane Almeida', '(11) 93333-6666'),
(12, 'Sofia Ribeiro', 8, 'Juliana Ribeiro', '(11) 92222-7777'),
(13, 'Rafael Fernandes', 12, 'Luciana Fernandes', '(11) 91111-8888');

-- --------------------------------------------------------

--
-- Estrutura para tabela `disciplina`
--

CREATE TABLE `disciplina` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `disciplina`
--

INSERT INTO `disciplina` (`id`, `nome`, `descricao`) VALUES
(1, 'Programação', 'Python\r\nJava'),
(2, 'logica', 'so os loucos sabem'),
(3, 'Banco de Dados', 'SQL'),
(4, 'Mobile', 'Desenvolvimento de aplicativos'),
(5, 'Games JR', 'aprender Construct'),
(7, 'Games pleno', 'Aprender GameMaker e UNity');

-- --------------------------------------------------------

--
-- Estrutura para tabela `turma`
--

CREATE TABLE `turma` (
  `id_turma` int(11) NOT NULL,
  `nome_turma` varchar(100) NOT NULL,
  `nome_professor` varchar(100) NOT NULL,
  `nome_aluno` text DEFAULT NULL,
  `horario` time NOT NULL,
  `id_disciplina` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `turma`
--

INSERT INTO `turma` (`id_turma`, `nome_turma`, `nome_professor`, `nome_aluno`, `horario`, `id_disciplina`) VALUES
(9, 'info', 'GALEGUINHOFAZUELI', '1,2,3', '12:33:00', 1),
(10, 'info', 'Rafael Castro', '2,3', '16:00:00', 4),
(11, 'info123', 'Rafael Castro', '2,3', '15:30:00', 1),
(12, '12312', 'edu', '2', '21:02:00', 2),
(13, 'turma A', 'GALEGUINHOFAZUELI', '1,3,9,13', '16:30:00', 3);

-- --------------------------------------------------------

--
-- Estrutura para tabela `turma_aluno`
--

CREATE TABLE `turma_aluno` (
  `id_turma` int(11) NOT NULL,
  `id_aluno` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp(),
  `tipo` varchar(20) DEFAULT 'professor'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `senha`, `data_criacao`, `tipo`) VALUES
(1, 'Thais Oliveira', 'thaisopereira02@gmail.com', '12312', '2025-10-22 00:46:09', 'admin'),
(2, 'Matheus Oliveira', 'mat@mat', '123', '2025-10-22 21:45:44', 'admin'),
(3, 'Rafael Castro', 'rafa@baitola', '123', '2025-10-22 21:57:21', 'professor'),
(4, 'edu', 'dudu@gordinho', '123', '2025-10-22 21:59:54', 'professor'),
(5, 'GALEGUINHOFAZUELI', 'GA@GA', '12', '2025-10-23 00:34:11', 'professor'),
(8, 'matheus', 'ma@ma', '123', '2025-10-31 23:22:32', 'professor'),
(9, 'matheus', 'matheus@mat', '123', '2025-11-05 13:37:39', 'professor');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `alunos`
--
ALTER TABLE `alunos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `disciplina`
--
ALTER TABLE `disciplina`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome` (`nome`);

--
-- Índices de tabela `turma`
--
ALTER TABLE `turma`
  ADD PRIMARY KEY (`id_turma`),
  ADD KEY `fk_turma_disciplina` (`id_disciplina`);

--
-- Índices de tabela `turma_aluno`
--
ALTER TABLE `turma_aluno`
  ADD PRIMARY KEY (`id_turma`,`id_aluno`),
  ADD KEY `id_aluno` (`id_aluno`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `alunos`
--
ALTER TABLE `alunos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `disciplina`
--
ALTER TABLE `disciplina`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `turma`
--
ALTER TABLE `turma`
  MODIFY `id_turma` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `turma`
--
ALTER TABLE `turma`
  ADD CONSTRAINT `fk_turma_disciplina` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplina` (`id`) ON UPDATE CASCADE;

--
-- Restrições para tabelas `turma_aluno`
--
ALTER TABLE `turma_aluno`
  ADD CONSTRAINT `turma_aluno_ibfk_1` FOREIGN KEY (`id_turma`) REFERENCES `turma` (`id_turma`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `turma_aluno_ibfk_2` FOREIGN KEY (`id_aluno`) REFERENCES `alunos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
