DROP DATABASE IF EXISTS `scorepoint`;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `scorepoint` ;
CREATE SCHEMA IF NOT EXISTS `scorepoint` DEFAULT CHARACTER SET utf8 ;
USE `scorepoint` ;

-- -----------------------------------------------------
-- Table `scorepoint`.`ACL`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scorepoint`.`ACL` ;

CREATE TABLE IF NOT EXISTS `scorepoint`.`ACL` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `model` VARCHAR(512) NULL DEFAULT NULL,
  `property` VARCHAR(512) NULL DEFAULT NULL,
  `accessType` VARCHAR(512) NULL DEFAULT NULL,
  `permission` VARCHAR(512) NULL DEFAULT NULL,
  `principalType` VARCHAR(512) NULL DEFAULT NULL,
  `principalId` VARCHAR(512) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `scorepoint`.`Role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scorepoint`.`Role` ;

CREATE TABLE IF NOT EXISTS `scorepoint`.`Role` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(512) NOT NULL,
  `description` VARCHAR(512) NULL DEFAULT NULL,
  `created` DATETIME NULL DEFAULT NULL,
  `modified` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `scorepoint`.`RoleMapping`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scorepoint`.`RoleMapping` ;

CREATE TABLE IF NOT EXISTS `scorepoint`.`RoleMapping` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `principalType` VARCHAR(512) NULL DEFAULT NULL,
  `principalId` VARCHAR(512) NULL DEFAULT NULL,
  `roleId` INT(11) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_RoleMapping_Role1`
    FOREIGN KEY (`roleId`)
    REFERENCES `scorepoint`.`Role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_RoleMapping_Role1_idx` ON `scorepoint`.`RoleMapping` (`roleId` ASC);


-- -----------------------------------------------------
-- Table `scorepoint`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scorepoint`.`user` ;

CREATE TABLE IF NOT EXISTS `scorepoint`.`user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `realm` VARCHAR(512) NULL DEFAULT NULL,
  `username` VARCHAR(512) NULL DEFAULT NULL,
  `password` VARCHAR(512) NOT NULL,
  `credentials` TEXT NULL DEFAULT NULL,
  `challenges` TEXT NULL DEFAULT NULL,
  `email` VARCHAR(512) NOT NULL,
  `emailVerified` TINYINT(1) NULL DEFAULT NULL,
  `verificationToken` VARCHAR(512) NULL DEFAULT NULL,
  `status` VARCHAR(512) NULL DEFAULT NULL,
  `created` DATETIME NULL DEFAULT NULL,
  `lastUpdated` DATETIME NULL DEFAULT NULL,
  `initialRank` INT NULL DEFAULT 0,
  `imageUrl` VARCHAR(255) NULL,
  `firstName` VARCHAR(2555) NULL,
  `lastName` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `scorepoint`.`accessToken`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scorepoint`.`accessToken` ;

CREATE TABLE IF NOT EXISTS `scorepoint`.`accessToken` (
  `id` VARCHAR(255) NOT NULL,
  `ttl` INT(11) NULL DEFAULT NULL,
  `created` DATETIME NULL DEFAULT NULL,
  `userid` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_accessToken_user1`
    FOREIGN KEY (`userid`)
    REFERENCES `scorepoint`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_accessToken_user1_idx` ON `scorepoint`.`accessToken` (`userid` ASC);


-- -----------------------------------------------------
-- Table `scorepoint`.`Tournament`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scorepoint`.`Tournament` ;

CREATE TABLE IF NOT EXISTS `scorepoint`.`Tournament` (
  `tournamentId` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `startDate` DATE NOT NULL,
  `endDate` DATE NULL DEFAULT NULL,
  `pointValue` INT(11) NOT NULL,
  PRIMARY KEY (`tournamentId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `name_UNIQUE` ON `scorepoint`.`Tournament` (`name` ASC);


-- -----------------------------------------------------
-- Table `scorepoint`.`Lobby`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scorepoint`.`Lobby` ;

CREATE TABLE IF NOT EXISTS `scorepoint`.`Lobby` (
  `lobbyId` INT(11) NOT NULL AUTO_INCREMENT,
  `active` BIT(1) NOT NULL DEFAULT b'1' COMMENT 'The User Team table enable to support a team',
  `creationDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tournamentId` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`lobbyId`),
  CONSTRAINT `fk_game_tournament1`
    FOREIGN KEY (`tournamentId`)
    REFERENCES `scorepoint`.`Tournament` (`tournamentId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_game_tournament1_idx` ON `scorepoint`.`Lobby` (`tournamentId` ASC);


-- -----------------------------------------------------
-- Table `scorepoint`.`Team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scorepoint`.`Team` ;

CREATE TABLE IF NOT EXISTS `scorepoint`.`Team` (
  `teamId` INT(11) NOT NULL AUTO_INCREMENT,
  `pair` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'the teams is of two people?',
  `active` BIT(1) NOT NULL DEFAULT b'1',
  `lobbyId` INT(11) NOT NULL,
  PRIMARY KEY (`teamId`),
  CONSTRAINT `fk_team_game1`
    FOREIGN KEY (`lobbyId`)
    REFERENCES `scorepoint`.`Lobby` (`lobbyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_team_game1_idx` ON `scorepoint`.`Team` (`lobbyId` ASC);


-- -----------------------------------------------------
-- Table `scorepoint`.`ChallengeRequest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scorepoint`.`ChallengeRequest` ;

CREATE TABLE IF NOT EXISTS `scorepoint`.`ChallengeRequest` (
  `challengeRequestId` INT(11) NOT NULL,
  `challengerTeamId` INT(11) NOT NULL COMMENT 'The team who is challenging to other ',
  `victimTeamId` INT(11) NOT NULL COMMENT 'the victim will be destroyed',
  PRIMARY KEY (`challengeRequestId`),
  CONSTRAINT `fk_challenge_request_team1`
    FOREIGN KEY (`challengerTeamId`)
    REFERENCES `scorepoint`.`Team` (`teamId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_challenge_request_team2`
    FOREIGN KEY (`victimTeamId`)
    REFERENCES `scorepoint`.`Team` (`teamId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_challenge_request_team1_idx` ON `scorepoint`.`ChallengeRequest` (`challengerTeamId` ASC);

CREATE INDEX `fk_challenge_request_team2_idx` ON `scorepoint`.`ChallengeRequest` (`victimTeamId` ASC);


-- -----------------------------------------------------
-- Table `scorepoint`.`Match`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scorepoint`.`Match` ;

CREATE TABLE IF NOT EXISTS `scorepoint`.`Match` (
  `matchId` INT(11) NOT NULL,
  `startDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `endDate` TIMESTAMP NULL DEFAULT NULL,
  `lobbyId` INT(11) NOT NULL,
  PRIMARY KEY (`matchId`),
  CONSTRAINT `fk_match_Lobby1`
    FOREIGN KEY (`lobbyId`)
    REFERENCES `scorepoint`.`Lobby` (`lobbyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_match_Lobby1_idx` ON `scorepoint`.`Match` (`lobbyId` ASC);


-- -----------------------------------------------------
-- Table `scorepoint`.`Game`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scorepoint`.`Game` ;

CREATE TABLE IF NOT EXISTS `scorepoint`.`Game` (
  `gameId` INT(11) NOT NULL AUTO_INCREMENT,
  `order` INT(11) NULL DEFAULT NULL,
  `matchId` INT(11) NOT NULL,
  `winnerTeamId` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`gameId`),
  CONSTRAINT `fk_set_match1`
    FOREIGN KEY (`matchId`)
    REFERENCES `scorepoint`.`Match` (`matchId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_set_team1`
    FOREIGN KEY (`winnerTeamId`)
    REFERENCES `scorepoint`.`Team` (`teamId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_set_match1_idx` ON `scorepoint`.`Game` (`matchId` ASC);

CREATE INDEX `fk_set_team1_idx` ON `scorepoint`.`Game` (`winnerTeamId` ASC);


-- -----------------------------------------------------
-- Table `scorepoint`.`TeamRequest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scorepoint`.`TeamRequest` ;

CREATE TABLE IF NOT EXISTS `scorepoint`.`TeamRequest` (
  `idteamRequest` INT(11) NOT NULL,
  `emiterTeamId` INT(11) NOT NULL,
  `receptorTeamId` INT(11) NOT NULL,
  `creationDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idteamRequest`),
  CONSTRAINT `fk_teamRequest_user1`
    FOREIGN KEY (`emiterTeamId`)
    REFERENCES `scorepoint`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_teamRequest_user2`
    FOREIGN KEY (`receptorTeamId`)
    REFERENCES `scorepoint`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_teamRequest_user1_idx` ON `scorepoint`.`TeamRequest` (`emiterTeamId` ASC);

CREATE INDEX `fk_teamRequest_user2_idx` ON `scorepoint`.`TeamRequest` (`receptorTeamId` ASC);


-- -----------------------------------------------------
-- Table `scorepoint`.`TeamSetScore`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scorepoint`.`TeamSetScore` ;

CREATE TABLE IF NOT EXISTS `scorepoint`.`TeamSetScore` (
  `teamSetScoreId` INT(11) NOT NULL AUTO_INCREMENT,
  `score` INT(11) NOT NULL DEFAULT '0',
  `gameId` INT(11) NOT NULL,
  `teamId` INT(11) NOT NULL,
  PRIMARY KEY (`teamSetScoreId`),
  CONSTRAINT `fk_teamSetScore_set1`
    FOREIGN KEY (`gameId`)
    REFERENCES `scorepoint`.`Game` (`gameId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_teamSetScore_team1`
    FOREIGN KEY (`teamId`)
    REFERENCES `scorepoint`.`Team` (`teamId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_teamSetScore_set1_idx` ON `scorepoint`.`TeamSetScore` (`gameId` ASC);

CREATE INDEX `fk_teamSetScore_team1_idx` ON `scorepoint`.`TeamSetScore` (`teamId` ASC);


-- -----------------------------------------------------
-- Table `scorepoint`.`TeamHasMatch`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scorepoint`.`TeamHasMatch` ;

CREATE TABLE IF NOT EXISTS `scorepoint`.`TeamHasMatch` (
  `teamId` INT(11) NOT NULL,
  `matchId` INT(11) NOT NULL,
  PRIMARY KEY (`teamId`, `matchId`),
  CONSTRAINT `fk_team_has_match_match1`
    FOREIGN KEY (`matchId`)
    REFERENCES `scorepoint`.`Match` (`matchId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_team_has_match_team1`
    FOREIGN KEY (`teamId`)
    REFERENCES `scorepoint`.`Team` (`teamId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_team_has_match_match1_idx` ON `scorepoint`.`TeamHasMatch` (`matchId` ASC);

CREATE INDEX `fk_team_has_match_team1_idx` ON `scorepoint`.`TeamHasMatch` (`teamId` ASC);


-- -----------------------------------------------------
-- Table `scorepoint`.`userCredential`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scorepoint`.`userCredential` ;

CREATE TABLE IF NOT EXISTS `scorepoint`.`userCredential` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `provider` VARCHAR(512) NULL DEFAULT NULL,
  `authScheme` VARCHAR(512) NULL DEFAULT NULL,
  `externalId` VARCHAR(512) NULL DEFAULT NULL,
  `profile` TEXT NULL DEFAULT NULL,
  `credentials` TEXT NULL DEFAULT NULL,
  `created` DATETIME NULL DEFAULT NULL,
  `modified` DATETIME NULL DEFAULT NULL,
  `userid` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_userCredential_user1`
    FOREIGN KEY (`userid`)
    REFERENCES `scorepoint`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_userCredential_user1_idx` ON `scorepoint`.`userCredential` (`userid` ASC);


-- -----------------------------------------------------
-- Table `scorepoint`.`userIdentity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scorepoint`.`userIdentity` ;

CREATE TABLE IF NOT EXISTS `scorepoint`.`userIdentity` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `provider` VARCHAR(512) NULL DEFAULT NULL,
  `authScheme` VARCHAR(512) NULL DEFAULT NULL,
  `externalId` VARCHAR(512) NULL DEFAULT NULL,
  `profile` TEXT NULL DEFAULT NULL,
  `credentials` TEXT NULL DEFAULT NULL,
  `created` DATETIME NULL DEFAULT NULL,
  `modified` DATETIME NULL DEFAULT NULL,
  `userid` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_userIdentity_user1`
    FOREIGN KEY (`userid`)
    REFERENCES `scorepoint`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_userIdentity_user1_idx` ON `scorepoint`.`userIdentity` (`userid` ASC);


-- -----------------------------------------------------
-- Table `scorepoint`.`UserHasTeam`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scorepoint`.`UserHasTeam` ;

CREATE TABLE IF NOT EXISTS `scorepoint`.`UserHasTeam` (
  `userId` INT(11) NOT NULL,
  `teamId` INT(11) NOT NULL,
  PRIMARY KEY (`userId`, `teamId`),
  CONSTRAINT `fk_user_has_team_user1`
    FOREIGN KEY (`userId`)
    REFERENCES `scorepoint`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_team_team1`
    FOREIGN KEY (`teamId`)
    REFERENCES `scorepoint`.`Team` (`teamId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_user_has_team_team1_idx` ON `scorepoint`.`UserHasTeam` (`teamId` ASC);

CREATE INDEX `fk_user_has_team_user1_idx` ON `scorepoint`.`UserHasTeam` (`userId` ASC);

USE `scorepoint` ;

-- -----------------------------------------------------
-- Placeholder table for view `scorepoint`.`user_stats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `scorepoint`.`user_stats` (`id` INT, `userName` INT, `gameId` INT, `total_sets` INT, `winner_sets` INT);

-- -----------------------------------------------------
-- View `scorepoint`.`user_stats`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `scorepoint`.`user_stats` ;
DROP TABLE IF EXISTS `scorepoint`.`user_stats`;
USE `scorepoint`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `scorepoint`.`user_stats` AS
select `u`.`id` AS `id`,`u`.`userName` AS `userName`,
`g`.`gameId` AS `gameId`,
count(`s`.`setId`) AS `total_sets`,
sum(if((`s`.`teamWinnerId` = `t`.`idTeam`),1,0)) AS `winner_sets`
from ((((((`scorepoint`.`user` `u` join `scorepoint`.`user_has_team` `u_t` on((`u`.`id` = `u_t`.`userid`))) join `scorepoint`.`team` `t` on((`u_t`.`idTeam` = `t`.`idTeam`))) join `scorepoint`.`game` `g` on((`t`.`gameId` = `g`.`gameId`))) join `scorepoint`.`team_has_match` `t_m` on((`t`.`idTeam` = `t_m`.`idTeam`))) join `scorepoint`.`match` `m` on((`t_m`.`idmatch` = `m`.`idmatch`))) join `scorepoint`.`set` `s` on((`m`.`idmatch` = `s`.`idmatch`))) group by `m`.`idmatch`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
