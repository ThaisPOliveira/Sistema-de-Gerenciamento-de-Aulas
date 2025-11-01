-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 01, 2025 at 08:34 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `escola`
--

-- --------------------------------------------------------

--
-- Table structure for table `disciplina`
--

CREATE TABLE `disciplina` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `disciplina`
--

INSERT INTO `disciplina` (`id`, `nome`, `descricao`) VALUES
(1, 'ProgramaÃ§Ã£o', 'Python\r\nJava'),
(2, 'logica', 'so os loucos sabem'),
(3, 'Banco de Dados', 'SQL'),
(4, 'Mobile', 'Desenvolvimento de aplicativos');

-- --------------------------------------------------------

--
-- Table structure for table `turma`
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
-- Dumping data for table `turma`
--

INSERT INTO `turma` (`id_turma`, `nome_turma`, `nome_professor`, `nome_aluno`, `horario`, `id_disciplina`) VALUES
(1, 'ADS', 'ricardo', 'thais rafa pedro dudu e matheus', '19:51:00', 1),
(3, 'TURMA A', 'Matheus', 'Samara', '21:34:00', 2),
(5, 'TURMA C', 'Thais', 'Dudu', '20:38:00', 3);

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `senha`, `data_criacao`) VALUES
(1, 'Thais Oliveira', 'thaisopereira02@gmail.com', '12312', '2025-10-22 00:46:09'),
(2, 'Matheus Oliveira', 'Math@gmail', '123', '2025-10-22 21:45:44'),
(3, 'Rafael Castro', 'rafa@baitola', '123', '2025-10-22 21:57:21'),
(4, 'edu', 'dudu@gordinho', '123', '2025-10-22 21:59:54'),
(5, 'GALEGUINHOFAZUELI', 'GA@GA', '12', '2025-10-23 00:34:11'),
(8, 'matheus', 'ma@ma', '123', '2025-10-31 23:22:32');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `disciplina`
--
ALTER TABLE `disciplina`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome` (`nome`);

--
-- Indexes for table `turma`
--
ALTER TABLE `turma`
  ADD PRIMARY KEY (`id_turma`),
  ADD KEY `fk_turma_disciplina` (`id_disciplina`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `disciplina`
--
ALTER TABLE `disciplina`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `turma`
--
ALTER TABLE `turma`
  MODIFY `id_turma` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `turma`
--
ALTER TABLE `turma`
  ADD CONSTRAINT `fk_turma_disciplina` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplina` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
